Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFD122BE1A
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 08:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGXGeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 02:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGXGeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 02:34:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFD8C0619D3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 23:34:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so8826720ljj.10
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AiUT3Twb9nVxaIhZGhWwF40pguCQX2A54LyJWVPoBs=;
        b=CFhjYHPR1MenU1xlEpcpIwnzUyilA9sf4ytfnYb6SMxYe7mePRmg3RLKugpQP2fOOz
         UjdmzuowfjapOT1U5cMZLm5SXtDT9Nq8iCQ+eAoLfd3TugOoDdHFLRpKbFjT0aDdmoFX
         OcNt/Wjo1AM9aUGZGWIJCx8ndQ4K7TFqLrfCH/ycGnC2yCKtUmpcKOjzzAQeoqhVdAku
         xHWqVsf5Qi7O9ArdQkqnPAjF0n1p9ILugO+xiyhKulYTMQ+vL9t0K/FbhI8R50aWQDAk
         Uc1AUbnHLNKoAK0v/+6DMNQe2WUnvUSWmqpW2A6q63Po7ewmviccljiiD8l5T+oTBc23
         /XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AiUT3Twb9nVxaIhZGhWwF40pguCQX2A54LyJWVPoBs=;
        b=HD9TIZZLcHUsi0Nf5xeAzSFKaXRiALZVVbXGAtnRXbAuA0DzAoyNhsQ5AUgNUzr9YY
         YpBJKlZdj1nwJb1rf+MNxK+CiOSbe9LE8ROsyOLI/Kxs2H8LD1iXqG9qs/qyIuIbXMdD
         4+kq5MCdmcaT8WXHmliSCTlC8SfL6VIU0XXLkAv6voEfGDMl9PMyPfeNukWM/oJEq7Ei
         kXdpUYPgT3ROpA0bUMVbq6SP/MohlwVPlGxs+fY+L9LynHTgP5nVs7dqNjGwZYQhh3BA
         oYDsiC5G8VJvwkv/EGnt29yBu99lgJLz51ug3+hYy7a0U1zkwiuCzAt0zV/ECaMCR8jE
         FjpQ==
X-Gm-Message-State: AOAM532eh+j1Pi1IKTbrJAUoNSEj4j9zx1dLGOKRmMhG8x5UBbX44+Bd
        Act7FB633mf2+1riw0C6vv++1hbPoMvo+MaXtiI=
X-Google-Smtp-Source: ABdhPJycvZboyaMYHPskvgYI9qyFAfszdvGZqxwJOjs+rIwpThoGKBTqehvk6rfbdwk/x2dlRVY8ITAgZVSvFeMvT8M=
X-Received: by 2002:a2e:90da:: with SMTP id o26mr3704178ljg.91.1595572440053;
 Thu, 23 Jul 2020 23:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595565795.git.zhuyifei@google.com> <20200724053954.kck6gkrwrmeiactu@kafai-mbp>
In-Reply-To: <20200724053954.kck6gkrwrmeiactu@kafai-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 23 Jul 2020 23:33:48 -0700
Message-ID: <CAADnVQJiCGCUzie+1eWLYW=+6TCtf8O1ye4z+1j5WvRieAVLKA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by
 different programs at once
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 10:40 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Jul 23, 2020 at 11:47:40PM -0500, YiFei Zhu wrote:
> >
> > This patch set introduces a significant change to the semantics of
> > CGROUP_STORAGE map type. Instead of each storage being tied to one
> > single attachment, it is shared across different attachments to
> > the same cgroup, and persists until either the map or the cgroup
> > attached to is being freed.
> >
> > YiFei Zhu (5):
> >   selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
> >   selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
> >   bpf: Make cgroup storages shared between programs on the same cgroup
> >   selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
> >   Documentation/bpf: Document CGROUP_STORAGE map type
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied. Thanks
