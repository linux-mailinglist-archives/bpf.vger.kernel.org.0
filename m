Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209366B819B
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 20:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCMTTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCMTTK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 15:19:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878224C91
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 12:18:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id da10so53092170edb.3
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678735103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jzQHLH+czFdrkdirmcmRjGKRMXSK18PVFqhOp6lwdI=;
        b=QsWgw9kBrVnin7kxkUV6/DSRmwHT6AIQV3oz377JmlslGnbmhWZfWjagVAK9+2YH4+
         m7ovB5rqA3be1T6dKrbvP8Mtu5luoRvUq/s0qvYiuAWjrR+hVosvWeUfl+cGYlswn77O
         V8KDNFr+PJW9L7MlEA5OZ+boh/p+gLR1pnQfgX7rQ6ZpGxlznAfYYeEMNnW7WBJyZv7P
         QFdMeUY5nHjU/CKnIJd3B6YPCMolP4ooAy6tE7ttlS1avDVlPtEkb5OZngfP31JFhuBS
         d+JooudLa97bWheIQYYV7BhxGmqO3BbRXEkEICJZACdsKuBqvUqPdQTKPKP2yA/AfdjY
         sFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678735103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jzQHLH+czFdrkdirmcmRjGKRMXSK18PVFqhOp6lwdI=;
        b=y4uaN/JRlYo3+xVnJDnSDWgvNboZcUNVsJ1+cQEmuepu+irM/KP6zXcMkKpN/dmtBa
         XgCjseKa/vqDG5WXmyI7OambvmbBq5q/gUnD1NNkKxOsm3bpOY/wUOud+kfyqTpN9JTP
         cMuHpt3u8kquec/1xO+CuugWTGtlmka+P54aj55elTjkx86HBK1HzogvE/8Sut3NPIo9
         iMGTlRn/HvZ6Qv/KSoWYlAZSYkTAc9o0lXFXl/c9113FHIRvsLjWkjKWu7tXmJS8MFAL
         ZYImubFDsSpcrzDFcAxQ+6QdNptEvZMT+dMyP4rMDkeHaUcwZn0pQgsLEmPUcSqAumro
         qyyg==
X-Gm-Message-State: AO0yUKWtkr3l0i/hm1u8VfuZDV2iOj7XpYCA3XKJZPr3Dr41Du3GIXn4
        F9RuPg7x4N759/JtLgV+TtSm0F2a4XqRBV47q3WptA==
X-Google-Smtp-Source: AK7set9iHKb6Bre4RqW3221gyWUC4UjEXzVE8fpYLJqP1GDRCMYCrtwk4fHPFHQkY4jgZozb2tRZ1crzU/LyT0PA6zI=
X-Received: by 2002:a17:906:7803:b0:8db:b5c1:7203 with SMTP id
 u3-20020a170906780300b008dbb5c17203mr18275513ejm.11.1678735103127; Mon, 13
 Mar 2023 12:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230312190600.324573-1-joe@isovalent.com> <ZA6ecdQl3STWVAH6@debian.me>
In-Reply-To: <ZA6ecdQl3STWVAH6@debian.me>
From:   Joe Stringer <joe@isovalent.com>
Date:   Mon, 13 Mar 2023 12:18:12 -0700
Message-ID: <CADa=Ryyp10=ki5ctVTVbeUFy23uyRbi+ZgJE5JpxX3UFWvQcyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and graph
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, maxtram95@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 12, 2023 at 8:54=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Sun, Mar 12, 2023 at 12:05:59PM -0700, Joe Stringer wrote:
> > +Even if an LRU node may be acquired, maps of type ``BPF_MAP_TYPE_LRU_H=
ASH``
> > +may fail to insert the entry into the map if other CPUs are heavily co=
ntending
> > +on the global hashmap lock.
>
> "Even if an LRU node can be acquired, ..."

Ack.

> > +
> > +This algorithm is described visually in the following diagram. See the
> > +description in commit 3a08c2fd7634 ("bpf: LRU List") for a full explan=
ation of
> > +the corresponding operations:
> > +
> > +.. kernel-figure::  map_lru_hash_update.dot
> > +   :alt:    Diagram outlining the LRU eviction steps taken during map =
update
> > +
> > +   LRU hash eviction during map update for ``BPF_MAP_TYPE_LRU_HASH`` a=
nd
> > +   variants
> > +
> > <snipped> ...
> > +The dot file source for the above figure uses internal kernel function=
 names
> > +for the node names in order to make the corresponding logic easier to =
find.
>
> Shouldn't the figure note above be in :alt:?

Do you mean alt or caption? Alt will hide the information from most develop=
ers.

> Otherwise LGTM.

Thanks for the review!
