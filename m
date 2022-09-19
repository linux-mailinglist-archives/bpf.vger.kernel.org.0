Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E415BD830
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 01:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiISXWn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 19:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiISXWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 19:22:43 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5306155
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 16:22:41 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 63so997175ybq.4
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1w1eB9JyeaLxtzm/tdeOCWCjZuh/yvFNSAuKfwrEdjQ=;
        b=jpAKeA2QRcgK4RXOEiEq/QikbutUZKgb5rTg+9Le7W+44WV4evB6E733M4Dg/OExlP
         EyeoX0RaRdguTBuEc5xIGgIvCLTY03fzl3F9zochPolmJ3OKvHaSegDGQ6BBQyMfn3Bv
         eG1bF84DiJc3xYiODk6odvjjJEOdZtGukrqO48TIOOHulJYMuaKaQd8GQ6Pis0l73U1E
         INIDtTBORL3Nj+lTGoXCOlwROOf+Unrck2B2LLb2fzdMVf4jBJda6ulIazbqWjErydt2
         Cv3UFMF3gDwVrfJvN+MXVWidd7YrBE08Ro5MDf0INc+LswcOb/5f8dyyOsqsk9h+dpx9
         IuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1w1eB9JyeaLxtzm/tdeOCWCjZuh/yvFNSAuKfwrEdjQ=;
        b=m4H6jinYISdB7IPsahiD08Gc+96Wu7XBVjzlFqLb2HEy3+rlysZDgorg8QxH/TUFmq
         aKabw9o/QHztcpZ9EH43PfYuNfWPKGN7OQXrXIqKHG0LBK/CP2bCB6hhF6NNhUB7lQ02
         5jOGoVDw8hWczoNDrNpsF9uX7K6J5Bhyue1T6L9kYGnz9XcqI90rXNBn8OENDJAYReNe
         kCY3iwbt6oX2amxycEexThWc1lGBnsbqEPgda9399Eu2JkJEIqJDfzUm4RYtZ6eRHWbM
         lEW4LFssvB9XU9SPr0TBILhkJqo5pfT+44LRWxCA6p0Ina1idRR+c6FA8hDY6LkXkp33
         K/yw==
X-Gm-Message-State: ACrzQf29bf4dFGz9o6a3subFLzzDMZQkFre/Xf0OEE91YD/K+86bhmzr
        i2xDg6R9gdCZByaFB79gMXCPEkhGNM4VWfVCl8E=
X-Google-Smtp-Source: AMsMyM5MFRIvaF0X1qL0mFWmkvb/4rC29ql4XgW8nAjhr2uqZfLuipEfl8RcfZLC7VAxftrTkDW6rezi8WpQtJZHdqY=
X-Received: by 2002:a25:b44a:0:b0:695:bd50:9c2d with SMTP id
 c10-20020a25b44a000000b00695bd509c2dmr16964500ybg.495.1663629760647; Mon, 19
 Sep 2022 16:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220914123600.927632-1-davemarchevsky@fb.com>
 <20220914123600.927632-2-davemarchevsky@fb.com> <26e3f391-076e-49ce-89d6-21aa16f3c054@fb.com>
In-Reply-To: <26e3f391-076e-49ce-89d6-21aa16f3c054@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 20 Sep 2022 01:22:04 +0200
Message-ID: <CAP01T75E9sp5Aq159Zjmrpmaue+gYkN66qjA06opDhLhbuUzAw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
To:     Yonghong Song <yhs@fb.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 20 Sept 2022 at 00:53, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/14/22 5:36 AM, Dave Marchevsky wrote:
> > Add a test_ringbuf_map_key test prog, borrowing heavily from extant
> > test_ringbuf.c. The program tries to use the result of
> > bpf_ringbuf_reserve as map_key, which was not possible before previouis
> > commits in this series. The test runner added to prog_tests/ringbuf.c
> > verifies that the program loads and does basic sanity checks to confirm
> > that it runs as expected.
> >
> > Also, refactor test_ringbuf such that runners for existing test_ringbuf
> > and newly-added test_ringbuf_map_key are subtests of 'ringbuf' top-level
> > test.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
> > v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
> >
> > * Actually run the program instead of just loading (Yonghong)
> > * Add a bpf_map_update_elem call to the test (Yonghong)
> > * Refactor runner such that existing test and newly-added test are
> >    subtests of 'ringbuf' top-level test (Yonghong)
> > * Remove unused globals in test prog (Yonghong)
> >
> >   tools/testing/selftests/bpf/Makefile          |  8 ++-
> >   .../selftests/bpf/prog_tests/ringbuf.c        | 63 ++++++++++++++++-
> >   .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
> >   3 files changed, 137 insertions(+), 4 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> >
> [...]
> > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> > new file mode 100644
> > index 000000000000..495f85c6e120
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +struct sample {
> > +     int pid;
> > +     int seq;
> > +     long value;
> > +     char comm[16];
> > +};
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_RINGBUF);
> > +     __uint(max_entries, 4096);
> > +} ringbuf SEC(".maps");
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(max_entries, 1000);
> > +     __type(key, struct sample);
> > +     __type(value, int);
> > +} hash_map SEC(".maps");
> > +
> > +/* inputs */
> > +int pid = 0;
> > +
> > +/* inner state */
> > +long seq = 0;
> > +
> > +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> > +int test_ringbuf_mem_map_key(void *ctx)
> > +{
> > +     int cur_pid = bpf_get_current_pid_tgid() >> 32;
> > +     struct sample *sample, sample_copy;
> > +     int *lookup_val;
> > +
> > +     if (cur_pid != pid)
> > +             return 0;
> > +
> > +     sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
> > +     if (!sample)
> > +             return 0;
> > +
> > +     sample->pid = pid;
> > +     bpf_get_current_comm(sample->comm, sizeof(sample->comm));
> > +     sample->seq = ++seq;
> > +     sample->value = 42;
> > +
> > +     /* test using 'sample' (PTR_TO_MEM | MEM_ALLOC) as map key arg
> > +      */
> > +     lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);
> > +
> > +     /* memcpy is necessary so that verifier doesn't complain with:
> > +      *   verifier internal error: more than one arg with ref_obj_id R3
> > +      * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
> > +      *
> > +      * Since bpf_map_lookup_elem above uses 'sample' as key, test using
> > +      * sample field as value below
> > +      */
>
> If I understand correctly, the above error is due to the following
> verifier code:
>
>          if (reg->ref_obj_id) {
>                  if (meta->ref_obj_id) {
>                          verbose(env, "verifier internal error: more
> than one arg with ref_obj_id R%d %u %u\n",
>                                  regno, reg->ref_obj_id,
>                                  meta->ref_obj_id);
>                          return -EFAULT;
>                  }
>                  meta->ref_obj_id = reg->ref_obj_id;
>          }
>
> So this is an internal error. So normally this should not happen.
> Could you investigate and fix the issue?
>

Technically it's not an "internal" error, it's totally possible to
pass two referenced registers from a program (which the verifier
rejects). So a bad log message I guess.

We probably need to update the verifier to properly recognize the
ref_obj_id for certain functions. For release arguments we already
have meta.release_regno/OBJ_RELEASE for. It can already find the
ref_obj_id from release_regno instead of meta.ref_obj_id.

For dynptr_ref or ptr_cast, simply store meta.ref_obj_id by capturing
the regno and then setting it before r1-r5 is cleared.
Since that is passed to r0 it will be done later after clearing of
caller saved regs.
ptr_cast and dynptr_ref functions are already exclusive (due to
helper_multiple_ref_obj_use) so they can share the same regno field in
meta.

Then remove this check on seeing more than one reg->ref_obj_id, so it
isn't a problem to allow more than one refcounted registers for all
other arguments, as long as we correctly remember the ones for the
cases we care about.

But it can probably be a separate change from this.
