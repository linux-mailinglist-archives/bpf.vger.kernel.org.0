Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C055952590F
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 02:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbiEMAqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 20:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359776AbiEMAqO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 20:46:14 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2B35DD6
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:46:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 05D86240026
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 02:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652402767; bh=4ebF8wAV6SvHnq3h8oz6/loy6mvL1HyQ4U61TbGkLSI=;
        h=Date:From:To:Cc:Subject:From;
        b=Z+yNP8szDxQtwZB4c2bgzA/cpBF7T23SQprDff0mq+YwG7VVEob01XA7MO+sAL5ej
         aryuVeH7pAv7hoG3wPGTY3CkA4IK9Ivhs1WKV2OGm83fxGcl0RGCFTyzlRCp606Vbj
         U1wbksu0T8QUs+XlpZOLeeA2Ks4ECtA/t2p8nRbBlIJtOUwP3PIbUebY1Yz17xQnLE
         Wjp/o7BOZzAa/s+Uoe3qDZqQVfRH2lJButyXwIVxorYdjCCYSlPahGEhAtc0ttx/5L
         3sGcsyHNESh4OI3HBIqN3EFlXDdbp9dI7owbYDVUzYY3VtzBghxVDwZ54TmAKduvh0
         RuU9x+SZ4iXHA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4KzqhD5fjLz6tmK;
        Fri, 13 May 2022 02:46:04 +0200 (CEST)
Date:   Fri, 13 May 2022 00:45:56 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Hardcode /sys/kernel/btf/vmlinux
 in fewer places
Message-ID: <20220513004556.75yufuhbv2trbnqh@nuc>
References: <20220512234332.2852918-1-deso@posteo.net>
 <CAEf4BzZ0q9Avxie9oAFi0M6s93P85OX7c7rpd1GZjvfwnCJV6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ0q9Avxie9oAFi0M6s93P85OX7c7rpd1GZjvfwnCJV6w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 05:08:29PM -0700, Andrii Nakryiko wrote:
> On Thu, May 12, 2022 at 4:44 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > Two of the BPF selftests hardcode the path to /sys/kernel/btf/vmlinux.
> > The kernel image could potentially exist at a different location.
> > libbpf_find_kernel_btf(), as introduced by commit fb2426ad00b1 ("libbpf:
> > Expose bpf_find_kernel_btf as a LIBBPF_API"), knows about said
> > locations.
> >
> > This change switches these two tests over to using this function
> > instead, making the tests more likely to be runnable when
> > /sys/kernel/btf/vmlinux may not be present and setting better precedent.
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/libbpf_probes.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> > index 9f766dd..61c81a9 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> > @@ -11,8 +11,8 @@ void test_libbpf_probe_prog_types(void)
> >         const struct btf_enum *e;
> >         int i, n, id;
> >
> > -       btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
> 
> Selftests go hand in hand with kernel and generally assume specific
> kernel features enabled (like BTF and sysfs) and having very recent
> (if not latest) kernel. So there is nothing bad about loading
> /sys/kernel/btf/vmlinux, I think, it's actually more straightforward
> to follow the code when it is used explicitly. Libbpf's logic for
> finding kernel BTF in other places is for older systems. So I'd leave
> it as is.

Sounds good to me. Feel free to ignore the patch then.

Daniel
