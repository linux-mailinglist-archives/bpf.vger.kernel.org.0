Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DB4C2119
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 02:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiBXBjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 20:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiBXBjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 20:39:12 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D6069287;
        Wed, 23 Feb 2022 17:38:43 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 8so1330958qvf.2;
        Wed, 23 Feb 2022 17:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQ9tgl+30McuPheRkP6XMt3TbjKT/oePeBXnUFyrMv8=;
        b=X1sWVunSGk/wOb21MF08UOQHsGL44JsXndBN1yNlDkxuKaYMnfPmwd37XxH81H8zMT
         V6ZfcwE7enjB66q6Axil2+yHYqNYbDaBI3mFd9i22vPMvICZv9d2al1c3Jmvv82UgC5b
         mDiKqjq6M8vUtvTSV9v4LRq3yIHjZGwas8lM3izN0LMb00kvJuYrWyPxO2mnzNcTwGNb
         2HEt348EEc5HYRQjU9hnqhjmjwreFdG9yCH/CWv+n3JfFRDHAiEhhPuvaTNQ9dUo+F0p
         +N7pO+oaStp8rx5b6FHUFdWPC4CRQfagSBV9jnwJDCBVCKgKqOtWiBxCKNp94bT870Gm
         ydOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQ9tgl+30McuPheRkP6XMt3TbjKT/oePeBXnUFyrMv8=;
        b=k9wXOEoFqcZL3/FQypx96M8GmiFk19mT7/RncLLfgQxXc6EvReGIIAcQBf4eoDhmBH
         8orjqvKzxxoXpYJ1EtA6pBqkBlkl61Zr7XDK9JUny7zl5SOUFsrE7oioywZt+qvbCRpg
         zYV1FQuvHu9Qr+gAl3wgyGKlYQYpMoPL3P0YCnhsUYEk+HQEcj2iUULCJky++q/DMBXj
         5jKFn4TqUAJlKG/bvGNr95TlCFhUVGN0q6bMUbCQIX1bKAcNg0xh9EVxMQXh2n8s0AYG
         USUGZ9LmQPqNHsj9FPAWqohEuLosr05OJKrhqBPw5WZWwsNIVwhwuZkk75Ze/p16SJRG
         3DGg==
X-Gm-Message-State: AOAM530RWepSdWfQeygRmEo766dULKN62+JQTJ2vdx1jNiZuLDhxwRCS
        cRbwynFIFNGvusZPxQ5gXCRdL01YhAmF5JbjEcQQ8Od3rvA=
X-Google-Smtp-Source: ABdhPJynqWhYAon/vU2BN5LkPiBakQ/4vVP5kufXxQmW8xVHytevGb8DOGMreWS+86DNG6nmqYMDYaUzrg7W5GlkrVs=
X-Received: by 2002:a05:6638:382:b0:30e:3e2e:3227 with SMTP id
 y2-20020a056638038200b0030e3e2e3227mr209459jap.234.1645665018788; Wed, 23 Feb
 2022 17:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com> <CAEf4Bzb44WR2LiYchxB5JZ=Jdie6FEEi90mh=SCv07v4h4W11w@mail.gmail.com>
 <CA+khW7h4bL3qUst4nDy6LDmx73xVA_ch=PLc=o=v2iJNbGn21A@mail.gmail.com>
In-Reply-To: <CA+khW7h4bL3qUst4nDy6LDmx73xVA_ch=PLc=o=v2iJNbGn21A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 17:10:07 -0800
Message-ID: <CAEf4BzaYxgnotk+J+czhAjXbfzEoOrnyiVMmmkjDDVHzYUs48A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
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

On Wed, Feb 23, 2022 at 4:33 PM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Feb 23, 2022 at 4:11 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 4:05 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > For binaries that are statically linked, consecutive stack frames are
> > > likely to be in the same VMA and therefore have the same build id.
> > > As an optimization for this case, we can cache the previous frame's
> > > VMA, if the new frame has the same VMA as the previous one, reuse the
> > > previous one's build id. We are holding the MM locks as reader across
> > > the entire loop, so we don't need to worry about VMA going away.
> > >
> > > Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> > > test_progs.
> > >
> > > Suggested-by: Greg Thelen <gthelen@google.com>
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> >
> > LGTM. Can you share performance numbers before and after?
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
>
> Thanks Andrii.
>
> On a real-world workload, we observed that 66% of cpu cycles in
> __bpf_get_stackid() were spent on build_id_parse() and find_vma().
> This was before.
>
> We haven't evaluated the performance with this patch yet. This
> optimization seems straightforward, so we plan to upstream it first
> and then retest.

Ok, once it lands upstream, I'd really appreciate if you can retest
and update us with numbers. Thanks!
