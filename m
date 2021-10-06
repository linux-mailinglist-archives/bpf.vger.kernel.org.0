Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921B04245AD
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhJFSJJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbhJFSJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 14:09:08 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F69C061753
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 11:07:16 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s4so7381817ybs.8
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlavOudP68I+hfv+zzyHG7RWNtcD3xjva6LVL64J4KA=;
        b=OwFz4StX+x/KV8upOwloGtFKt1yw5nPOMqxi97GzKfeykr4NHwnnLG4tyLlY07x3Gu
         +mn6K/Wi7UGoTq/SMpgUswVS/brTjDMbrY+cGPB7E14vUDIn6nkruTpUDaXDwLBaSzx1
         JfZq6rq5JG9yahJJ1GC3cFJYbo7pA6plYDnguqIDvSaYDOb3Pk0K6jsrH0J/Ct8hAjI5
         XpjzDS2eDf6BPmn5sPMaQqhdU1CabQnVw/aTSwUaVCFIIdcRAhe1ttKDVtP1IRl5XNTU
         11eK8V1cg1I/4311uRrwT9XThUKoZBpLoN9wY/y8AihBjAvmP3g+dm6bgNRTx6Qnnk7k
         1P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlavOudP68I+hfv+zzyHG7RWNtcD3xjva6LVL64J4KA=;
        b=1vyDaohlK6XHdb9WZjs4wVdLgRREGT5elD6zL0WnwFFn8uVgkiNlLc+0gRlKzlRb2L
         +4ffR45aKCMDvkpXStPKZgPEhK+Ke8fvYdfK4VzmNtQIDBE3xU+KRl0qw2iLaPuPgZ/q
         j9tiMF4PcK5HfI6xwaOsyDLl6DnIeIRTEKqFeav6ZWLxo0InTRBj2NHEJDBTu25tAbA+
         tydS1TSKYUpymccDA55hQ1CJI4FWnBpzg+HnrtbZEMAKN0OOWCmzfSRYUi1tHhqADN/y
         qCvStsp0LaCgwai7HThALxTQ3Dpi94ARzREAHcQgi4V7f3Dnj+ysPvXAAgcXdOf/csNF
         voow==
X-Gm-Message-State: AOAM530snVhmfgQrereERqSj3NBZYruOzfJYXGRZbJIlOGfxO8aC31/8
        moyxcTdRn92MzaY1eQBzy3hGUi4mCHYhYtM4lh8=
X-Google-Smtp-Source: ABdhPJwprSBJbVtNHj0w3h1hhnUHCUYxo9JgPDEzyo3Gg2h24KC6C+bTdfUmSHO1ybG3q/xT4mggkPhA072o7YWQ6rs=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr32253831ybj.504.1633543635879;
 Wed, 06 Oct 2021 11:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211003165844.4054931-1-hengqi.chen@gmail.com>
 <20211003165844.4054931-2-hengqi.chen@gmail.com> <CAPhsuW6NVoUebaxWm4YGNkStjxGwcdf5-hRKtcjtpVRpkEfBow@mail.gmail.com>
In-Reply-To: <CAPhsuW6NVoUebaxWm4YGNkStjxGwcdf5-hRKtcjtpVRpkEfBow@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Oct 2021 11:07:04 -0700
Message-ID: <CAEf4BzbzJC30O288-iHpdOqJRxsoNFdb=cZuHV3C_1ABbdXzWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2 v2] libbpf: Deprecate bpf_{map,program}__{prev,next}
 APIs since v0.7
To:     Song Liu <song@kernel.org>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 5, 2021 at 3:22 PM Song Liu <song@kernel.org> wrote:
>
> On Sun, Oct 3, 2021 at 10:00 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >
> > Deprecate bpf_{map,program}__{prev,next} APIs. Replace them with
> > a new set of APIs named bpf_object__{prev,next}_{program,map} which
> > follow the libbpf API naming convention.[0] No functionality changes.
> >
> >   Closes: https://github.com/libbpf/libbpf/issues/296
> ^^^ I guess we need "[0]" here?
>
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
>
> Other than the nitpick above

Fixed that up while applying. There were also 4 more uses of
bpf_program__next and bpf_map__next in bpftool and samples/bpf, I've
fixed them up as well to not come back to this again. Hengqi, for
future deprecations, please do grep for the entire Linux source code,
not just selftests, there are a bunch of other tools and parts of the
kernel that use libbpf APIs.

Applied to bpf-next, thanks.

>
> Acked-by: Song Liu <songliubraving@fb.com>
