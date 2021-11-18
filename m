Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EBC45518F
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 01:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbhKRASi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 19:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbhKRASi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 19:18:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22246C061570
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:15:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so18820271edv.1
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+58f0SyQ3Lb12arfHudpznsJpM8EH8QJRhqC+3D+/o=;
        b=GIK/XZDC7ZNVXEqtZ+tcRvrXQwqh/3lJY4yq2xqMR5g4v4WHdHdxBBddnKCXAxjOPb
         D4LDriIwmMmUqzawd5iS2gHre59nN6Ls/L0plgWyRkjMH6wccNzKmXtgD3O8sgwqJg2Q
         rLVrPCOoHEuMVi4eKbaeBXjnaPlOpyQXvrK0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+58f0SyQ3Lb12arfHudpznsJpM8EH8QJRhqC+3D+/o=;
        b=PxLnd+VSZrqCgNvu0gfduJGL2ZozZtahAdglGqcpBs1dJ6llfgnWf53VhaC7EwUdhD
         1zQ/cqkE7a+tUFPtX6vFODR6Os0SMRjykEzZkAfH6xeD5IYjnmdXTGADY2o9y/Cy/mao
         WfQ0T4YmoMwqwvlnNu063O42JFV3Pbvpy7x2MqWlb/Etx3PSszMhmgIKPe7WYbNIUdwR
         f8tb8YoWC6JYnGz2lMY2AWetnhhNcUIz2gXRJyRpJP/l6thEbIXIkOz72ccGKaAM0ont
         Baz8exdcvEdbI2a8xk812awvFDHy0OK5DzF2AXl0R/Pm4foRVUUCbJzwmcTNrXv+qjZQ
         kyCg==
X-Gm-Message-State: AOAM532U3SBM0hAFdJe0lIAbFdzBAETEznVel0XfEI16eUOtPMTH8Bs4
        fNaybtJAuyCb2orN87EmTaGGLmX8KyTKbaCc
X-Google-Smtp-Source: ABdhPJyrKfn8AAWy0ORLQ7JwBJjfIDCAw2GeMm8O8Pa8f5dJECWOQgrkr+ILApf3xEELJU2nyH+ztQ==
X-Received: by 2002:a17:907:9690:: with SMTP id hd16mr27294682ejc.297.1637194537764;
        Wed, 17 Nov 2021 16:15:37 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id u14sm686789edj.74.2021.11.17.16.15.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 16:15:37 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id d24so8018226wra.0
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:15:37 -0800 (PST)
X-Received: by 2002:adf:d082:: with SMTP id y2mr24843502wrh.214.1637194537139;
 Wed, 17 Nov 2021 16:15:37 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com> <202111171603.34F36D0E01@keescook>
In-Reply-To: <202111171603.34F36D0E01@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 16:15:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsyDcohs=i0XGu0GRb6AkXUNyWCE_f6JMy0RY9wdXUXg@mail.gmail.com>
Message-ID: <CAHk-=wjsyDcohs=i0XGu0GRb6AkXUNyWCE_f6JMy0RY9wdXUXg@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kyle Huey <me@kylehuey.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 4:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> (nit: should the "sigdfl" argument be renamed "immutable" for clarity
> in this function?)

I don't think that would necessarily clarify anything. Neither
"sigdfl" nor "immutable" makes at least me go "Ahh, that explains
things".

Both "sigdfl" and "immutable" are about random internal implementation
choices ("force SIGDFL" and "set SA_IMMUTABLE" respectively).

I think naming things by random internal implementation things is
questionable in general, but it's particularly questionable when they
aren't even some really fundamental thing.

I think you generally want to name things not by how they do
something, but by *WHAT* they do.

So I think the proper name for it would be "fatal" or something like
that. It's basically saying "This signal is fatal, even if you have a
handler for it or not". That "set it to SIGDFL" just happens to be how
we made it fatal.

And then we should perhaps also make such a signal uncatchable by the
debugger (rather than just "debugger cannot undo or modify it" like
the SA_IMMUTABLE bit does).

Anybody want to take on that renaming / uncatchable part? Please take
my (now at least tested by Kees) patch and make it your own.

              Linus
