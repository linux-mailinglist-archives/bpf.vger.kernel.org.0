Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD57216051
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGFUbC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGFUbB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 16:31:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A142C061794
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 13:31:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so39632339wrw.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=b00l0G+v45Z6tIxVmpU8zc8V+eHm6VMqCzw//xyzaXg=;
        b=Ac/VoY7BZFHgX6kKaPiIAhNAqsNuZHFvXEVjQHFhp+JipFaTKiLwOCsJichH8N/rmV
         fgxylTgGY1CHeSyVq4+h4/u1lbaRFBUMmVw7qS1zxFtuN9wZBumR9qzyWD4CPpANWweN
         uncBbqUzwecZP1Z4mjyC429r2imOn/w4Sj1Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=b00l0G+v45Z6tIxVmpU8zc8V+eHm6VMqCzw//xyzaXg=;
        b=kZYIQvrAhU9sPT/QXJNdCdPRA4ljWn4nT4E27SK2vdflUXRIVCFH7X93vZkS0nVtZC
         o8wY6551xnSusmN//kq7yRWVtfP/W4UN3zAgP4cYWHXzoJCXoseTEmNvfOGXq1llFDmI
         czOzjYl/4bmIW3pXctRvFzYBBtkBiNiZfK30CLdagl5Ax1yNbeDOdMhamygCLELt0E98
         8dmOZ1sGFSZeAhp9dWPummpEts6epcamukbDmNI8S7V9YFfzKgsAGOo3mnqe+0DQgjKS
         8T1eoCBH1lu6t35pSdpI6UvQZvri+5VVjIPytHh8YtupNzxv/nqwYX2QZXU5fCY3wSjM
         UJrg==
X-Gm-Message-State: AOAM533bRO1215Hz4cOkZcZah8OoHheNOdrNupAL6RohXdNhnuO3mRBH
        POhd+rr84AHoBUs9IMVBcc0evpHNkcliraBsaFoqw9gkedY=
X-Google-Smtp-Source: ABdhPJxzqxg7ODsjN+Zw2qrFp2pSD2AUwlJkUrE9/Usg4o1cF+hyARDxBZjq1GBWd1Rya+aGg5GqVYj4DfYfMvkxVWg=
X-Received: by 2002:a05:6000:86:: with SMTP id m6mr17934611wrx.173.1594067459857;
 Mon, 06 Jul 2020 13:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200706165710.GA208695@gallifrey> <9268bd47-93db-1591-e224-8d3da333636e@iogearbox.net>
 <CACYkzJ78HOP8SZ3jU0DnH0b4f8580AuP4fdG5K3xgaHa8VYaZw@mail.gmail.com> <20200706200640.GA234619@gallifrey>
In-Reply-To: <20200706200640.GA234619@gallifrey>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 6 Jul 2020 22:30:49 +0200
Message-ID: <CACYkzJ7sT=9+z8Gvee-ewT86T-HN24Xri1zYeeiOQiumNsCRJQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: lsm: Disable or enable BPF LSM at boot time
To:     Lorenzo Fontana <fontanalorenz@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 6, 2020 at 10:06 PM Lorenzo Fontana <fontanalorenz@gmail.com> wrote:
>
> On Mon, Jul 06, 2020 at 08:59:13PM +0200, KP Singh wrote:
> > On Mon, Jul 6, 2020 at 8:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >
> > > On 7/6/20 6:57 PM, Lorenzo Fontana wrote:
> > > > This option adds a kernel parameter 'bpf_lsm',
> > > > which allows the BPF LSM to be disabled at boot.
> > > > The purpose of this option is to allow a single kernel
> > > > image to be distributed with the BPF LSM built in,
> > > > but not necessarily enabled.
> > > >
> > > > Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> > >
> > > Well, this explains what the patch is doing but not *why* you need it exactly.
> > > Please explain your concrete use-case for this patch.
> >
> > Also, this patch is not really needed as it can already be done with the current
> > kernel parameters.
> >
> > LSMs can be enabled on the command line
> > with the lsm= parameter. So you can just pass lsm="selinux,capabilities" etc
> > and not pass "bpf" and it will disable the BPF_LSM.
> >
> > - KP
> >
> > >
> > > Thanks,
> > > Daniel
>
> Hi,
> Thanks Daniel and KP for looking into this, I really appreciate it!
>
> The *why* I need it is because I need to ship the kernel with BPF LSM
> disabled at boot time.
>
> The use case is exactly the same as the one described by KP, however
> for a personal preference I prefer to pass specifically bpf_lsm=1 or
> bpf_lsm=0 - It's easier to change programmatically in my scripts
> with a simple sprintf("bpf_lsm=%d", value). I do the same
> with "selinux=1" and "selinux=0" in my systems.
> From what I can see by reading the code and testing, the two ways
> bot act on 'lsm_info.enabled' defined in 'lsm_hooks.h'.
> So it's not just  a personal preference, I just want the same set
> of options available to me as I do with selinux.

The "selinux=" option existed before the "lsm=" parameter was added and it
now exists only for backward compatibility. I added Paul and Stephen to Cc
who might have more information about this.

- KP

>
> Thanks a lot,
> Lore
