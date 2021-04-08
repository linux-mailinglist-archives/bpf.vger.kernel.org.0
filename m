Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93796358292
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhDHL7t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 07:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhDHL7s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 07:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617883177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qijMefmIa45ZdhR9YEweDU07OhF4NJOr6eTWwpRgQ2g=;
        b=QqeJZLoWRdSzapiBNkTVNjFffQpPVHcOjxbmPpB746ShGRcHDsjvJeuBtxzR8ngJuo+jaG
        eOcf7aJy4Qu/nYRzD7fEkzcA3R4KjsjiaQDRl9eVejhOITFw1ZXERD2dO5vUmK2AJPy7w3
        z2Bq1GOWbF3pz4GMKcL4AjNyYDIEFO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-mH7BT3bLOV2DNUAMcevOqw-1; Thu, 08 Apr 2021 07:59:35 -0400
X-MC-Unique: mH7BT3bLOV2DNUAMcevOqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DECA107ACC7;
        Thu,  8 Apr 2021 11:59:32 +0000 (UTC)
Received: from krava (unknown [10.40.195.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3EC4D5D71D;
        Thu,  8 Apr 2021 11:59:25 +0000 (UTC)
Date:   Thu, 8 Apr 2021 13:59:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCHv2 bpf-next 5/5] selftests/bpf: Test that module can't be
 unloaded with attached trampoline
Message-ID: <YG7wHWVArOvUPkyn@krava>
References: <20210406212913.970917-1-jolsa@kernel.org>
 <20210406212913.970917-6-jolsa@kernel.org>
 <CAEf4BzYnr=r-+iYaZ9yoTgRCs7h0mNo=rjg6S2OAYRkDdPniJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYnr=r-+iYaZ9yoTgRCs7h0mNo=rjg6S2OAYRkDdPniJA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 07, 2021 at 04:04:48PM -0700, Andrii Nakryiko wrote:
> On Wed, Apr 7, 2021 at 4:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test to verify that once we attach module's trampoline,
> > the module can't be unloaded.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> To be fair, to test that you are actually testing what you think you
> are testing, you'd have to prove that you *can* detach when no program
> is attached to bpf_testmod ;) You'd also need kern_sync_rcu() to wait
> for all the async clean up to complete inside the kernel. But that
> doesn't interact with other tests well, so I think it's fine.

well without the kernel change the module gets unloaded
and the test below fails.. we could add module unload
test, but as you described it could probably interfere
with other tests

> 
> grumpily due to CHECK() usage (please do consider updating to ASSERT):

ok, will check

thanks,
jirka

> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  .../selftests/bpf/prog_tests/module_attach.c  | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> > index 5bc53d53d86e..d180b8c28287 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> > @@ -45,12 +45,18 @@ static int trigger_module_test_write(int write_sz)
> >         return 0;
> >  }
> >
> > +static int delete_module(const char *name, int flags)
> > +{
> > +       return syscall(__NR_delete_module, name, flags);
> > +}
> > +
> >  void test_module_attach(void)
> >  {
> >         const int READ_SZ = 456;
> >         const int WRITE_SZ = 457;
> >         struct test_module_attach* skel;
> >         struct test_module_attach__bss *bss;
> > +       struct bpf_link *link;
> >         int err;
> >
> >         skel = test_module_attach__open();
> > @@ -84,6 +90,23 @@ void test_module_attach(void)
> >         ASSERT_EQ(bss->fexit_ret, -EIO, "fexit_tet");
> >         ASSERT_EQ(bss->fmod_ret_read_sz, READ_SZ, "fmod_ret");
> >
> > +       test_module_attach__detach(skel);
> > +
> > +       /* attach fentry/fexit and make sure it get's module reference */
> > +       link = bpf_program__attach(skel->progs.handle_fentry);
> > +       if (CHECK(IS_ERR(link), "attach_fentry", "err: %ld\n", PTR_ERR(link)))
> > +               goto cleanup;
> > +
> > +       ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
> > +       bpf_link__destroy(link);
> > +
> > +       link = bpf_program__attach(skel->progs.handle_fexit);
> > +       if (CHECK(IS_ERR(link), "attach_fexit", "err: %ld\n", PTR_ERR(link)))
> > +               goto cleanup;
> > +
> > +       ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
> > +       bpf_link__destroy(link);
> > +
> >  cleanup:
> >         test_module_attach__destroy(skel);
> >  }
> > --
> > 2.30.2
> >
> 

