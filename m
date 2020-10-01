Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12012803C0
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgJAQTL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 12:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbgJAQTL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 12:19:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EFEC0613D0;
        Thu,  1 Oct 2020 09:19:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k13so5015178pfg.1;
        Thu, 01 Oct 2020 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJEN6/5FxUZ7OvX1MfoZIJYkf9njQgwG4hA1l6IMw0I=;
        b=kKCa/HMcidopfQYMgG1MnaV4E7MWeG0ZNU2ueVB6Ep4OYWvKYggKjzJkKTPBYAwfmU
         gDmiCAvNG6U+UyrWHMC4lpV7wI+FQ0u/iuWVHEVsOvXRxPjp1V7PkDYtTs4wIJpOrMVY
         F/3NMyqKUlnHboeHra8Rz17oKGWWKqsgaVoSUVOG4Zp89vGQNUvWDuGQjdA9/qD2wZSl
         ERDpbN98d5N105oqojlolCytrAGPVuFQ7PRqf7i7o2t6B0UxU5SFS2kokt4F4x/GxFLm
         VoBTG8G+9voKvVPNpHrJo425NMhCQOl3OlYzCiG/TGFTFIkIxGMpvQ85PMuSX5eq4u0C
         nArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJEN6/5FxUZ7OvX1MfoZIJYkf9njQgwG4hA1l6IMw0I=;
        b=UVAXriNg5ky77JftuTaZ/G/FyIWFFpCD8hkYT2HFmxB4cdIXiAUkQE0+94v238Wv0M
         E0fqxqLmT555wOGzl1G65DSR1j1EkrN2xnwahfiLoBj0sQ5BQqIPJPZS+Qk6xycgG8mY
         IZxN8CW7D3+I0zNtFHhmnyC6/3neKQYR73d+bTy08kxE5dip7MhHLk4JauRARd10fMTI
         asFdOs0xTyV2uLU3xApry7iEuowkr94BcxhDv8e0gI5XFsYzFAIlfOQApNBiTshLM25+
         /5UJh+7+1dRfI4JZ8C1Wz891Cr/ZMWKYnuTni+RCJEmoZACg99O/XoppW0LvVP+lcBkD
         QSSw==
X-Gm-Message-State: AOAM5305OXWqfOz6z9ex6ayf+uqzgZMoV+NznFXN2EbtF4KcUgXotmTh
        UL41DEj7k2DCrqx11wmByKp05PfBdjtttH4PiEU=
X-Google-Smtp-Source: ABdhPJyjU9K2yAHHlgJFP8jH9bKHRFNEu8FPzsXId8yBn7IKSN8taOEKNIEPNUGKxDexWM2C51Vpy6MLxd3XFzl9Z4c=
X-Received: by 2002:a63:5043:: with SMTP id q3mr6682178pgl.293.1601569150444;
 Thu, 01 Oct 2020 09:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
 <CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNiEg0qbD3w@mail.gmail.com>
 <CABqSeATEMTB_hRt9D9teW6GcDvz4VLfMQyvX=nvgR4Uu4+AgoA@mail.gmail.com> <CAG48ez3nqG_O3OYLLffVOcFf+ONgFwU9mc+HZ1GixBPbHZLyvw@mail.gmail.com>
In-Reply-To: <CAG48ez3nqG_O3OYLLffVOcFf+ONgFwU9mc+HZ1GixBPbHZLyvw@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 1 Oct 2020 11:18:59 -0500
Message-ID: <CABqSeATH+n5EdxboQWz84oFYkAnkbAgnjU4irBDqJPTLdExTHA@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Jann Horn <jannh@google.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 11:05 AM Jann Horn <jannh@google.com> wrote:
> Yeah.
>
> The ONE() entry you're adding to tgid_base_stuff is used to help
> instantiate a "struct inode" when someone looks up the path
> "/proc/$tgid/seccomp_cache"; then when that path is opened, a "struct
> file" is created that holds a reference to the inode; and while that
> file exists, your proc_pid_seccomp_cache() can be invoked.
>
> proc_pid_seccomp_cache() is invoked from proc_single_show()
> ("PROC_I(inode)->op.proc_show" is proc_pid_seccomp_cache), and
> proc_single_show() obtains a temporary reference to the task_struct
> using get_pid_task() on a "struct pid" and drops that reference
> afterwards with put_task_struct(). The "struct pid" is obtained from
> the "struct proc_inode", which is essentially a subclass of "struct
> inode". The "struct pid" is kept refererenced until the inode goes
> away, via proc_pid_evict_inode(), called by proc_evict_inode().
>
> By looking at put_task_struct() and its callees, you can figure out
> which parts of the "struct task" are kept alive by the reference to
> it.

Ah I see. Thanks for the explanation.

> By the way, maybe it'd make sense to add this to tid_base_stuff as
> well? That should just be one extra line of code. Seccomp filters are
> technically per-thread, so it would make sense to have them visible in
> the per-thread subdirectories /proc/$pid/task/$tid/.

Right. Will do.

YiFei Zhu
