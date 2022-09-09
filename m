Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8D5B3AA1
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIIOYx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIIOYv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 10:24:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB9D13E82
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 07:24:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so4310365ejb.13
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eDVxG2alsJ2zUJ32GcHJov8JxBraRFeNmfdQmlUrAfw=;
        b=EQUH9X3ONKiOXxtnPMOVyyfZa2Tb0KgCTArhXF4LKkosH7SMYmofbQ0aQmT632li2K
         RcTAmZKl5befqycRbwpUSVK4MVxiAnGEToyLdzogo/HZ+7QS88bqme+tiHRoKe/A22RV
         nY5nE2MZ6ujPfwV0UV8ZYozmCVuhkg31fw4Kcng1Eu4LyLZEPboSUlU+uP5hYC42hwLl
         PlvyIH+2MHy4isQv0JeJbZnnFPmBfr1EJJSKAdlOYL8reYZQr2csrdYsBuvq0UOm0QGc
         /XbINNg8irGUtiNP2cA8qwQS2/X7lUnSLYuDDMfRuE0nBnTEXr7foDcKI6Je7o5n6Ios
         LhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eDVxG2alsJ2zUJ32GcHJov8JxBraRFeNmfdQmlUrAfw=;
        b=2xuzGB1ELPnFSnO6Y2WoSthGXwIMbpJXSZrnfoa2PwqtNkB3njiTLNXkQB0I6WABqw
         u5KxSBqWJF//iZPyLjrQ47Humbmzf72ht20p28gBgJ30+6WdLf+OtGtraHIW0gqvhQpc
         7XnT5Wce3WZxy+LNLItQ80vGrRzp55ML3RJrCwS05rXPAvyrYRipKm/6RULHtERHANPO
         o1+cNddimbZlzPV6nCTQngDMgm2vXP7FGcBT8RjGXvAbDc+sC9YJBb0XhXTQmtgrtwVG
         1FbdppntsbxWLwgNKr9h2tqWovxQsli687kbEsZQrMqYdRRx2wHRibGCbOdUMH+xft2R
         St0A==
X-Gm-Message-State: ACgBeo1TDlBV84zyZPOJ3ueDw4LqFvZyBDS/mJwblmEFclpQbPuafrAI
        jq8fgEhG/vohE3VR4+k26PvjBbY2HPTVHrnLL2A=
X-Google-Smtp-Source: AA6agR5I4uGoo0SDf4W+lj5cehlI7FkGRVF+h5B5EEeYnQsKGkOI4YaZcQqFiZArIkfIUlZ8d0qKV21+QR92cRp9VP4=
X-Received: by 2002:a17:906:ef90:b0:730:9cd8:56d7 with SMTP id
 ze16-20020a170906ef9000b007309cd856d7mr9557462ejb.94.1662733487849; Fri, 09
 Sep 2022 07:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
In-Reply-To: <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Sep 2022 07:24:36 -0700
Message-ID: <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
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

On Fri, Sep 9, 2022 at 4:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> > > Global variables reside in maps accessible using direct_value_addr
> > > callbacks, so giving each load instruction's rewrite a unique reg->id
> > > disallows us from holding locks which are global.
> > >
> > > This is not great, so refactor the active_spin_lock into two separate
> > > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > > enough to allow it for global variables, map lookups, and local kptr
> > > registers at the same time.
> > >
> > > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > > lock. But the active_spin_lock_id also needs to be compared to ensure
> > > whether bpf_spin_unlock is for the same register.
> > >
> > > Next, pseudo load instructions are not given a unique reg->id, as they
> > > are doing lookup for the same map value (max_entries is never greater
> > > than 1).
> > >
> >
> > For libbpf-style "internal maps" - like .bss.private further in this series -
> > all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
> >
> >   struct bpf_spin_lock lock1 SEC(".bss.private");
> >   struct bpf_spin_lock lock2 SEC(".bss.private");
> >   ...
> >   spin_lock(&lock1);
> >   ...
> >   spin_lock(&lock2);
> >
> > will result in same map but different offsets for the direct read (and different
> > aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
> > this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
> >
>
> That won't be a problem. Two spin locks in a map value or datasec are
> already rejected on BPF_MAP_CREATE,
> so there is no bug. See idx >= info_cnt check in
> btf_find_struct_field, btf_find_datasec_var.
>
> I can include offset as the third part of the tuple. The problem then
> is figuring out which lock protects which bpf_list_head. We need
> another __guarded_by annotation and force users to use that to
> eliminate the ambiguity. So for now I just put it in the commit log
> and left it for the future.

Let's not go that far yet.
Extra annotations are just as confusing and non-obvious as
putting locks in different sections.
Let's keep one lock per map value limitation for now.
libbpf side needs to allow many non-mappable sections though.
Single bss.private name is too limiting.
