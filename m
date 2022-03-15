Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8944DA2B0
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 19:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351155AbiCOSwE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 14:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiCOSwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 14:52:03 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5856C3B
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:50:51 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id x4so23329292iop.7
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Y8PYGkSxSg0BJuv3w91jEg+nCii3KHRQI+mvQdk1kM=;
        b=fZEewpnYOYkZCwT3jKD4weZKiQZdEIhUoIJe/G5XNejsBz1Fv6yArzV+uzu5zvf4Fb
         wNDKfTklkE6vDOM2Nev1lMdGpCd+FuDz02VnhHI01SsQdwU7pPXjpOXM/CoMcohx+/bW
         eyRgB5H7K3itTTW8CwGlepyTLqkskckzltMP2EJBs4Xev42f43PGbwynWYwZznubkSQi
         AKtY5T3Ar5r4TtFf8tOeMO66hxdcUntk7CLYq61MK828QIGKguH04AYoFOHuQsq7p3L+
         HINCvsX0xdC6AEgcBJKHK+JZSt1+4yGg9TjsSOkznq+taUCw9JhaLXEK8mw47TtIzYQ1
         RrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Y8PYGkSxSg0BJuv3w91jEg+nCii3KHRQI+mvQdk1kM=;
        b=PxOukSSBKfMS0rld/ivWLBfWO0jCB86UWjI9B32oIPmBh2v4xVb2r2Ru7JaRmLd4wP
         l6Hrs6vJbaKbqVv5kfniUj7NO7PH3d2ztcXwHoMDouL7dM9gB7JVK8Z7Vr5mZzyuo85q
         BvfdmtcjMmkXiFh9TKj1KRdG4i6UvJx5RVP7jXYqLEd2Cvkz5TT/MDk6Kfnh6g3jHAd6
         SO2xabhoKIFftEL8q37BDRSD7PjHre+K16aWasPDi8W0z6dpzsF56UQbKoVBXaVKS5zS
         qCzxWAA3y0hh9tt+m8hd0OraayAcDkdQjFq0V66134SHKRrjf70/wp2s1cRjfFXu/OI/
         SEXg==
X-Gm-Message-State: AOAM532QKAiQuiaFaSoPBOKWwpZXyzmTnZIk5UYx+VrcLM+pXHD5kokt
        OgUuA3A0ZfjrJhI7+O9xgGOhtok2E/V0WqFoFJJ/Tr79Roc=
X-Google-Smtp-Source: ABdhPJwjxFN5lmiWt8vn6dP1SHFMeXS3O7CWE0HHDpp2WBfXvwQ2p1YM5/mLqlyOqCs3e//u4dlAhsyBeLnV2RZsbI4=
X-Received: by 2002:a6b:6f0c:0:b0:648:ea2d:41fe with SMTP id
 k12-20020a6b6f0c000000b00648ea2d41femr10774544ioc.63.1647370250575; Tue, 15
 Mar 2022 11:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oXGvzTsPDTE9yLEfxJbjFvBt7-HzfO5Aa94PWXKWXPCzA@mail.gmail.com>
In-Reply-To: <CAO658oXGvzTsPDTE9yLEfxJbjFvBt7-HzfO5Aa94PWXKWXPCzA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 11:50:39 -0700
Message-ID: <CAEf4Bza2qS0AaTTUDAncz+gCzn5-w=+DVLh_Tt=1kjNqctWahg@mail.gmail.com>
Subject: Re: bpf_map_create usage question
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 1:22 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> Hi there,
>
> If I call `bpf_map_create()` successfully I'll have a file descriptor
> and not a `struct bpf_map`. This stifles me from using a lot of the
> `bpf_map__` API functions, for example `bpf_map__pin()`. What's the
> reason for this? Is there a way to get a  `struct bpf_map` that I'm
> missing?
>

bpf_map_create() is a low-level libbpf API. It does create a map and
returns FD. But it is not "integrated" with struct bpf_map APIs, which
are so-called high-level libbpf APIs. bpf_object/bpf_map/bpf_program
and related APIs are high-level APIs and they expect ELF BPF object
file to declaratively define everything. You can use low-level APIs by
getting FDs from high-level bpf_map/bpf_program using bpf_map__fd()
and bpf_program__fd(), but constructing bpf_map from FD isn't easy or
straightforward and should be avoided, if possible.

But one way to do this is to still declaratively define map in BPF
object file, but then do bpf_map__reuse_fd() to substitute already
created map by FD. This way libbpf won't create another map, it will
just use your FD. But definitions of maps have to be compatible in
terms of key/value sizes, max_entries, etc. In short: it's painful.


As a bit of aside, I do think we are missing high-level APIs to work
with bpf_map elements, something like bpf_map__lookup_elem() and
bpf_map__update_elem() has been on my mind for a while, but I haven't
gotten time to get to it. It would further minimize the need to drop
down to low-level APIs.


> Thanks so much,
> Grant Seltzer
>
> P.s. been a while since I've worked on adding docs, but I will finally
> be getting back to it!

Great, looking forward!
