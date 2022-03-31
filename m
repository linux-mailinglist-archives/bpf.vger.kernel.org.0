Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7908E4EE184
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 21:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiCaTPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiCaTP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 15:15:29 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE923B84F
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:13:41 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 9so656998iou.5
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3LcbX89G+wJBqf8XgF5XsY+QQwikYzu2pI1pDzqd8g=;
        b=Q+96iO9GHmMch2AUBwY2MwPPZg1skV37Yt0lqQ2OW3B85LhIyWRKrjpicwrQLC3DHW
         K/gMNUVN32T5z8fBd9uEZk+ca5a+ptbIQuLZjX6Jk6moXXELyt+oLW4GLY6lv6cftyO4
         sY6gHo2aO1vIZ1REdkbba6kmxnbqc9rtiyCbxO8r0NUSYT5KzbXkS5oMxXY1rCiKPFJ6
         3FE0unV2mS/HzPLDMF0xu5X235FgDb8bHvJh1rQmwOWa5TlhtyvONcgLUg5+jyOB2D6V
         MqoJbo0mYSSeqS8y2hWqc7aFK+rPfX9zeCENsFSdmuP0T+3UppmasH4nbMWfyCo8RP1M
         RePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3LcbX89G+wJBqf8XgF5XsY+QQwikYzu2pI1pDzqd8g=;
        b=jLyxa/RZ3DOAAD6WncQvoeZPQyREoqAaYYqRFyC5A7mqWPFDxVjUTbxmNFpEIVwWO5
         sgAyk23MGlKKhdLUnwe5xlow3F0NG8NHXnu7vhCXzICfIaqXGUB+HES6tAw7+OVwKJ7i
         MJrqxF8ekLbyRFFR1LuDYtC65i7K9ZycgHXCYv2lr6OMz/WQwFlZxWQctJur1kzFFxeq
         OnM1bUKaRsajNHa9EK436nS0FfIcPBs3DE2qWjYJUndVCBzMGGz/UyLxsAkIpdvfOVIE
         l7cZpvujUCDcj+yJKwbZyraf7IcjqNqXVdisuH3EODa4ETlTUx14+K7E4cS1e6gU9T48
         ntZA==
X-Gm-Message-State: AOAM531vpcz91SMzkvbXWAb9zHAtTa0OL8EO3Ngz1sJNAg78sCp0kFni
        rWYn0dd34P86AuCl18uQ+z00gekhLB/oS1PXgrwqZCwR
X-Google-Smtp-Source: ABdhPJyrdNTb6djVA1eW1pQxIuPS8wmMRV8/qzR47+35JL3syYXK+BVoQkSuGKOLdOj4XEEehVr3Wid8KLMYzwm/cyQ=
X-Received: by 2002:a05:6602:3c6:b0:63d:cac9:bd35 with SMTP id
 g6-20020a05660203c600b0063dcac9bd35mr15136149iov.144.1648754020993; Thu, 31
 Mar 2022 12:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-4-andrii@kernel.org>
 <alpine.LRH.2.23.451.2203311405350.25204@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2203311405350.25204@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 31 Mar 2022 12:13:30 -0700
Message-ID: <CAEf4BzYHx+FwAoG6sSh5xwxTQKOzTmoRB7Es3O3mJ76fLdm5gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] libbpf: add USDT notes parsing and
 resolution logic
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

On Thu, Mar 31, 2022 at 6:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 25 Mar 2022, Andrii Nakryiko wrote:
>
> > Implement architecture-agnostic parts of USDT parsing logic. The code is
> > the documentation in this case, it's futile to try to succinctly
> > describe how USDT parsing is done in any sort of concreteness. But
> > still, USDTs are recorded in special ELF notes section (.note.stapsdt),
> > where each USDT call site is described separately. Along with USDT
> > provider and USDT name, each such note contains USDT argument
> > specification, which uses assembly-like syntax to describe how to fetch
> > value of USDT argument. USDT arg spec could be just a constant, or
> > a register, or a register dereference (most common cases in x86_64), but
> > it technically can be much more complicated cases, like offset relative
> > to global symbol and stuff like that. One of the later patches will
> > implement most common subset of this for x86 and x86-64 architectures,
> > which seems to handle a lot of real-world production application.
> >
> > USDT arg spec contains a compact encoding allowing usdt.bpf.h from
> > previous patch to handle the above 3 cases. Instead of recording which
> > register might be needed, we encode register's offset within struct
> > pt_regs to simplify BPF-side implementation. USDT argument can be of
> > different byte sizes (1, 2, 4, and 8) and signed or unsigned. To handle
> > this, libbpf pre-calculates necessary bit shifts to do proper casting
> > and sign-extension in a short sequences of left and right shifts.
> >
> > The rest is in the code with sometimes extensive comments and references
> > to external "documentation" for USDTs.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> nothing major below, might be no harm to use a common header for
> some definitions for usdt.bpf.h and usdt.c..
>
> > ---
> >  tools/lib/bpf/usdt.c | 581 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 580 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index 8481e300598e..86d5d8390eb1 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -18,10 +18,56 @@
> >
> >  #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
> >
>
> unused?

yep, seems like I just rely on opts.ref_ctr_offset for this

>
> > +#define USDT_BASE_SEC ".stapsdt.base"
> > +#define USDT_SEMA_SEC ".probes"
>
> unused?

indeed, libbpf will support semaphores defined in any section, not
just ".probes". But it feels good to have .stapsdt.base, .note.stapsdt
and .probes (all the ELF sections involved) to be defined as constants
here. So maybe I'll keep it as a documentation?

>
> > +#define USDT_NOTE_SEC  ".note.stapsdt"
> > +#define USDT_NOTE_TYPE 3
> > +#define USDT_NOTE_NAME "stapsdt"
> > +
> > +/* should match exactly enum __bpf_usdt_arg_type from bpf_usdt.bpf.h */
> > +enum usdt_arg_type {
> > +     USDT_ARG_CONST,
> > +     USDT_ARG_REG,
> > +     USDT_ARG_REG_DEREF,
> > +};
> > +
> > +/* should match exactly struct __bpf_usdt_arg_spec from bpf_usdt.bpf.h */
> > +struct usdt_arg_spec {
> > +     __u64 val_off;
> > +     enum usdt_arg_type arg_type;
> > +     short reg_off;
> > +     bool arg_signed;
> > +     char arg_bitshift;
> > +};
> > +
> > +/* should match BPF_USDT_MAX_ARG_CNT in usdt.bpf.h */
> > +#define USDT_MAX_ARG_CNT 12
> > +
> > +/* should match struct __bpf_usdt_spec from usdt.bpf.h */
> > +struct usdt_spec {
> > +     struct usdt_arg_spec args[USDT_MAX_ARG_CNT];
> > +     __u64 usdt_cookie;
> > +     short arg_cnt;
> > +};
> > +
>
> Would it be worth having a usdt.h that both usdt.bpf.h and usdt.c could
> #include, containing the above definitions, avoiding need to sync?

that's how I started initially, but then decided that one extra header
just for two structs and enum is a bit too much. It's quite unlikely
that they will be changed often or will get out of sync, I think...

>
> > +struct usdt_note {
> > +     const char *provider;
> > +     const char *name;
> > +     /* USDT args specification string, e.g.:
> > +      * "-4@%esi -4@-24(%rbp) -4@%ecx 2@%ax 8@%rdx"
> > +      */

[...]

> > -     return -ENOTSUP;
> > +     size_t off, name_off, desc_off, seg_cnt = 0, lib_seg_cnt = 0, target_cnt = 0;
> > +     struct elf_seg *segs = NULL, *lib_segs = NULL;
> > +     struct usdt_target *targets = NULL, *target;
> > +     long base_addr = 0;
> > +     Elf_Scn *notes_scn, *base_scn;
> > +     GElf_Shdr base_shdr, notes_shdr;
> > +     GElf_Ehdr ehdr;
> > +     GElf_Nhdr nhdr;
> > +     Elf_Data *data;
> > +     int err;
> > +
> > +     *out_targets = NULL;
> > +     *out_target_cnt = 0;
> > +
> > +     err = find_elf_sec_by_name(elf, USDT_NOTE_SEC, &notes_shdr, &notes_scn);
> > +     if (err)
>
> since find_elf_sec_by_name() doesn't log anything, would be good to have a
> pr_warn("usdt: no " USDT_NOTE_SEC " section in '%s'", path);

ok

> > +             return err;
> > +
> > +     if (notes_shdr.sh_type != SHT_NOTE)
> > +             return -EINVAL;
> > +
> > +     if (!gelf_getehdr(elf, &ehdr))
> > +             return -EINVAL;
> > +
>
> the above two are unlikely, but could perhaps benefit from an error
> message like below..

yeah, super unlikely, but I can combine the two and log warning

>
> > +     err = parse_elf_segs(elf, path, &segs, &seg_cnt);
> > +     if (err) {
> > +             pr_warn("usdt: failed to process ELF program segments for '%s': %d\n", path, err);
> > +             goto err_out;
> > +     }
> > +
> > +     /* .stapsdt.base ELF section is optional, but is used for prelink
> > +      * offset compensation (see a big comment further below)
> > +      */
> > +     if (find_elf_sec_by_name(elf, USDT_BASE_SEC, &base_shdr, &base_scn) == 0)
> > +             base_addr = base_shdr.sh_addr;
> > +
> > +     data = elf_getdata(notes_scn, 0);
> > +     off = 0;
> > +     while ((off = gelf_getnote(data, off, &nhdr, &name_off, &desc_off)) > 0) {
> > +             long usdt_abs_ip, usdt_rel_ip, usdt_sema_off = 0;
> > +             struct usdt_note note;
> > +             struct elf_seg *seg = NULL;
> > +             void *tmp;
> > +
> > +             err = parse_usdt_note(elf, path, base_addr, &nhdr,
> > +                                   data->d_buf, name_off, desc_off, &note);
> > +             if (err)
> > +                     goto err_out;
> > +
> > +             if (strcmp(note.provider, usdt_provider) != 0 || strcmp(note.name, usdt_name) != 0)
> > +                     continue;
> > +
> > +             /* We need to compensate "prelink effect". See [0] for details,
> > +              * relevant parts quoted here:
> > +              *
> > +              * Each SDT probe also expands into a non-allocated ELF note. You can
> > +              * find this by looking at SHT_NOTE sections and decoding the format;
> > +              * see below for details. Because the note is non-allocated, it means
> > +              * there is no runtime cost, and also preserved in both stripped files
> > +              * and .debug files.
> > +              *
> > +              * However, this means that prelink won't adjust the note's contents
> > +              * for address offsets. Instead, this is done via the .stapsdt.base
> > +              * section. This is a special section that is added to the text. We
> > +              * will only ever have one of these sections in a final link and it
> > +              * will only ever be one byte long. Nothing about this section itself
> > +              * matters, we just use it as a marker to detect prelink address
> > +              * adjustments.
> > +              *
> > +              * Each probe note records the link-time address of the .stapsdt.base
> > +              * section alongside the probe PC address. The decoder compares the
> > +              * base address stored in the note with the .stapsdt.base section's
> > +              * sh_addr. Initially these are the same, but the section header will
> > +              * be adjusted by prelink. So the decoder applies the difference to
> > +              * the probe PC address to get the correct prelinked PC address; the
> > +              * same adjustment is applied to the semaphore address, if any.
> > +              *
> > +              *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> > +              */
>
> ouch. nice explanation!
>
> > +             usdt_rel_ip = usdt_abs_ip = note.loc_addr;
> > +             if (base_addr) {
> > +                     usdt_abs_ip += base_addr - note.base_addr;
> > +                     usdt_rel_ip += base_addr - note.base_addr;
> > +             }
> > +
> > +             if (ehdr.e_type == ET_EXEC) {
>
> should we use a bool is_shared_library here; might simplify debug
> messaging below...

Heh, I actually started out with is_shared_library variable, but ended
up preferring more explicit ET_EXEC and ET_DYN constants instead.

>
> > +                     /* When attaching uprobes (which what USDTs basically
> > +                      * are) kernel expects a relative IP to be specified,
> > +                      * so if we are attaching to an executable ELF binary
> > +                      * (i.e., not a shared library), we need to calculate
> > +                      * proper relative IP based on ELF's load address
> > +                      */
> > +                     seg = find_elf_seg(segs, seg_cnt, usdt_abs_ip, false /* relative */);
> > +                     if (!seg) {
> > +                             err = -ESRCH;
> > +                             pr_warn("usdt: failed to find ELF program segment for '%s:%s' in '%s' at IP 0x%lx\n",
> > +                                     usdt_provider, usdt_name, path, usdt_abs_ip);
> > +                             goto err_out;
> > +                     }
> > +                     if (!seg->is_exec) {
> > +                             err = -ESRCH;
> > +                             pr_warn("usdt: matched ELF binary '%s' segment [0x%lx, 0x%lx) for '%s:%s' at IP 0x%lx is not executable\n",
> > +                                     path, seg->start, seg->end, usdt_provider, usdt_name,
> > +                                     usdt_abs_ip);
> > +                             goto err_out;
> > +                     }
> > +
> > +                     usdt_rel_ip = usdt_abs_ip - (seg->start - seg->offset);
> > +             } else if (!man->has_bpf_cookie) { /* ehdr.e_type == ET_DYN */
> > +                     /* If we don't have BPF cookie support but need to
> > +                      * attach to a shared library, we'll need to know and
> > +                      * record absolute addresses of attach points due to
> > +                      * the need to lookup USDT spec by absolute IP of
> > +                      * triggered uprobe. Doing this resolution is only
> > +                      * possible when we have a specific PID of the process
> > +                      * that's using specified shared library. BPF cookie
> > +                      * removes the absolute address limitation as we don't
> > +                      * need to do this lookup (we just use BPF cookie as
> > +                      * an index of USDT spec), so for newer kernels with
> > +                      * BPF cookie support libbpf supports USDT attachment
> > +                      * to shared libraries with no PID filter.
> > +                      */
> > +                     if (pid < 0) {
> > +                             pr_warn("usdt: attaching to shared libaries without specific PID is not supported on current kernel\n");
> > +                             err = -ENOTSUP;
> > +                             goto err_out;
> > +                     }
> > +
> > +                     /* lib_segs are lazily initialized only if necessary */
> > +                     if (lib_seg_cnt == 0) {
> > +                             err = parse_lib_segs(pid, path, &lib_segs, &lib_seg_cnt);
> > +                             if (err) {
> > +                                     pr_warn("usdt: failed to get memory segments in PID %d for shared library '%s': %d\n",
> > +                                             pid, path, err);
> > +                                     goto err_out;
> > +                             }
> > +                     }
> > +
> > +                     seg = find_elf_seg(lib_segs, lib_seg_cnt, usdt_rel_ip, true /* relative */);
> > +                     if (!seg) {
> > +                             err = -ESRCH;
> > +                             pr_warn("usdt: failed to find shared lib memory segment for '%s:%s' in '%s' at relative IP 0x%lx\n",
> > +                                      usdt_provider, usdt_name, path, usdt_rel_ip);
> > +                             goto err_out;
> > +                     }
> > +
> > +                     usdt_abs_ip = seg->start + (usdt_rel_ip - seg->offset);
> > +             }
> > +
> > +             pr_debug("usdt: probe for '%s:%s' in %s '%s': addr 0x%lx base 0x%lx (resolved abs_ip 0x%lx rel_ip 0x%lx) args '%s' in segment [0x%lx, 0x%lx) at offset 0x%lx\n",
> > +                      usdt_provider, usdt_name, ehdr.e_type == ET_EXEC ? "exec" : "lib ", path,
> > +                      note.loc_addr, note.base_addr, usdt_abs_ip, usdt_rel_ip, note.args,
> > +                      seg ? seg->start : 0, seg ? seg->end : 0, seg ? seg->offset : 0);
> > +
> > +             /* Adjust semaphore address to be a relative offset */
> > +             if (note.sema_addr) {
> > +                     if (!man->has_sema_refcnt) {
> > +                             pr_warn("usdt: kernel doesn't support USDT semaphore refcounting for '%s:%s' in '%s'\n",
> > +                                     usdt_provider, usdt_name, path);
> > +                             err = -ENOTSUP;
> > +                             goto err_out;
> > +                     }
> > +
> > +                     seg = find_elf_seg(segs, seg_cnt, note.sema_addr, false /* relative */);
> > +                     if (!seg) {
> > +                             err = -ESRCH;
> > +                             pr_warn("usdt: failed to find ELF loadable segment with semaphore of '%s:%s' in '%s' at 0x%lx\n",
> > +                                     usdt_provider, usdt_name, path, note.sema_addr);
> > +                             goto err_out;
> > +                     }
> > +                     if (seg->is_exec) {
> > +                             err = -ESRCH;
> > +                             pr_warn("usdt: matched ELF binary '%s' segment [0x%lx, 0x%lx] for semaphore of '%s:%s' at 0x%lx is executable\n",
> > +                                     path, seg->start, seg->end, usdt_provider, usdt_name,
> > +                                     note.sema_addr);
> > +                             goto err_out;
> > +                     }
> > +
>
> could have a bool "exec" arg to find_elf_seg() which allows/disallows the
> segment to be executable I guess.

find_elf_seg() has already a boolean argument (relative), adding
another one just for this one place seems wrong. And I can provide a
better error message if I do seg->is_exec check here. So I'm leaning
towards leaving it as is.

>
> Alan
