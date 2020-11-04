Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6322A5BE1
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 02:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgKDB1g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 20:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgKDB1g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 20:27:36 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F65C040203;
        Tue,  3 Nov 2020 17:27:35 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id t13so21108122ljk.12;
        Tue, 03 Nov 2020 17:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEAfa71F3RcjJKMcoFNETu5MYla8QPOqFeyC5ZSEg5Y=;
        b=hDViSq+nsPw95gkn0wsOimJQVOF80z7bBZQtasvuxdTX9uF6TYJItlxP8E0B+RqBx+
         0666BcbIgbo+K+Lsjev9FU42BKYlNXxevFJLAw0ZoN5fMOlH9Ar8x1YmmGDbcUXhtvIN
         2Oc5YGGeiQ2VasjcmeUQjTG9bl6+BlfnZr5kJ2EJgo6LdyDDvB70OGf9gUJtzpKUfgvt
         y7xUP1DEBWKQlqLFe0YBt1pmmoVmZt0SRXRzIJh3WyuB6lu+T4gPmqFh/Vz2TCxzdUP1
         B+Yf+n9RyFgEffu2CGJn9vIIxesWIOwMNj0+3obL8F7oBwCOwQemNxdaWJnNL7Yh5bPJ
         E0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEAfa71F3RcjJKMcoFNETu5MYla8QPOqFeyC5ZSEg5Y=;
        b=NxLRenwI0jw0/v32HPp2Zhkjg6+Tr+VhVl65FyOSUG6QeEEyueF4FeTB3Fg3iQm1x/
         zG2unwWQx5Ebz2DHh8/lWgPMILahax5cGw6RpuksucK40bveiwzmCxhqz8bHJyB68Yfm
         0YfZCu4Nl6sGuhSDFBPZ+O7sPtLfSQJOt8nATONgyMsoKit9+joA0MQhMtH7AAePBXEJ
         sY4HsMJIwvw5IG95rreE4mpfD5fAvBY4i7FXAJEYZJ78XQeDiAKsuZrusDBSgwduGCWu
         XW/bnkJ8NLafF+LpEJi5BpMV/jRVyr8YkrWDj4FCQ7ewnzpg0DE8EKa10906ZZ343cNl
         O/rg==
X-Gm-Message-State: AOAM531ynCtxdHFO6rvU/f2/6WXTVw+uCXf1CajWuBevdt8A+wFKpoO1
        G567UP7fyzn7Y7EXqyyT7ssibfHpBA7+iidwKE4=
X-Google-Smtp-Source: ABdhPJzoRhezbY7tyeiJ3/1HM6PGOTDEIJw8OZsS7jJK1vVvt8ivJFZtiIeNgg8x/gTCMlGll3RhY+d1FH+bUGkH3Y4=
X-Received: by 2002:a2e:b0f8:: with SMTP id h24mr9997538ljl.2.1604453254171;
 Tue, 03 Nov 2020 17:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org> <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
 <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com> <CACYkzJ6D=vwaEhgaB2vevOo0186m=yfxeKBQ8eWWck8xjtczNA@mail.gmail.com>
In-Reply-To: <CACYkzJ6D=vwaEhgaB2vevOo0186m=yfxeKBQ8eWWck8xjtczNA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 3 Nov 2020 17:27:22 -0800
Message-ID: <CAADnVQ+DBHXkf8SFwnTKmSKi7mdAx56dWbpp5++Cc02CQjz+Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 4:05 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On Tue, Nov 3, 2020 at 7:59 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On Tue, Nov 3, 2020 at 7:47 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Nov 03, 2020 at 04:31:31PM +0100, KP Singh wrote:
> > > > +
> > > > +struct storage {
> > > > +     void *inode;
> > > > +     unsigned int value;
> > > > +     /* Lock ensures that spin locked versions of local stoage operations
> > > > +      * also work, most operations in this tests are still single threaded
> > > > +      */
> > > > +     struct bpf_spin_lock lock;
> > > > +};
> > >
> > > I think it's a good idea to test spin_lock in local_storage,
> > > but it seems the test is not doing it fully.
> > > It's only adding it to the storage, but the program is not accessing it.
> >
> > I added it here just to check if the offset calculations (map->spin_lock_off)
> > are correctly happening for these new maps.
> >
> > As mentioned in the updates, I do intend to generalize
> > tools/testing/selftests/bpf/map_tests/sk_storage_map.c which already has
> >  the threading logic to exercise bpf_spin_lock in storage maps.
> >
>
> Actually, after I added simple bpf_spin_{lock, unlock} to the test programs, I
> ended up realizing that we have not exposed spin locks to LSM programs
> for now, this is because they inherit the tracing helpers.
>
> I saw the docs mention that these are not exposed to tracing programs due to
> insufficient preemption checks. Do you think it would be okay to allow them
> for LSM programs?

hmm. Isn't it allowed already?
The verifier does:
        if ((is_tracing_prog_type(prog_type) ||
             prog_type == BPF_PROG_TYPE_SOCKET_FILTER) &&
            map_value_has_spin_lock(map)) {
                verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
                return -EINVAL;
        }

BPF_PROG_TYPE_LSM is not in this list.
