Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B04ED39B
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 07:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiCaF6H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 01:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCaF6D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 01:58:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D215619BE7C
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 22:56:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b16so27483767ioz.3
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 22:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVqHNz67k7n15v0kHENXvY+XgVAiCSNba2cuwHmaCL8=;
        b=P+2Mh4Wpk0fbSSMK1+iudecF/9UgwqvLEzuKwz3Q+hHm3LUXlQlknA5oOoXG2V8xOi
         2h6XHzP/d3KrrIGmek3afe/VZHNsa94RQ5x84V70w9SgtD+XKwM/Wnk7o1xw/BmMs3ff
         3WHuWC4ImRPrSDSQgnob8p3/gk3bsIXJrgPZgo4NxuozMJZhU5lEEEkohNoM4Wo+8E/z
         BHiDuFxUYyzIxL6juKS5Z0Z4w2aV6+vnoHFBsjH6Fn/WhnMpDP4WkYdJy3VrBIgAfwQw
         4h7Dycm68lgzr8eGewsmD55t51P1voX0burGG6z4HaMyLevLFQMz6MOkar8N9ms+Fxl6
         kzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVqHNz67k7n15v0kHENXvY+XgVAiCSNba2cuwHmaCL8=;
        b=VQrwu9ojjQkPOx7DYuUDbo7ZhtfOlq51wg3uKLJ/xw6momRzJvU4wjMSBcgU3RqQmS
         3NKmkT/xd6GgztdFjv8kHxCp+ibaRSpKZfdcuO2B+sBJIvVjaN3rVmm0nAX0bXnYo3+h
         oY5DTYrrV/5155udWMQMNCvFCa/WtbPRSA66jhAwEtR22XH9S6U7E2D/tEjChfbMsQtF
         AWzqO5mwRt8ARd4O7wKpRLzqfySk1/QWup6YIwCHPavJexxn9udS31pNNYqAvqxMc6ZT
         2cISdPPzkM9yAEw5ObCi9uSQLziiDHqQDuHPIWWp2xlucIAApv9pbozSKVKU5oQCRoQW
         jJPw==
X-Gm-Message-State: AOAM530pmHY+6uVVFsDMDXrFpX7KMJHERBch+SWuyiUmaYUi/Uhph5Dl
        joCyYp9kEY1lO8nZc73557tbF9EBbSfgGKC4ZgU=
X-Google-Smtp-Source: ABdhPJxrm/1KNRuqwPEY6a2Zdj63EW/rQMez9HJENqBTMc8FClSLyayHUdIp3p5AyNNAKEw8r6LXt2JNHrkof4sx5xU=
X-Received: by 2002:a05:6638:2642:b0:323:756f:42a7 with SMTP id
 n2-20020a056638264200b00323756f42a7mr2145978jat.145.1648706175180; Wed, 30
 Mar 2022 22:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-3-andrii@kernel.org>
 <97bc0863-1c02-fd20-a7dd-e64aa663a918@gmail.com>
In-Reply-To: <97bc0863-1c02-fd20-a7dd-e64aa663a918@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Mar 2022 22:56:04 -0700
Message-ID: <CAEf4BzYGXAUd9L2iGBTFOxZvWHmh8aCvu-NFL10Skg+tZxV97Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] libbpf: wire up USDT API and bpf_link integration
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 29, 2022 at 8:25 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2022/3/25 1:29 PM, Andrii Nakryiko wrote:
> > Wire up libbpf USDT support APIs without yet implementing all the
> > nitty-gritty details of USDT discovery, spec parsing, and BPF map
> > initialization.
> >
> > User-visible user-space API is simple and is conceptually very similar
> > to uprobe API.
> >
> > bpf_program__attach_usdt() API allows to programmatically attach given
> > BPF program to a USDT, specified through binary path (executable or
> > shared lib), USDT provider and name. Also, just like in uprobe case, PID
> > filter is specified (0 - self, -1 - any process, or specific PID).
> > Optionally, USDT cookie value can be specified. Such single API
> > invocation will try to discover given USDT in specified binary and will
> > use (potentially many) BPF uprobes to attach this program in correct
> > locations.
> >
> > Just like any bpf_program__attach_xxx() APIs, bpf_link is returned that
> > represents this attachment. It is a virtual BPF link that doesn't have
> > direct kernel object, as it can consist of multiple underlying BPF
> > uprobe links. As such, attachment is not atomic operation and there can
> > be brief moment when some USDT call sites are attached while others are
> > still in the process of attaching. This should be taken into
> > consideration by user. But bpf_program__attach_usdt() guarantees that
> > in the case of success all USDT call sites are successfully attached, or
> > all the successfuly attachments will be detached as soon as some USDT
> > call sites failed to be attached. So, in theory, there could be cases of
> > failed bpf_program__attach_usdt() call which did trigger few USDT
> > program invocations. This is unavoidable due to multi-uprobe nature of
> > USDT and has to be handled by user, if it's important to create an
> > illusion of atomicity.
> >
> > USDT BPF programs themselves are marked in BPF source code as either
> > SEC("usdt"), in which case they won't be auto-attached through
> > skeleton's <skel>__attach() method, or it can have a full definition,
> > which follows the spirit of fully-specified uprobes:
> > SEC("usdt/<path>:<provider>:<name>"). In the latter case skeleton's
> > attach method will attempt auto-attachment. Similarly, generic
> > bpf_program__attach() will have enought information to go off of for
> > parameterless attachment.
> >
> > USDT BPF programs are actually uprobes, and as such for kernel they are
> > marked as BPF_PROG_TYPE_KPROBE.
> >
> > Another part of this patch is USDT-related feature probing:
> >   - BPF cookie support detection from user-space;
> >   - detection of kernel support for auto-refcounting of USDT semaphore.
> >
> > The latter is optional. If kernel doesn't support such feature and USDT
> > doesn't rely on USDT semaphores, no error is returned. But if libbpf
> > detects that USDT requires setting semaphores and kernel doesn't support
> > this, libbpf errors out with explicit pr_warn() message. Libbpf doesn't
> > support poking process's memory directly to increment semaphore value,
> > like BCC does on legacy kernels, due to inherent raciness and danger of
> > such process memory manipulation. Libbpf let's kernel take care of this
> > properly or gives up.
> >
> > Logistically, all the extra USDT-related infrastructure of libbpf is put
> > into a separate usdt.c file and abstracted behind struct usdt_manager.
> > Each bpf_object has lazily-initialized usdt_manager pointer, which is
> > only instantiated if USDT programs are attempted to be attached. Closing
> > BPF object frees up usdt_manager resources. usdt_manager keeps track of
> > USDT spec ID assignment and few other small things.
> >
> > Subsequent patches will fill out remaining missing pieces of USDT
> > initialization and setup logic.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/Build             |   3 +-
> >  tools/lib/bpf/libbpf.c          |  92 ++++++++++-
> >  tools/lib/bpf/libbpf.h          |  15 ++
> >  tools/lib/bpf/libbpf.map        |   1 +
> >  tools/lib/bpf/libbpf_internal.h |  19 +++
> >  tools/lib/bpf/usdt.c            | 270 ++++++++++++++++++++++++++++++++
> >  6 files changed, 391 insertions(+), 9 deletions(-)
> >  create mode 100644 tools/lib/bpf/usdt.c
> >

[...]

> > +struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
> > +                                       pid_t pid, const char *binary_path,
> > +                                       const char *usdt_provider, const char *usdt_name,
> > +                                       const struct bpf_usdt_opts *opts)
> > +{
> > +     struct bpf_object *obj = prog->obj;
> > +     struct bpf_link *link;
> > +     long usdt_cookie;
> > +     int err;
> > +
> > +     if (!OPTS_VALID(opts, bpf_uprobe_opts))
> > +             return libbpf_err_ptr(-EINVAL);
> > +
> > +     /* USDT manager is instantiated lazily on first USDT attach. It will
> > +      * be destroyed together with BPF object in bpf_object__close().
> > +      */
> > +     if (!obj->usdt_man) {
> > +             obj->usdt_man = usdt_manager_new(obj);
> > +             if (!obj->usdt_man)
> > +                     return libbpf_err_ptr(-ENOMEM);
>
> usdt_manager_new returns NULL in two cases, ENOMEM is not accurate when map not found.
>
>

True, we can use ERR_PTR() for usdt_manager_new() as it is an internal
API. I'll update the code accordingly.

> > +     }
> > +
> > +     usdt_cookie = OPTS_GET(opts, usdt_cookie, 0);
> > +     link = usdt_manager_attach_usdt(obj->usdt_man, prog, pid, binary_path,
> > +                                     usdt_provider, usdt_name, usdt_cookie);
> > +     err = libbpf_get_error(link);
> > +     if (err)
> > +             return libbpf_err_ptr(err);
> > +     return link;
> > +}
> > +
> > +static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > +{
> > +     char *path = NULL, *provider = NULL, *name = NULL;
> > +     const char *sec_name;
> > +
> > +     sec_name = bpf_program__section_name(prog);
> > +     if (strcmp(sec_name, "usdt") == 0) {
> > +             /* no auto-attach for just SEC("usdt") */
> > +             *link = NULL;
> > +             return 0;
> > +     }
> > +
> > +     if (3 != sscanf(sec_name, "usdt/%m[^:]:%m[^:]:%m[^:]", &path, &provider, &name)) {
>
> Is yoda condition a good practice ?

I used it to emphasize and make it clear how many parts we expect, but
I have no strong feeling about doing sscanf() == 3 in this case
either.

>
> > +             pr_warn("invalid section '%s', expected SEC(\"usdt/<path>:<provider>:<name>\")\n",
> > +                     sec_name);
> > +             free(path);
> > +             free(provider);
> > +             free(name);
> > +             return -EINVAL;
> > +     }
> > +

[...]

> > +     man = calloc(1, sizeof(*man));
> > +     if (!man)
> > +             return NULL;
> > +
> > +     man->specs_map = specs_map;
> > +     man->ip_to_id_map = ip_to_id_map;
> > +
> > +        /* Detect if BPF cookie is supported for kprobes.
> > +      * We don't need IP-to-ID mapping if we can use BPF cookies.
> > +         * Added in: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to access bpf_cookie value")
> > +         */
>
>      ^  mixed-indention here.

will fix

>
> > +     man->has_bpf_cookie = kernel_supports(obj, FEAT_BPF_COOKIE);
> > +
> > +     /* Detect kernel support for automatic refcounting of USDT semaphore.
> > +      * If this is not supported, USDTs with semaphores will not be supported.
> > +      * Added in: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based uprobe")
> > +      */
> > +     man->has_sema_refcnt = access(ref_ctr_sysfs_path, F_OK) == 0;
> > +
> > +     return man;
> > +}
> > +

[...]

> > +err_out:
> > +     bpf_link__destroy(&link->link);
> > +
> > +     if (elf)
> > +             elf_end(elf);
> > +     close(fd);
> > +     return libbpf_err_ptr(err);
> > +}
>
> Will test this series and feedback to you :)
>

Great, thank you!

I'll add a bunch more comments to explain overall "setup" and do few
more small changes here and there and will post v2 soon-ish. But all
the APIs and behavior won't change.
