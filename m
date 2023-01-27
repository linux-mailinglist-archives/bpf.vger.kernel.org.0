Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE667EC60
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 18:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjA0R0Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 12:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjA0R0X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 12:26:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261A27492
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:26:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m12so5356687edq.5
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRLvn0KfCk4LN5tSor8qrSlBUFCb8EhzNEN8zMdG1Qg=;
        b=ciY+TH3jSCmdXhsUrro31dFpfDyeKyTmu0e2rWD0vkZOo6QiYeRQtHGtiyS+drlXbI
         8wcr10/gBusNckXxN4V8F9ycEn9x8g8cWRP1KIuhevufNeu1Fv78gXbFQa3MRc/UI1PF
         OHxypcTc0S28X6t+dof5asj43Emo3FjlkEQY0hDNBnIv0ET19MotLX291yQ0EtCCWUFx
         NORo2IbYT9Km9eeXRk16j+RP+Rs/dNGQrrfmpKOmpYpw7bgW9E5z3340Y1VIOHiudPor
         nIT3MOiwWwdQH2zfasQtvqV5EYZEUHO1RGfdZl3+DEwT63rfBU6JRz2uzru42+gay8el
         lKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRLvn0KfCk4LN5tSor8qrSlBUFCb8EhzNEN8zMdG1Qg=;
        b=5f6gNrkqe2VFqIdGYpTTpeJnpahqsFknDspssQDwkR1uBCQPlz6Ndd5g4QQu9jrW0h
         lbxku0GcSEwCISW3e1ObkrxCZL1E2ztQI4YhI64RE0wo/MEwbbdM7z7DMgC6JVR+1mvj
         PCO9wdQyuUbIRELjKP2UrVk3nNqTKBc/CGcOK4y6Mawg8iLdoFu+Lwca4rameu8qGbSg
         x2Yv2+K/DKRn78uTE4fKGDJ+9sAp3t01lMqqAOkNSYXYI2gpaNyQ389LwCGKbRuc54Sz
         P8U7sHt56ijH+dVe48cm3iyZyliRNV7l4+64WnASHxMcKrCHNbhKHURff+b2PUhUGxse
         X84g==
X-Gm-Message-State: AFqh2kr5ilEzX9regq7JzO8S1oaoWMELUm8e5ieXZjGufN/Vs8weTljM
        XW4D88UsnHbyVlPFmloU3LaBpT55ir8omsMq+UQ=
X-Google-Smtp-Source: AMrXdXtFcvLzgrqUQj56Vt7Hz0WU4k99cPP1CDrqBH8UzSmbNBIjXElz3A8xHGLWqOQFD98O4dzCn+2ltDpXb69UW1s=
X-Received: by 2002:a05:6402:1008:b0:499:f0f:f788 with SMTP id
 c8-20020a056402100800b004990f0ff788mr6764356edu.25.1674840379831; Fri, 27 Jan
 2023 09:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-9-iii@linux.ibm.com>
 <CAEf4BzaaC4gn-BjpYWP++0GoHbJ2xaOOZ32ZNwq+_vxHVMKpuA@mail.gmail.com> <924757c3fcda1f17ed68623234a3982e660e2717.camel@linux.ibm.com>
In-Reply-To: <924757c3fcda1f17ed68623234a3982e660e2717.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 27 Jan 2023 09:26:07 -0800
Message-ID: <CAEf4BzY276stJk2MFyKx-R1KRzw9S1z_zKvQqwsFoJWa9Yw_iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/24] selftests/bpf: Fix verify_pkcs7_sig on s390x
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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

On Fri, Jan 27, 2023 at 4:36 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2023-01-25 at 17:06 -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Use bpf_probe_read_kernel() instead of bpf_probe_read(), which is
> > > not
> > > defined on all architectures.
> > >
> > > While at it, improve the error handling: do not hide the verifier
> > > log,
> > > and check the return values of bpf_probe_read_kernel() and
> > > bpf_copy_from_user().
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/verify_pkcs7_sig.c      |  9
> > > +++++++++
> > >  .../selftests/bpf/progs/test_verify_pkcs7_sig.c      | 12
> > > ++++++++----
> > >  2 files changed, 17 insertions(+), 4 deletions(-)
> > >
> > > diff --git
> > > a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> > > b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> > > index 579d6ee83ce0..75c256f79f85 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> > > @@ -56,11 +56,17 @@ struct data {
> > >         __u32 sig_len;
> > >  };
> > >
> > > +static char libbpf_log[8192];
> > >  static bool kfunc_not_supported;
> > >
> > >  static int libbpf_print_cb(enum libbpf_print_level level, const
> > > char *fmt,
> > >                            va_list args)
> > >  {
> > > +       size_t log_len = strlen(libbpf_log);
> > > +
> > > +       vsnprintf(libbpf_log + log_len, sizeof(libbpf_log) -
> > > log_len,
> > > +                 fmt, args);
> >
> > it seems like test is written to assume that load might fail and
> > we'll
> > get error messages, so not sure it's that useful to print out these
> > errors. But at the very least we should filter out DEBUG and INFO
> > level messages, and pass through WARN only.
> >
> > Also, there is no point in having a separate log buffer, just printf
> > directly. test_progs will take care to collect overall log and ignore
> > it if test succeeds, or emit it if test fails
>
> Thanks, I completely overlooked the fact that the test framework
> already hides the output in case of success. With that in mind I can do
> just this:
>
> --- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> @@ -61,6 +61,9 @@ static bool kfunc_not_supported;
>  static int libbpf_print_cb(enum libbpf_print_level level, const char
> *fmt,
>                            va_list args)
>  {
> +       if (level == LIBBPF_WARN)
> +               vprintf(fmt, args);
> +
>         if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in
> kernel or module BTFs\n"))
>                 return 0;
>
> If the load fails due to missing kfuncs, we'll skip the test - I think
> in this case the output won't be printed either, so we should be fine.

sgtm

>
> > > +
> > >         if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found
> > > in kernel or module BTFs\n"))
> > >                 return 0;
> > >
> > > @@ -277,6 +283,7 @@ void test_verify_pkcs7_sig(void)
> > >         if (!ASSERT_OK_PTR(skel, "test_verify_pkcs7_sig__open"))
> > >                 goto close_prog;
> > >
> > > +       libbpf_log[0] = 0;
> > >         old_print_cb = libbpf_set_print(libbpf_print_cb);
> > >         ret = test_verify_pkcs7_sig__load(skel);
> > >         libbpf_set_print(old_print_cb);
> > > @@ -289,6 +296,8 @@ void test_verify_pkcs7_sig(void)
> > >                 goto close_prog;
> > >         }
> > >
> > > +       printf("%s", libbpf_log);
> > > +
> > >         if (!ASSERT_OK(ret, "test_verify_pkcs7_sig__load"))
> > >                 goto close_prog;
> > >
> > > diff --git
> > > a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > > b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > > index ce419304ff1f..7748cc23de8a 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > > @@ -59,10 +59,14 @@ int BPF_PROG(bpf, int cmd, union bpf_attr
> > > *attr, unsigned int size)
> > >         if (!data_val)
> > >                 return 0;
> > >
> > > -       bpf_probe_read(&value, sizeof(value), &attr->value);
> > > -
> > > -       bpf_copy_from_user(data_val, sizeof(struct data),
> > > -                          (void *)(unsigned long)value);
> > > +       ret = bpf_probe_read_kernel(&value, sizeof(value), &attr-
> > > >value);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret = bpf_copy_from_user(data_val, sizeof(struct data),
> > > +                                (void *)(unsigned long)value);
> > > +       if (ret)
> > > +               return ret;
> >
> > this part looks good, we shouldn't use bpf_probe_read.
> >
> > You'll have to update progs/profiler.inc.h as well, btw, which still
> > uses bpf_probe_read() and bpf_probe_read_str.
>
> I remember trying this, but there were still failures due to, as I
> thought back then, usage of BPF_CORE_READ() and the lack of
> BPF_CORE_READ_KERNEL(). But this seems to be a generic issue. Let me
> try again and post my findings as a reply to 0/24.

Yep, replied there as well: BPF_PROBE_READ still using
bpf_probe_read() is an omission and we should fix that.

>
> > >         if (data_val->data_len > sizeof(data_val->data))
> > >                 return -EINVAL;
> > > --
> > > 2.39.1
> > >
>
