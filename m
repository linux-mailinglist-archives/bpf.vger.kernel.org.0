Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0957C0D9
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 01:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiGTX0j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 19:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGTX0i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 19:26:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBB2D1FA
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 16:26:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o12so159063pfp.5
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 16:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biQfKVkYP0pKtswQt3kzw1zka1n8k/er3b8pHLQhGbo=;
        b=QSNpm6ni7NgkQBZuAHl6j2XjdW//Yi/pj60mJ8jm5LMKQG6g4kChOUNyLkBg71iOvO
         LEMFv98cDlIlunj0UuXI8eOwhFqwUAucR+V0O/mDZURxCvChdgGdMhVBXuFmepN1GfLy
         Cuy+II6JY0jdQR5I4Cdn1nzSOzu603+4vjcMKPdFFUyu6TqfSZtkjoM1mbwXqKezGfOI
         PuomCkFSly8cNiY8Qa+AU0hNSArl3yhTlU0Dmrj6xjqmZLyvuAQP5RYITdLdQ7qeo/y4
         uxMLDZ6eJRt5s35+/aKfOxbms7Ef0dEFmFwMLkAwP7nmwDB0YAau/NeokqWKKOupkA+C
         yB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biQfKVkYP0pKtswQt3kzw1zka1n8k/er3b8pHLQhGbo=;
        b=Fqsm3c48pyBEmC7LTz0Ine3bUf6lMQzlyOmgfztj0ogGlnHcCkq2RZqw6hki2r2WGk
         Bebd5lbCv0qWU08wsHeBuLxa73BJjJn5K9nPIiQdHXjA+oz18CMF+pCbeRUTfnFoftJS
         PbiR+/LTexNrxTkbYS5gZKS5ho6SjQKtWcKJezNbQIFi+o8a80UGj9yJkqZAKZbB4n2g
         pi9TPpBY9L8t+G1xXUgpbixlBM0H1tb+etjm15/t+t7KRkUFRIf3YaEaDUFdFFU3h06J
         KCQE0wAueK8oafIckxD9RnXlLntlXCqfaC8wAtDkIP2FBwjsVpm7yeKtFqI1p/qAu+x0
         1yog==
X-Gm-Message-State: AJIora9En9Fy4efLyx/3VRdhkzWtRQNhx/FWMIsXJ4bN+NXXO8xvgCVW
        SD6PTHJh7mt9NatdDW4oPxLjZT5S7+Xpch3S9aFACw==
X-Google-Smtp-Source: AGRyM1t0P4fuHckbHl2pK6lXBgp1lrSKqcFhSdGxUQLjPoxHBQJykdV36MkckdP1DgzKclwel/JrBsO63EydO9Y3GGY=
X-Received: by 2002:a65:4c0b:0:b0:415:d3a4:44d1 with SMTP id
 u11-20020a654c0b000000b00415d3a444d1mr36349247pgq.191.1658359597244; Wed, 20
 Jul 2022 16:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
 <179cfb89be0e4f928a55d049fe62aa9e@huawei.com> <CAKH8qBt0yR+mtCjAp=8jQL4M6apWQk0wH7Zf4tPDCf3=m+gAKA@mail.gmail.com>
 <31473ddf364f4f16becfd5cd4b9cd7d2@huawei.com> <CAKH8qBsFg5gQ0bqpVtYhiQx=TqJG31c8kfsbCG4X57QGLOhXvw@mail.gmail.com>
 <0c284e09817e4e699aa448aa25af5d79@huawei.com> <CAKH8qBvwzVPY1yJM_FjdH5QptVkZz=j9Ph7pTPCbTLdY1orKJg@mail.gmail.com>
 <c9c203821a854e33970fd10e01632cb7@huawei.com> <CAKH8qBuazK5PwDYAG2bPGfyASAMQAd4_dpFjcW0KYz4ON+kj3g@mail.gmail.com>
 <bf326b7c927a475cae33b89416c1b082@huawei.com> <CAKH8qBtgHK4dpoJzkq2q7rj37Ep9peEPE-3GBu=QqxUU8YVrPQ@mail.gmail.com>
 <8fe67e829d95477d884131641ca0961d@huawei.com>
In-Reply-To: <8fe67e829d95477d884131641ca0961d@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Jul 2022 16:26:26 -0700
Message-ID: <CAKH8qBtQwy=J-tpr86ALrjiFeXNJYLxgfDfDEE=8FFOKdbVu3A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Joe Burton <jevburton.kernel@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Burton <jevburton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 4:17 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Stanislav Fomichev [mailto:sdf@google.com]
> > Sent: Thursday, July 21, 2022 1:15 AM
> > On Wed, Jul 20, 2022 at 4:12 PM Roberto Sassu <roberto.sassu@huawei.com>
> > wrote:
> > >
> > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > Sent: Thursday, July 21, 2022 1:09 AM
> > > > On Wed, Jul 20, 2022 at 4:02 PM Roberto Sassu
> > <roberto.sassu@huawei.com>
> > > > wrote:
> > > > >
> > > > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > > > Sent: Thursday, July 21, 2022 12:48 AM
> > > > > > On Wed, Jul 20, 2022 at 3:44 PM Roberto Sassu
> > > > <roberto.sassu@huawei.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > > > > > Sent: Thursday, July 21, 2022 12:38 AM
> > > > > > > > On Wed, Jul 20, 2022 at 3:30 PM Roberto Sassu
> > > > > > <roberto.sassu@huawei.com>
> > > > > > > > wrote:
> > > > > > > > >
> > > > > > > > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > > > > > > > Sent: Wednesday, July 20, 2022 5:57 PM
> > > > > > > > > > On Wed, Jul 20, 2022 at 1:02 AM Roberto Sassu
> > > > > > > > <roberto.sassu@huawei.com>
> > > > > > > > > > wrote:
> > > > > > > > > > >
> > > > > > > > > > > > From: Stanislav Fomichev [mailto:sdf@google.com]
> > > > > > > > > > > > Sent: Tuesday, July 19, 2022 10:40 PM
> > > > > > > > > > > > On Tue, Jul 19, 2022 at 12:40 PM Joe Burton
> > > > > > > > <jevburton.kernel@gmail.com>
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > From: Joe Burton <jevburton@google.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > Add an extensible variant of bpf_obj_get() capable of setting
> > the
> > > > > > > > > > > > > `file_flags` parameter.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This parameter is needed to enable unprivileged access to
> > BPF
> > > > > > maps.
> > > > > > > > > > > > > Without a method like this, users must manually make the
> > > > syscall.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Joe Burton <jevburton@google.com>
> > > > > > > > > > > >
> > > > > > > > > > > > Reviewed-by: Stanislav Fomichev <sdf@google.com>
> > > > > > > > > > > >
> > > > > > > > > > > > For context:
> > > > > > > > > > > > We've found this out while we were trying to add support for
> > > > unpriv
> > > > > > > > > > > > processes to open pinned r-x maps.
> > > > > > > > > > > > Maybe this deserves a test as well? Not sure.
> > > > > > > > > > >
> > > > > > > > > > > Hi Stanislav, Joe
> > > > > > > > > > >
> > > > > > > > > > > I noticed now this patch. I'm doing a broader work to add opts
> > > > > > > > > > > to bpf_*_get_fd_by_id(). I also adjusted permissions of bpftool
> > > > > > > > > > > depending on the operation type (e.g. show, dump:
> > > > BPF_F_RDONLY).
> > > > > > > > > > >
> > > > > > > > > > > Will send it soon (I'm trying to solve an issue with the CI, where
> > > > > > > > > > > libbfd is not available in the VM doing actual tests).
> > > > > > > > > >
> > > > > > > > > > Is something like this patch included in your series as well? Can
> > you
> > > > > > > > > > use this new interface or do you need something different?
> > > > > > > > >
> > > > > > > > > It is very similar. Except that I called it bpf_get_fd_opts, as it
> > > > > > > > > is shared with the bpf_*_get_fd_by_id() functions. The member
> > > > > > > > > name is just flags, plus an extra u32 for alignment.
> > > > > > > >
> > > > > > > > We can bikeshed the naming, but we've been using existing
> > conventions
> > > > > > > > where opts fields match syscall fields, that seems like a sensible
> > > > > > > > thing to do?
> > > > > > >
> > > > > > > The only problem is that bpf_*_get_fd_by_id() functions would
> > > > > > > set the open_flags member of bpf_attr.
> > > > > > >
> > > > > > > Flags would be good for both, even if not exact. Believe me,
> > > > > > > duplicating the opts would just create more confusion.
> > > > > >
> > > > > > Wait, that's completely different, right? We are talking here about
> > > > > > BPF_OBJ_GET (which has related BPF_OBJ_PIN).
> > > > > > Your GET_XXX_BY_ID are different so you'll still have to have another
> > > > > > wrapper with opts?
> > > > >
> > > > > Yes, they have different wrappers, just accept the same opts as
> > > > > obj_get(). From bpftool subcommands you want to set the correct
> > > > > permission, and propagate it uniformly to bpf_*_get_fd_by_id()
> > > > > or obj_get(). See map_parse_fds().
> > > >
> > > > I don't think they are accepting the same opts.
> > > >
> > > > For our case, we care about:
> > > >
> > > >         struct { /* anonymous struct used by BPF_OBJ_* commands */
> > > >                 __aligned_u64   pathname;
> > > >                 __u32           bpf_fd;
> > > >                 __u32           file_flags;
> > > >         };
> > > >
> > > > For your case, you care about:
> > > >
> > > >         struct { /* anonymous struct used by BPF_*_GET_*_ID */
> > > >                 union {
> > > >                         __u32           start_id;
> > > >                         __u32           prog_id;
> > > >                         __u32           map_id;
> > > >                         __u32           btf_id;
> > > >                         __u32           link_id;
> > > >                 };
> > > >                 __u32           next_id;
> > > >                 __u32           open_flags;
> > > >         };
> > > >
> > > > So your new _opts libbpf routine should be independent of what Joe is
> > > > doing here.
> > >
> > > It is. Just I use the same opts to set file_flags or open_flags.
> >
> > That seems confusing. Let's have separate calls for separate syscall
> > commands as we do already?
>
> Can you wait one day, I send what I have, so that we see
> everything together?

Sure, CC us both on the patches.
