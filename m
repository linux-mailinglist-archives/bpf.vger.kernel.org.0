Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA322110BA
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbgGAQbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbgGAQbc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 12:31:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B3C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 09:31:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so27903727ljo.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSHvr1Kf3xLzuFmRv0W8M6k01WCF5WgUDal5ShydcIU=;
        b=bGgu/5MrpQkK5sEkVNem7sblpg+46CTBLwWbyLdJzDIoEHwpGMU5ryuTKNgI+NZops
         sWac32wTAEWeaOrnVxeEFPz1S3Neve5Yw7UuDWkeCFaevkRejYV13TEFY4S/Yy//YTHY
         ReeLtD/gelCdd/U7JhjJcecMe0Mt14YtfRLxAvSyBuXDm2oQ4lwEG4dJ+zPdImAsO2v6
         i5+zZQOE5K2eL21a901GFqHkmqO8+F/vQQNOfWNxQAbNUUkE4Rs/4QI6hBeEPf+YZ2YI
         LA+pnQGHg5yfyZIYho3ZjgEkAIRwPEOi9qfALIW/pM4qaHy9QLyD0TMUyGSXLADXog3H
         PImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSHvr1Kf3xLzuFmRv0W8M6k01WCF5WgUDal5ShydcIU=;
        b=jQ+j2ICa20+CwiazXEFSMWFzNPIyqTSlw5cB+hFjkjj0Wotpd9VuiWmDKcN28ifeWr
         ckYVs2Q7UMl4gXHOZthxERpxVKrF/frR0PW2WMjPG+uIEqBrrZ0iDsOcVkLwwyQcmMoy
         Mnxnu5H2M2lI4kAgScrx327pXnTw9OwDcUvGvywAA3yV0cys3fgjeBh4CK8N7RBr65Go
         OXknmDUfeZWDOpwcdeVR3AcvULcyw5HP9V1w8IdROjnZKuU9y8kkZVrLR7+9nJZ7o46w
         XjdMtyxX6m3OZpRe0ANhchN4ljE/47IlLvHXSbAwDAWepf5qE+4fMkZb+qzmnsazNCQY
         ypxQ==
X-Gm-Message-State: AOAM531JJ1yU75AbbZ5Fe8y1Z6Xb0WosVlobiWKRXm7zuMc9nf/cmsyd
        1O0YXjTjGAVsp5aZ+KcOR5JcwTdMTjLiXd65PcQ=
X-Google-Smtp-Source: ABdhPJydiIPupU6b5vIZWc7wV++BA25eLbn/EfC8sIUDiV3Zsj0ukqMDnxkTvXiZ78CqllgVP/FCXMcFdF7F6ISyW90=
X-Received: by 2002:a2e:9193:: with SMTP id f19mr2196056ljg.91.1593621090119;
 Wed, 01 Jul 2020 09:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <159353162763.912056.3435319848074491018.stgit@firesoul>
 <CAEf4BzZ-Ryq+i1ez3Q8G1js6tuD8niAejJzA5Gf7N-vS=6AE_g@mail.gmail.com>
 <20200630223224.16fb2377@carbon> <CAEf4BzYqojkRHQGszn0jcQEx6jYMvx3fZV4BERn5zeO-AxBjSQ@mail.gmail.com>
 <CAADnVQJmz461mcv4MBq40jtHBzeX0FgpFaQW3XLB0=U6Y3WgGw@mail.gmail.com> <20200701182319.55a7c392@carbon>
In-Reply-To: <20200701182319.55a7c392@carbon>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Jul 2020 09:31:18 -0700
Message-ID: <CAADnVQKuQmRi4cdTfo08-C--W2C7gSpdUy72rXT9Uw-xWYN_4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs option for listing
 test names
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 9:23 AM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> On Wed, 1 Jul 2020 08:36:08 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Tue, Jun 30, 2020 at 2:19 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Jun 30, 2020 at 1:32 PM Jesper Dangaard Brouer
> > > <brouer@redhat.com> wrote:
> > > >
> > > > On Tue, 30 Jun 2020 08:46:01 -0700
> > > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > > > @@ -688,9 +700,17 @@ int main(int argc, char **argv)
> > > > > >                         cleanup_cgroup_environment();
> > > > > >         }
> > > > > >         stdio_restore();
> > > > > > +
> > > > > > +       if (env.list_test_names) {
> > > > > > +               if (env.succ_cnt == 0)
> > > > > > +                       env.fail_cnt = 1;
> > > > > > +               goto out;
> > > > > > +       }
> > > > > > +
> > > > >
> > > > > Why failure if no test matched? Is that to catch bugs in whitelisting?
> > > >
> > > > I would not call it catch bugs, but sort of.  The purpose is to know if
> > > > requested test is valid.  This can be used to e.g. run through all the
> > > > tests numbers, and stopping when a test number (-n) is no-longer valid,
> > > > by using this shell exit value as a test, like:
> > > >
> > > >  n=1;
> > > >  while [ $(./test_progs --list -n $n) ] ; do \
> > > >    echo "./test_progs -n $n" ; n=$(( n+1 )); \
> > > >  done
> > > >
> > > > Notice that this features that be used for looking up a test number,
> > > > and returning a testname, which was the original request from CI.  I
> > > > choose this implementation as it more generic and generally useful.
> > > >
> > > >  $ ./test_progs --list -n 89
> > > >  xdp_adjust_tail
> > > >
> > >
> > > Yeah, it has a nice querying effect. Makes sense.
> > >
> > > Acked-by: Andrii Nakryiko <andriin@fb.com>
> >
> > hmm. it doesn't apply.
> > Applying: selftests/bpf: Test_progs option for listing test names
> > error: sha1 information is lacking or useless
> > (tools/testing/selftests/bpf/test_progs.c).
> > error: could not build fake ancestor
> > Patch failed at 0001 selftests/bpf: Test_progs option for listing test names
>
> It doesn't apply because it depend on my previous changes, that Daniel
> said he applied:
>
>  https://lore.kernel.org/bpf/6e7543fa-f496-a6d2-a6d5-70dff9f84090@iogearbox.net/
>
> But I can see that it is not in the net-next git tree.

oops. sorry about this.
I guess to due taking out Jakub's set out of bpf-next and moving into bpf
some patches got lost. :(

> > Could you please respin.
>
> I will respin together with the other unapplied patch.  Which is
> actually fine, as I have an improvement for the previous patch, that I
> can squash.

Awesome. thanks
