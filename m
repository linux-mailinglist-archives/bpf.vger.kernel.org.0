Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738FA4C2127
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 02:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiBXBkv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 20:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiBXBks (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 20:40:48 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D1110A
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 17:40:20 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id v5so659646qkj.4
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 17:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0+yvP+F0EsSuoYlT67FNUqaSTeigpT+q0Adpduwy5E=;
        b=PKlhuVKsNrEUVyGzqvCwpR8pOqGCDrmzI7od+f6QUwpI4cmRgdMiZkhC5ZyCbdVKht
         YDd6YnwP1YyLrazZS6FiQPbDdXWPhDuMTIgbXeHtIZTdWhdy6R2FcZh8vyYb7PN4QLGa
         Bf4Hs/73etduJ2HA/jcIzkMAmCVnSPpnrt41CtswnJO4g5BnMddF2fk2FnfNjBrYQxEg
         Pt1wVmjrz/iyWUmePS2L/K8+pz3Y5VUOf5kHlBTC2AGYOktfHzjue9EzRDvDo0BpYkGF
         Oa7GDG/lKeJffigWDZnuuvB9hut5Vlqah1bHh3Ut5kTCxtK3+iQi3CixsxR1VBGwIsbK
         yXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0+yvP+F0EsSuoYlT67FNUqaSTeigpT+q0Adpduwy5E=;
        b=a94/+WnCnIjZBHs0rE9FChUvW+DLZi39ItBgGudUsHYcATBvVfUyPnTiOpX3+4E7Vk
         mwWiwCAMK99qbYyJQvPyaGTp6dwWDHYbV1T3XBnuEZ20XMAfftSJWx9++iQIF7eeL21u
         nbZdBBna9r1bs+1l5xnDZY0g4aOmcPNTt8jIrbxU+5XB64urkLAzAR/BKSax+FIeFt5y
         OIRWpid8qhHUDlPt7Fb3IQLOILdk0YCyU8lNfaXFWPfhWDgAjix6Q9H+9sFWoHmIEv2A
         q0hVLzhrugt0bjqAP3h3rlweM/rmLHKoPPD0xESqdzE5Ve/vVYLAR5qjKMlJ+HfORyax
         NqJw==
X-Gm-Message-State: AOAM530E1BvVl3uCnzRr8fJ1rk2UuoRScZvScz6CcuwB+D6H5OQF/lp8
        AZe+1hiF070IrvR/RUWdZoy/+YPTcffRFHBDOduZhhEyYuIWfg==
X-Google-Smtp-Source: ABdhPJwnnHMIdkfAYafPTW474UNEZq4sloTVO0KQ5JUKtN+zfBR0/VtawBwUv/EAyao0Tl6ABMKKCTTR57iai/snwLE=
X-Received: by 2002:a05:622a:178b:b0:2dd:cbdf:ae23 with SMTP id
 s11-20020a05622a178b00b002ddcbdfae23mr403443qtk.566.1645665123836; Wed, 23
 Feb 2022 17:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com> <CAEf4Bzb44WR2LiYchxB5JZ=Jdie6FEEi90mh=SCv07v4h4W11w@mail.gmail.com>
 <CA+khW7h4bL3qUst4nDy6LDmx73xVA_ch=PLc=o=v2iJNbGn21A@mail.gmail.com> <CAEf4BzaYxgnotk+J+czhAjXbfzEoOrnyiVMmmkjDDVHzYUs48A@mail.gmail.com>
In-Reply-To: <CAEf4BzaYxgnotk+J+czhAjXbfzEoOrnyiVMmmkjDDVHzYUs48A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 23 Feb 2022 17:11:52 -0800
Message-ID: <CA+khW7ir8DTkVUae64wW9ju8fj9=gW5NHgAJ65ixvYsbubVr-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 23, 2022 at 5:10 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 23, 2022 at 4:33 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 4:11 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Feb 23, 2022 at 4:05 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > For binaries that are statically linked, consecutive stack frames are
> > > > likely to be in the same VMA and therefore have the same build id.
> > > > As an optimization for this case, we can cache the previous frame's
> > > > VMA, if the new frame has the same VMA as the previous one, reuse the
> > > > previous one's build id. We are holding the MM locks as reader across
> > > > the entire loop, so we don't need to worry about VMA going away.
> > > >
> > > > Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> > > > test_progs.
> > > >
> > > > Suggested-by: Greg Thelen <gthelen@google.com>
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
> > >
> > > LGTM. Can you share performance numbers before and after?
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> >
> > Thanks Andrii.
> >
> > On a real-world workload, we observed that 66% of cpu cycles in
> > __bpf_get_stackid() were spent on build_id_parse() and find_vma().
> > This was before.
> >
> > We haven't evaluated the performance with this patch yet. This
> > optimization seems straightforward, so we plan to upstream it first
> > and then retest.
>
> Ok, once it lands upstream, I'd really appreciate if you can retest
> and update us with numbers. Thanks!

Sure, will do that.
