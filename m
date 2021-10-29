Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72A643F413
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 02:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhJ2Aqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 20:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2Aqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 20:46:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD66C061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 17:44:25 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v7so20028575ybq.0
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 17:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfTm9ei8n2iZYulQwoDQBOnBBX5y4H6Ma2DS5Nfe2FQ=;
        b=IPWxU2ekTOKuw3nMQTo2O4OlJui5XldBsL3tg19hyHjOEBzmsleIS75env9XsS8Szk
         w5qd6gTrQqJvVjKEfDRI+/rPXnJBHSckmApUWScoZC1OaiLXuy0cTEMmAoG4JVz37rvW
         FoQgyYl/MkEjrJl97oO67GYIEIE08rlTIM7ZRw0t8kUaVqdelhJLUORddEsN/fXfyICF
         +piM/8cjTvRiV9tMYASdePQdm98t2xrfR/g54UiSxERkJC7Dxbl2k+CYJjYd0J1KnfSz
         HrcCjHPzWQE8Y7zZXRw1V1ZiiTJeTA7fVABajtXUH/dPUC4ifjdLbm+a9UKHkVQaKXkR
         u75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfTm9ei8n2iZYulQwoDQBOnBBX5y4H6Ma2DS5Nfe2FQ=;
        b=54tnEN9OVdX3AmiJhQnf647EaqwEoi7YlsR6YgwEcNNbxAQ9jmxtnNUJiCFja0nJQF
         qseE4si27v+UbsKxO1mhR2Ss0XyH1kph97wnGWPQ+9I06GuLM/qsbj505F3Fo1qcsOpF
         vMX9FqGg62ObgyXShv2DKqlDGjtOpieCujVwnGF8ykLc+2w/hJXrG7FPhQdcN3N+xy4J
         c90poW99qGq1oMUv6YfDCCIc+CwKGYpNUeW8tw03VQ5RamRlhpM5XFAv6U9IHCRHG4E1
         KosMLrmiWWN/jwI2YEefo4e9DiQc96bvC/2uJqbAV6JtZ73klfcVfkD/3F9J4Ei6AkOi
         bhnw==
X-Gm-Message-State: AOAM532mB1/LExB3tAEA2cs80u9kDFjLX2qhPJBwQzS1W6p5QsrIELeJ
        K5uQ/fjEQVhmCl8oaahzwAgx2vM8ozZARKBzKCQ=
X-Google-Smtp-Source: ABdhPJxxGoHe8cA4odrHSzjImxbHmD1DT8HHmCqYaHO8rg4R1bYw0Hyr90XPs3CTDt5luuvMWSVxC+VkRBnR6u8pNfo=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr5856610ybf.114.1635468264274;
 Thu, 28 Oct 2021 17:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211027234504.30744-1-joannekoong@fb.com> <20211027234504.30744-2-joannekoong@fb.com>
 <CAEf4Bza5SJgYABaM2s-s3cdYEEvrbkgp2MOqQiDgX8dCsJ_Y+g@mail.gmail.com> <76458a10-f42b-89b3-b4e1-6c42870b6059@fb.com>
In-Reply-To: <76458a10-f42b-89b3-b4e1-6c42870b6059@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Oct 2021 17:44:12 -0700
Message-ID: <CAEf4BzZDqn54MScowT+mwn-eqG2Y6e9sFd0u8isOoe3gXJ4ZhA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 5:15 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 10/28/21 11:15 AM, Andrii Nakryiko wrote:
>
> > On Wed, Oct 27, 2021 at 4:45 PM Joanne Koong <joannekoong@fb.com> wrote:
> >> This patch adds the kernel-side changes for the implementation of
> >> a bpf bloom filter map.
> >>
> >> The bloom filter map supports peek (determining whether an element
> >> is present in the map) and push (adding an element to the map)
> >> operations.These operations are exposed to userspace applications
> >> through the already existing syscalls in the following way:
> >>
> >> BPF_MAP_LOOKUP_ELEM -> peek
> >> BPF_MAP_UPDATE_ELEM -> push
> >>
> >> The bloom filter map does not have keys, only values. In light of
> >> this, the bloom filter map's API matches that of queue stack maps:
> >> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> >> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> >> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> >> APIs to query or add an element to the bloom filter map. When the
> >> bloom filter map is created, it must be created with a key_size of 0.
> >>
> >> For updates, the user will pass in the element to add to the map
> >> as the value, with a NULL key. For lookups, the user will pass in the
> >> element to query in the map as the value, with a NULL key. In the
> >> verifier layer, this requires us to modify the argument type of
> >> a bloom filter's BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE;
> >> as well, in the syscall layer, we need to copy over the user value
> >> so that in bpf_map_peek_elem, we know which specific value to query.
> >>
> >> A few things to please take note of:
> >>   * If there are any concurrent lookups + updates, the user is
> >> responsible for synchronizing this to ensure no false negative lookups
> >> occur.
> >>   * The number of hashes to use for the bloom filter is configurable from
> >> userspace. If no number is specified, the default used will be 5 hash
> >> functions. The benchmarks later in this patchset can help compare the
> >> performance of using different number of hashes on different entry
> >> sizes. In general, using more hashes decreases both the false positive
> >> rate and the speed of a lookup.
> >>   * Deleting an element in the bloom filter map is not supported.
> >>   * The bloom filter map may be used as an inner map.
> >>   * The "max_entries" size that is specified at map creation time is used
> >> to approximate a reasonable bitmap size for the bloom filter, and is not
> >> otherwise strictly enforced. If the user wishes to insert more entries
> >> into the bloom filter than "max_entries", they may do so but they should
> >> be aware that this may lead to a higher false positive rate.
> >>
> >> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> >> ---
> > Don't forget to keep received Acks between revisions.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Can you elaborate a little on how to keep received Acks between revisions?
>
> Should I copy and paste the "Acked-by: Andrii Nakryiko <andrii@kernel.org>"

Yes, it's all manual. See [0] for an example.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20211028063501.2239335-9-memxor@gmail.com/

> line into the commit message for the patch? Or should this information be
> in the subject line of the email for the patch? Or in the patchset series'
> cover letter? Thanks!
>
> >
> >>   include/linux/bpf.h            |   1 +
> >>   include/linux/bpf_types.h      |   1 +
> >>   include/uapi/linux/bpf.h       |   9 ++
> >>   kernel/bpf/Makefile            |   2 +-
> >>   kernel/bpf/bloom_filter.c      | 195 +++++++++++++++++++++++++++++++++
> >>   kernel/bpf/syscall.c           |  24 +++-
> >>   kernel/bpf/verifier.c          |  19 +++-
> >>   tools/include/uapi/linux/bpf.h |   9 ++
> >>   8 files changed, 253 insertions(+), 7 deletions(-)
> >>   create mode 100644 kernel/bpf/bloom_filter.c
> > [...]
