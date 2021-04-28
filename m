Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0636D5E0
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 12:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhD1Kkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 06:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhD1Kkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 06:40:37 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C5C061574
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 03:39:51 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id q4so17956854qtn.5
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUelH6eDva+cnXl8LepYIVYPnxHmV2Csm8CjEXGPO5U=;
        b=tum0xtwSRFoNKdJECk2Hjf4s52z3nPfIPgoBgFw9RKsO2Aq0UftJwvtxwTZaSirWWq
         C/TQDPiwttP1zcF+6DRJGVxKrxROSSrCuQOXu7QAtUUyQwuPoH1/7JEOK2KJojf1TbA5
         BSIbjK6Z2a0ZnJmSlV59Lxzx3zF2wiucDd1h7rnGvnwqaIqNDNHxOpwuVst+GlPy66Da
         B5atf2n/yYnaSyn4Jqa/PaBavDy5wS5ONv9OpCVqUSuF/wgBbS/twhMwifrHXA7lFHCS
         /y7wNwxOKe+T5ub7myD+0adxVsLl1l8UM2fdP0Y8Vl3zGhenp19rZkU+n1YNb3GYpYyP
         prig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUelH6eDva+cnXl8LepYIVYPnxHmV2Csm8CjEXGPO5U=;
        b=osF1nzXZirOeKUHXgX0DeEM7zmOixEBXo6zMSSIi5u9voU4+ywgRr5I88BkU4eUET1
         WHa1giA/m3Z2a19ycV+Uh+i9QoIRZdIRvFFNaZTi4HQauQHYdKLxrgrGf6mh3NvnuysK
         r/XA8pBMXrMKL8Dlmr020fzCvEN/XD0EWAFiBa8D2HGdlq4VPwb7khZ90yrBgd2sbkwj
         6ErCbeG15lom1R6y249PJ+ZVyYAMV+kLEU0QJTozB5YLAzOisEqyFiSphbUMvlBEEUbM
         Xr6bBuViyEUjxihb088TYzoKliS7Umh0kjadZDsKqi8RAppamA9U+SwMeEldsBXIGSXE
         kl3w==
X-Gm-Message-State: AOAM530qewr82uAV81wx7DYYnRwzKqRWVF92QVLtdnBYfaOKH5Vets+g
        xV/bE1sJEjvN3UE3G2Zo88QLOPEg5Up7BZI8iA==
X-Google-Smtp-Source: ABdhPJy9O4X+8r1AUDJQlcsKQqr9GuMmWGUjDwzA0ojawSFgZYSo+yb8VmpHmME+N4tPGPLvx3Nc5S4czWbA0qaEDMs=
X-Received: by 2002:ac8:5283:: with SMTP id s3mr16265328qtn.66.1619606389780;
 Wed, 28 Apr 2021 03:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210427135550.807355-1-joamaki@gmail.com> <20210427135550.807355-2-joamaki@gmail.com>
 <CAEf4BzZ8iQ=ewupN0COpV78k+fhGvPZ4NHcqckZcQcmV=A6QXw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8iQ=ewupN0COpV78k+fhGvPZ4NHcqckZcQcmV=A6QXw@mail.gmail.com>
From:   Jussi Maki <joamaki@gmail.com>
Date:   Wed, 28 Apr 2021 12:39:39 +0200
Message-ID: <CAHn8xckARwp_yK477xTvzFCwU9oBwAoZ4D2erg6HRmoe5in3Xg@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for bpf_skb_change_head
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 11:41 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > ...
> > +test_tc_peer_user
>
> can we make it into a reasonable test inside test_progs? that way it
> will be executed regularly

There doesn't seem to be any tests yet for redirect_peer in test_progs and I'd
like this test to live next to them. Would it make sense to rework
test_tc_redirect.sh
into the test_progs framework?

What's your thoughts on this Daniel?

> >
> > +SEC("src_ingress_l3") int tc_src_l3(struct __sk_buff *skb)
>
> please keep SEC() on separate line
>
> also, is this a BPF_PROG_TYPE_SCHED_CLS program? Can you usee libbpf's
> "classifier/src_ingress_l3" naming convention?

I'm following the conventions in that file. Should they all be
changed? Happy to do that.

> > +{
> > +       __u16 proto = skb->protocol;
> > +
> > +       if (bpf_skb_change_head(skb, ETH_HLEN, 0) != 0)
> > +               return TC_ACT_SHOT;
> > +
> > +       __u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
>
> we try to keep BPF code compliant with C89, so please move all the
> variable declaration into a single block at the top of a function

Will fix, thanks.

> > +void setns_by_name(char *name) {
>
>
> { should be on a new line
>
> please run scripts/checkpatch.pl on these files, it will point out
> trivial issues like this

Sorry about that. Will make sure I'll run it on all future submissions.

> > +       int nsfd;
> > +       char nspath[PATH_MAX];
> > +
> > +        snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
> > +        nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> > +        if (nsfd < 0) {
> > +               fprintf(stderr, "failed to open net namespace %s: %s\n", name, strerror(errno));
> > +               exit(1);
> > +        }
>
> here seems to be a mix of tabs and spaces

Thanks, will fix it and my editor's settings ;-).
