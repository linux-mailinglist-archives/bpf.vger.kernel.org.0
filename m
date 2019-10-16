Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0250D8F17
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392660AbfJPLQS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Oct 2019 07:16:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390947AbfJPLQS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Oct 2019 07:16:18 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67B6BC04DBCD
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2019 11:16:17 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id p14so4324704ljh.22
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2019 04:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f1P4flUp3Wl1gdqrt+SyvOCyMYlMRDjagEP3QoJCKhw=;
        b=pbzVyEI8pnIFZs7C7cvYjdrrE+JEcrCGZI0nNeCBEGQtpSIx0rjOt2xcMcpUvAMhDJ
         kLVXGrL5X1T89TFap8Wx24geHL6b9+UeqX/Yl8XPiABZreSIP3TxLLNg9+EIEb6TTwt+
         4uFprOZKzqn4GgyGsFLBAia+wcD0CDWBjIuOOR7idgbKXc4ziF89g/qJsUcXMfMKwXl7
         LIQOSRhY4ibnEeUNyFRnj6KDrKjamRHdAs8LCxUwN9a79lsQo8+7/p+MZL13yHIfSYw5
         HIz7OeJvm7gOObKoyS+h6nGz5rOxBSbEz6VNN33i4pfsEWcCbiL66PKoDFpcJSXZ6iFG
         OuZw==
X-Gm-Message-State: APjAAAX8HtWPRwosQ9mPqV+SHCO3QgWjquSJDHDcivn6AWwZOb6sDdDc
        1nN1Cki5zoKL8l8byrfpjndqhewfpDFXTPyIRS7ymSS4OJscBtRFYHc85m0OlRcfJNwVs9Pzcro
        vsuDVGqQfQDuN
X-Received: by 2002:ac2:46d9:: with SMTP id p25mr12048015lfo.174.1571224575864;
        Wed, 16 Oct 2019 04:16:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsLl5A1LikwescJ0PxkpYMBAwSH3nW2xMVZ4odwYnPfJJRvCyNrXw2KSJLGfbHvfsTQgRgHg==
X-Received: by 2002:ac2:46d9:: with SMTP id p25mr12047980lfo.174.1571224575552;
        Wed, 16 Oct 2019 04:16:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 4sm6274180ljv.87.2019.10.16.04.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 04:16:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B2B281800F4; Wed, 16 Oct 2019 13:16:13 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Support chain calling multiple BPF programs after each other
In-Reply-To: <20191016103501.GB21367@pc-63.home>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1> <157046883614.2092443.9861796174814370924.stgit@alrua-x1> <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com> <87sgo3lkx9.fsf@toke.dk> <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com> <87o8yqjqg0.fsf@toke.dk> <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com> <87v9srijxa.fsf@toke.dk> <20191016022849.weomgfdtep4aojpm@ast-mbp> <20191016102712.18f369e7@carbon> <20191016103501.GB21367@pc-63.home>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 16 Oct 2019 13:16:13 +0200
Message-ID: <878splgcua.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:
> We do use cls_bpf heavily in Cilium, but I don't necessarily agree on
> the notorious difficult to use aspect (at least for tc + BPF): i) this
> is abstracted away from the /user/ entirely to the point that this is an
> implementation detail he doesn't need to know about, ii) these days most
> access to these hooks is done programmatically, if this is a worry, then
> lets simply add a cls_bpf pendant for APIs like bpf_set_link_xdp_fd() we
> have in libbpf where you only pass in ifindex, direction (ingress/egress)
> and priority of the program so that underneath it sets up cls_act qdisc
> with a cls_bpf instance that makes the whole thing foolproof, e.g.:
>
>   int bpf_set_link_tc_fd(int ifindex, int fd, enum bpf_tc_dir dir,
>                          __u32 priority, __u32 flags);

Basically, what I'm trying to achieve with XDP chain calls is to be able
to do something similar to this, but for XDP programs. Just with the
added ability to also select on return code...

>> Second, the multiple "independent programs", are actually not
>> independent, because the current running program must return
>> TC_ACT_UNSPEC to allow next bpf-prog to run.  Thus, it is not really
>> usable.
>
> I'd argue that unless the only thing you do in your debugging program is
> to introspect (read-only) the packet at the current point, you'd run into
> a similar coordination issue, meaning, the "independent programs" works
> for simple cases where you only have ACCEPT and DROP policy, such that
> you could run through all the programs and have precedence on DROP.
>
> But once you have conflicting policies with regards to how these programs
> mangle and redirect packets, how would you handle these?

I imagine that in most relevant cases this can be handled by convention;
the most obvious convention being "chain call on XDP_PASS". But still
allowing the admin to override this if they know what they are doing.

> I'd argue it's a non-trivial task to outsource if /admins/ are
> supposed to do manual order adjustments and more importantly to
> troubleshoot issues due to them. Potentially debugging hooks would
> make that easier to avoid recompilation, but it's more of a developer
> task.

Sure, in the general case this could become arbitrarily complex; but I
think that the feature can still be useful.

> Often times orchestration tools i) assume they just own the data path
> to reduce complexity in an already complex system and ii) also keep
> 'refreshing' their setup. One random example for the latter is k8s'
> kube-proxy that reinstalls its iptables rules every x sec, in order to
> make sure there was no manual messing around and to keep the data path
> eventually consistent with the daemon view (if they got borked).

This is actually the reason I want the kernel state to be the source of
truth (instead of keeping state in a userspace daemon). If the kernel
keeps the state it can enforce consistency, whereas a userspace daemon
has to be able to deal with things in the kernel changing underneath
it...

> How would you make the loader aware of daemons automatically
> refreshing/ reconfiguring their BPF progs in the situation where
> admins changed the pipeline, adding similar handle as tc so whoever
> does the 'chain' assembly know which one to update?

My idea for this was to implement atomic updates in the form of a
"cmpxchg" type of operation. I.e., we'd add a parameter to the syscall
where userspace could say "I want to install this program in place of
this one", and if that "old program" value doesn't match the current
state of the kernel, it can be rejected, atomically.

-Toke
