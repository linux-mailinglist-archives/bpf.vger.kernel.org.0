Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B12B4EE144
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbiCaTEL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiCaTEJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 15:04:09 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7130B20DB26
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:02:21 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g21so565150iom.13
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHDhHSNTlhGXzFJNcm2qijotccc5Ha3Odv6PaFB1Pdw=;
        b=Peq4r/R8+6si5IUP3HKl8f3dtHuKmcVLL3fxdnYpaJ7Od2wYnr6va10k77MvggVCd1
         J5ibLE9wtRIMZ1CyOZKxRRD5y3eIENKxOcNsAzTBiG2HojstErXT7hXhugQLZpeF53UK
         nqu+IcJN3lFKYlu0oP9uBqkRBje436B2xHfxYpepDA/BQ22dZT7lkkcWGFddCqGSF/za
         dtMSQwwdki9yRuy1amqQulIH502HDlyqxncxDRdx6c7c83d/nGiR8uqqLQZDT1VxNiTs
         Jf+xvdsTU0Ii7EfwjO8COAOxsE57oafSnPJKeHUXG5lBkTxCwhVZgcSUfQM/xZ+4Mx1Y
         hMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHDhHSNTlhGXzFJNcm2qijotccc5Ha3Odv6PaFB1Pdw=;
        b=cDEuD6GriMiE00cHAa3z1pJEwRapgN/22Sy2IdvDMit7rWCL+UO7cymwfOrlYddp4R
         5eAmxJDl8odlUOFBzyQMKXHElm3+Vks8tpcEUUlFMmDFz6lUPE28MbTNalhP4mm6lpqt
         c1C3BXSyCvr2Y+8t5wMjbHdBNdCzX6zvFNfaTaifEBAIDP1mxGTv4BZyWg9DnPWsm7eH
         xWxrbbrMkuTReYWmx997IjCmJx7Qtz3RDw4wgmooVRW9lR0YpbcfA8GaDGs7dCUPt7eK
         Rz8DpLCJlERrjhc/TlsxIflBMaeIsZ1gmW6e0o9KtjVxsXsFEf3BvuE4F1nUWt2jqHIo
         mfbg==
X-Gm-Message-State: AOAM5316gR3OtGOniaeNk6Dz8Yy40V9VtIxvWiR3nr/Rk8CcqKsMH+C3
        4lX1t5Kb+H2V+tynNFSmqYGETwvTbE3E/eFBYAUVdfuF
X-Google-Smtp-Source: ABdhPJwTh7QU6YxnMiolQgE0uHYByhK8RxdkA/mIblBRcDQXPPHeNQ06yCFm57kA4JTmD4MPy1poUwNTZof47YXwTFo=
X-Received: by 2002:a05:6638:3395:b0:323:8a00:7151 with SMTP id
 h21-20020a056638339500b003238a007151mr3749228jav.93.1648753340718; Thu, 31
 Mar 2022 12:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-3-andrii@kernel.org>
 <alpine.LRH.2.23.451.2203311234080.22159@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2203311234080.22159@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 31 Mar 2022 12:02:09 -0700
Message-ID: <CAEf4BzaWOA8_qHepBwxPRVzV4TeWzWi7CeMMjtEd-2KTBxwSnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] libbpf: wire up USDT API and bpf_link integration
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
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

On Thu, Mar 31, 2022 at 5:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 25 Mar 2022, Andrii Nakryiko wrote:
>
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
>
> Might be worth describing briefly the under-the-hood mechanisms; the
> usdt_manager that is per-BPF-object (so can conceptually represent
> multiple USDT providers/probes). It is initialized on first use and
> freed with bpf_object__close(); it is tasked with managing the mapping
> from usdt provider:name to actual sites+arguments via the spec/ip-to-id
> maps.

Yeah, I got feedback off-list that some good comment on how all the
pieces are coming together would be nice. I think I'll add a big
thorough explanation as a comment for struct usdt_manager, explaining
all the relations.

>
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
>
> again mostly nits and small suggestions below; this is fantastic Andrii!
>

Thanks for the thorough review!

> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> >  tools/lib/bpf/Build             |   3 +-
> >  tools/lib/bpf/libbpf.c          |  92 ++++++++++-
> >  tools/lib/bpf/libbpf.h          |  15 ++
> >  tools/lib/bpf/libbpf.map        |   1 +
> >  tools/lib/bpf/libbpf_internal.h |  19 +++
> >  tools/lib/bpf/usdt.c            | 270 ++++++++++++++++++++++++++++++++
> >  6 files changed, 391 insertions(+), 9 deletions(-)
> >  create mode 100644 tools/lib/bpf/usdt.c

[...]

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
> > +             pr_warn("invalid section '%s', expected SEC(\"usdt/<path>:<provider>:<name>\")\n",
> > +                     sec_name);
>
> could have an else clause here for the parse success case I suppose to
> save having two sets of free()s.

you mean like

if (3 == sscanf("")) {
    *link = bpf_program__attach_usdt(...);
    err = libbpf_get_error(*link);
} else {
    err = -EINVAL;
}

free(path);
free(provider);
free(name);

return err;

?

Can do that, sure.

>
> > +             free(path);
> > +             free(provider);
> > +             free(name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     *link = bpf_program__attach_usdt(prog, -1 /* any process */, path,
> > +                                      provider, name, NULL);
> > +     free(path);
> > +     free(provider);
> > +     free(name);
> > +     return libbpf_get_error(*link);
> > +}
> > +
> >  static int determine_tracepoint_id(const char *tp_category,
> >                                  const char *tp_name)
> >  {
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 05dde85e19a6..318eecaa14e7 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -503,6 +503,21 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >                               const char *binary_path, size_t func_offset,
> >                               const struct bpf_uprobe_opts *opts);
> >
> > +struct bpf_usdt_opts {
> > +     /* size of this struct, for forward/backward compatibility */
> > +     size_t sz;
> > +     /* custom user-provided value accessible through usdt_cookie() */
> > +     __u64 usdt_cookie;
> > +     size_t :0;
> > +};
> > +#define bpf_usdt_opts__last_field usdt_cookie
> > +
>
> need doc comment here such as
>
> /**
>  * @brief **bpf_program__attach_usdt()** is just like
>  * bpf_program__attach_uprobe_opts() except it covers
>  * USDT (Userspace Static Defined Tracing) attachment.
>  *
>  * @param prog BPF program to attach
>  * @param pid Process ID to attach the uprobe to, 0 for self (own
> process),
>  * -1 for all processes
>  * @param binary_path Path to binary that contains the USDT probe
>  * @param usdt_provider USDT Provider name
>  * @param usdt_name USDT Probe name
>  * @param opts Options for altering USDT attachment
>  * @return Reference to the newly created BPF link; or NULL is returned on
> error,
>  * error code is stored in errno
>  */
>

Will add, thanks!

>
> > +LIBBPF_API struct bpf_link *
> > +bpf_program__attach_usdt(const struct bpf_program *prog,
> > +                      pid_t pid, const char *binary_path,
> > +                      const char *usdt_provider, const char *usdt_name,
> > +                      const struct bpf_usdt_opts *opts);
> > +

[...]

> > +struct usdt_manager {
> > +     struct bpf_map *specs_map;
> > +     struct bpf_map *ip_to_id_map;
> > +
> > +     bool has_bpf_cookie;
> > +     bool has_sema_refcnt;
> > +};
> > +
> > +struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> > +{
> > +     static const char *ref_ctr_sysfs_path = "/sys/bus/event_source/devices/uprobe/format/ref_ctr_offset";
>
> probably deserves a #define, and that would get us under the 100 char
> limit too..

If you look at a few other places around kprobe and uprobe, I
consciously don't do that. #define for string constant that is used
only once just makes reading code harder, as you have to jump around
more to figure out the exact file path (especially when you are trying
to follow the steps in the shell). So I'd rather keep it as is.

>
> > +     struct usdt_manager *man;
> > +     struct bpf_map *specs_map, *ip_to_id_map;
> > +
> > +     specs_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs");
> > +     ip_to_id_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs_ip_to_id");
> > +     if (!specs_map || !ip_to_id_map) {
> > +             pr_warn("usdt: failed to find USDT support BPF maps, did you forget to include bpf/usdt.bpf.h?\n");
>
> nice, I like the fact the error message also tells you how to fix it!
>
> > +             return NULL;
> > +     }
> > +

[...]

> > +struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct bpf_program *prog,
> > +                                       pid_t pid, const char *path,
> > +                                       const char *usdt_provider, const char *usdt_name,
> > +                                       long usdt_cookie)
> > +{
> > +     int i, fd, err;
> > +     LIBBPF_OPTS(bpf_uprobe_opts, opts);
> > +     struct bpf_link_usdt *link = NULL;
> > +     struct usdt_target *targets = NULL;
> > +     size_t target_cnt;
> > +     Elf *elf;
>
> Thought we should probably init elf to NULL, though I see we don't goto
> err_out except in cases where it's been explicitly set.

yep. Though some versions of GCC or Clang sometimes report false
positive in similar cases, so I might as well init it.

>
> > +
> > +     if (bpf_program__fd(prog) < 0) {
> > +             pr_warn("prog '%s': can't attach BPF program w/o FD (did you load it?)\n",
>
> nit: might be no harm "w/o" to expand to "without", and prefix with usdt:
> as below..

it's the same check as in all other bpf_program__attach_xxx() APIs, so
I wanted to keep it consistent. But I just realized that I should
probably move it into bpf_program__attach_usdt() itself.

>
> > +                     bpf_program__name(prog));
> > +             return libbpf_err_ptr(-EINVAL);
> > +     }
> > +
> > +     /* TODO: perform path resolution similar to uprobe's */
> > +     fd = open(path, O_RDONLY);
> > +     if (fd < 0) {
> > +             err = -errno;
> > +             pr_warn("usdt: failed to open ELF binary '%s': %d\n", path, err);
> > +             return libbpf_err_ptr(err);
> > +     }
> > +
> > +     elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
> > +     if (!elf) {
> > +             err = -EBADF;
> > +             pr_warn("usdt: failed to parse ELF binary '%s': %s\n", path, elf_errmsg(-1));
> > +             goto err_out;
> > +     }
> > +
> > +     err = sanity_check_usdt_elf(elf, path);
> > +     if (err)
> > +             goto err_out;
> > +
> > +     /* normalize PID filter */
> > +     if (pid < 0)
> > +             pid = -1;
> > +     else if (pid == 0)
> > +             pid = getpid();
> > +
> > +     /* discover USDT in given binary, optionally limiting
> > +      * activations to a given PID, if pid > 0
> > +      */
> > +     err = collect_usdt_targets(man, elf, path, pid, usdt_provider, usdt_name,
> > +                                usdt_cookie, &targets, &target_cnt);
> > +     if (err <= 0) {
>
> we haven't filled out collect_usdt_targets() yet, but might be no harm to
> have a pr_debug() here "usdt: cannot collect USDT targets for ..." since
> there are a few cases without warnings in the later patch.

I'd have to special case -ENOENT, which would be messy. The reason
some returns don't have pr_warn() in collect_usdt_targets() is that I
deemed them extremely unlikely (usually it's due to corrupted ELF or
something along those lines). But I'll double check and add pr_warn
where appropriate.


>
> > +             err = (err == 0) ? -ENOENT : err;
> > +             goto err_out;
> > +     }
> > +

[...]
