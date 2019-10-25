Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC20E560A
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfJYVjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 17:39:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:38506 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYVjg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 17:39:36 -0400
Received: from 33.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.33] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iO7J0-0002jM-U6; Fri, 25 Oct 2019 23:39:35 +0200
Date:   Fri, 25 Oct 2019 23:39:34 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: restore $(OUTPUT)/test_stub.o
 rule
Message-ID: <20191025213934.GA14547@pc-63.home>
References: <20191024184205.1798-1-iii@linux.ibm.com>
 <CAEf4BzZJ4XAOd-9ZYqD-XwBfidFdKnwcqcUu9EjkZuv8bOE5JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZJ4XAOd-9ZYqD-XwBfidFdKnwcqcUu9EjkZuv8bOE5JA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25613/Fri Oct 25 11:00:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 25, 2019 at 02:01:40PM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 25, 2019 at 11:54 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > `make O=/linux-build kselftest TARGETS=bpf` fails with
> >
> >         make[3]: *** No rule to make target '/linux-build/bpf/test_stub.o', needed by '/linux-build/bpf/test_verifier'
> >
> > The same command without the O= part works, presumably thanks to the
> > implicit rule.
> >
> > Fix by restoring the explicit $(OUTPUT)/test_stub.o rule.
> >
> > Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 59b93a5667c8..9d63a12f932b 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -89,6 +89,9 @@ $(notdir $(TEST_GEN_PROGS)                                            \
> >  $(OUTPUT)/urandom_read: urandom_read.c
> >         $(CC) -o $@ $< -Wl,--build-id
> >
> > +$(OUTPUT)/test_stub.o: test_stub.c
> > +       $(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<
> 
> Looks good to me, even though we never pass $(CPPFLAGS) to any other
> objects, so for consistency we might want to drop them.
> 
> But either way:
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

+1, Ilya could you respin with CPPFLAGS removed. Feel free to retain
Andrii's ACK then.

Thanks,
Daniel
