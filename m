Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6772008FF
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 14:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgFSMtz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 08:49:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732295AbgFSMtq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jun 2020 08:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592570984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/g/+YnCzud6gIE/myiatywuh+bgiNOQQZfOvz+r2RZM=;
        b=DJzpqNQL3Ct78b71K3She8S6lrhS3usL8RrHve8/Fe6OvbZlg6mL0+tQcu46JUkXre2a7j
        wCJeM5i67zqeqXPsz5Xb5HA/z0ezPbvt16HNIJ2y+2qfvWOaQ++M8/Hn63ImspXHOc9tbP
        HV9MlLeH/yVCwJNU1bYE/DUE4N0GBAs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-syEXMa-5O6-27WoxKZxk9g-1; Fri, 19 Jun 2020 08:49:42 -0400
X-MC-Unique: syEXMa-5O6-27WoxKZxk9g-1
Received: by mail-lj1-f198.google.com with SMTP id u10so1371859ljk.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 05:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/g/+YnCzud6gIE/myiatywuh+bgiNOQQZfOvz+r2RZM=;
        b=mQk3InzC3kPvspD143zxIvYqD4yC1CebgMcTv3S1tA7mBFSrAVdWOCTvosRpPc4HUA
         RWK3/vRam6yCbIjo654zWRZ6WBYr77yyT4w0Hicm7s6h3jAGYHTricSQT+qGLvE8oyIN
         B6YUK1kNCQ6RofajYnt0sp2bey0/6yo+RSLijoxIwhH2DrbAPKAM8avxIx5UULG5m+vH
         Vr8NugkHMmUMXtNDINXPqFTgX4caqstCVD9zkvdtFAeF3dJxhrgFLwLsSuQpBD4aifET
         C4j5ybTsLdLMK4BoL5HYae3lAa5IzxpPREHr/eQg3wkyl1f5oEgVD3MyEj+qzffS7Lzw
         0Rbw==
X-Gm-Message-State: AOAM533IuayvjP7b+jEOq7IO1fmEZzA2QXb/bZBw4fB3D5SG53pE3rpj
        L79OZoztcv95TlKN85tlIEjFHvhzSoIE00nwSnXv8+mQz+USlgpAfZtbSfjEKqY2sstFLWwWBc4
        JuoEB9Ys+jnUn8SNmPzG1NqfrUGZE
X-Received: by 2002:ac2:5604:: with SMTP id v4mr1946247lfd.124.1592570981116;
        Fri, 19 Jun 2020 05:49:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXiPt6NoxSwMoZyeQFCP8RfJAk3JTg7gTtWYjd2TAO4zxGdEHaGSVd0jZZyRVkg26M9VYhdLJvCgnHGSnzbYY=
X-Received: by 2002:ac2:5604:: with SMTP id v4mr1946227lfd.124.1592570980848;
 Fri, 19 Jun 2020 05:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200520125616.193765-1-kpsingh@chromium.org>
In-Reply-To: <20200520125616.193765-1-kpsingh@chromium.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 19 Jun 2020 14:49:29 +0200
Message-ID: <CAFqZXNsu8Vs86SKpdnej_=xnQqg=Hh132JqNe1Ybt-bHJB4NeQ@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     KP Singh <kpsingh@chromium.org>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 2:56 PM KP Singh <kpsingh@chromium.org> wrote:
> From: KP Singh <kpsingh@google.com>
>
> secid_to_secctx is not stackable, and since the BPF LSM registers this
> hook by default, the call_int_hook logic is not suitable which
> "bails-on-fail" and casues issues when other LSMs register this hook and
> eventually breaks Audit.
>
> In order to fix this, directly iterate over the security hooks instead
> of using call_int_hook as suggested in:
>
> https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
>
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
[...]

Sorry for being late to the party, but doesn't this (and the
associated default return value patch) just paper over a bigger
problem? What if I have only the BPF LSM enabled and I attach a BPF
program to this hook that just returns 0? Doesn't that allow anything
privileged enough to do this to force the kernel to try and send
memory from uninitialized pointers to userspace and/or copy such
memory around and/or free uninitialized pointers?

Why on earth does the BPF LSM directly expose *all* of the hooks, even
those that are not being used for any security decisions (and are
"useful" in this context only for borking the kernel...)? Feel free to
prove me wrong, but this lazy approach of "let's just take all the
hooks as they are and stick BPF programs to them" doesn't seem like a
good choice... IMHO you should either limit the set of hooks that can
be attached to only those that aren't used to return back values via
pointers, or (if you really really need to do some state
updates/logging in those hooks) use wrapper functions that will call
the BPF progs via a simplified interface so that they cannot cause
unsafe behavior.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

