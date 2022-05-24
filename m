Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5532C5333E2
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 01:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiEXXYD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 19:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiEXXYC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 19:24:02 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8B35D643
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 16:24:01 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y8so56783iof.10
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9Yewz0dsdPTkQO2TbYDPXl9tKvgv3C/kv22O1PLDwo=;
        b=byJxez5doT55FcxAGP5fgn8q6Aw96C2yUhE263bW95niWlo/NMe7AjTAYbOG1OAWrJ
         tPug1fcXlP59NvVgDbP0vhe/K0b6pkJHOXn2+b7RMXuPoWlZM7YYlE8ksxqTFjlcVuuJ
         4AWWMGrM87Th9ZnJy1M2vXRqXuLuXYTn4+ilR++uXE6EfxAyKurKfAWTDrJ2NEAo7IZA
         Dq6zPUpf5SHRYatXljpSPMbXCyI4Mr2RCgbJ2IDk4/eXrxjdv8YJa6P0RNplkML9LTsO
         KP1LseRsd9clGhiW6nCVEshtqExUfA7+YdosHoeupNTbpfCU+7kNOEVfVqH7U3i/wr77
         NrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9Yewz0dsdPTkQO2TbYDPXl9tKvgv3C/kv22O1PLDwo=;
        b=sSRqN3M0hkwRFElxA1hycOW5ZKFcO8WyI9Dr7MYSzhzkglE/cAU8IuTI31hZDSanYO
         RUNOQ2PodigqYRhnSLa1ECyx9tiMTW1+94FcSz0vt6EbO9KSG77AEcLTnwBRi6kLsck9
         fYezOXjU/V6LvHJmk738v0iUKEPI9l65AIuRxoHiQuisCrDM6BpMXgqOhaBJg5zejuVy
         T6euyT6tDfqUAMA3P25A6D2L+jpnSEMfiAYSa5eroN7FqfN8nldYwnG2qjlhWeNdfoiG
         nzbnKTep4d9RqPgUF2KCrv//a8JQx+Vn4N9iC70gKnPikCwLWuD257c4d1lpT/Pf/0DI
         LjmA==
X-Gm-Message-State: AOAM532zqmn9N5k+Rwt2dXQU58eWrsBTMeBg0zcaaMrntZmLxZEkSyxW
        JqK+rJ7svIkHWMuNo/WxOubvHz69LF7mjWw92ow=
X-Google-Smtp-Source: ABdhPJxgvpwn3CpjBHb5TyO+NQHCTk1zQ0lcTcEkuRAX0PwFcBhynb9pHMsB150OmmnNeMqRKPypfUueNmEPjKEYvaw=
X-Received: by 2002:a05:6602:248f:b0:65a:fb17:7a6b with SMTP id
 g15-20020a056602248f00b0065afb177a6bmr12989823ioe.79.1653434640888; Tue, 24
 May 2022 16:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220510205923.3206889-1-kuifeng@fb.com> <20220510205923.3206889-2-kuifeng@fb.com>
 <20220520205118.cw6g2ozxzub52otf@kafai-mbp> <CAEf4BzbxjUqFRcF8qzEnqhJ02GWrqS4ukuEC8m7SnXAPGN=p_w@mail.gmail.com>
 <20220524230348.5lkt6ufx6b4nfde6@kafai-mbp>
In-Reply-To: <20220524230348.5lkt6ufx6b4nfde6@kafai-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 24 May 2022 16:23:49 -0700
Message-ID: <CAEf4Bza0=p7Wkx8Thm4yAegbZX+=Rox6kEi-VQsfMF=qZ0yG9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/5] bpf, x86: Generate trampolines from bpf_tramp_links
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, May 24, 2022 at 4:03 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, May 24, 2022 at 03:30:31PM -0700, Andrii Nakryiko wrote:
> > On Fri, May 20, 2022 at 1:51 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Tue, May 10, 2022 at 01:59:19PM -0700, Kui-Feng Lee wrote:
> > > [ ... ]
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -1013,6 +1013,7 @@ enum bpf_link_type {
> > > >       BPF_LINK_TYPE_XDP = 6,
> > > >       BPF_LINK_TYPE_PERF_EVENT = 7,
> > > >       BPF_LINK_TYPE_KPROBE_MULTI = 8,
> > > > +     BPF_LINK_TYPE_STRUCT_OPS = 9,
> > > Sorry for the late question.  I just noticed it while looking at the
> > > cgroup-lsm set.
> > >
> > > Does BPF_LINK_TYPE_STRUCT_OPS need to be in the uapi?
> > > The current links of the struct_ops progs should not be
> > > visible to the user space.
> > >
> >
> > bpf_link_init() expects link_type to be specified, so we have to
> > provide some value. We probably could have specified
> > BPF_LINK_TYPE_UNSPEC, but that seems wrong. But right now those links
> > are not going to be visible outside as they don't get their ID
> > allocated (no bpf_link_settle() call), so we just basically have a
> > reserved enum for future STRUCT_OPS link, if we ever add it
> > explicitly.
> I was also thinking BPF_LINK_TYPE_UNSPEC could have been used
> since the user space cannot get a hold of those kernel internal
> links which is one link for one struct_ops's prog.
>
> I was asking because the current bpf_link libbpf api for struct_ops has
> already caused confusion as if there was a kernel supported bpf_link for
> the struct_ops map (kernel supported bpf_link is where we want to do
> in the future).  The new BPF_LINK_TYPE_STRUCT_OPS in the uapi here may
> have added some more confusion on this.
>
> I don't mind to keep it here as a enum holder.  just want to double
> check it is not useful to the userspace now and can be reused later, and
> probably need something else for the current struct_ops's prog link.

Yeah, it shouldn't be exposed to user-space right now.
