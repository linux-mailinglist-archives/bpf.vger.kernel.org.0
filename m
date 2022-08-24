Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09C45A0307
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 22:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiHXUwZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiHXUwY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 16:52:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E5E72EEB;
        Wed, 24 Aug 2022 13:52:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sd33so14457240ejc.8;
        Wed, 24 Aug 2022 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2XP4mZfXexRtRi5IJFuPKtcayDeVUjgs1C9agqXamXw=;
        b=VHaxq1ZDVZzU+ChxTLuUXHDCxfK6CJBhs6Hr3NqxvPLkP3b5EokdUXp5iu3jwAC6fz
         v+jzg9rAp26m9G8xw70n2xE/Fws2Dnu7GTXN6ufoMzbXKbkAN/WjvgTzQ96EUqEluykd
         M45Pjmf4DNIPoRuzbhNc3qT7TlnOrdcCCNpCwGEJMbZGh5jrmwlJ4UYXnA7wtzTUBm0o
         kXJRsSJ6N02Iw1/oyUvgaoR4v36lpkxPnaeQmTBo7KFhQBfdQHLyFgi/aqJMeI2kpTJ7
         lphQasqKPmtvcB3ees9wUY8UwvdbyhfvFahiQqAtXpH0QILpisFiWwraPEwM6rj+pl2d
         uMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2XP4mZfXexRtRi5IJFuPKtcayDeVUjgs1C9agqXamXw=;
        b=Uy4rEcfNCeskg/rvFbmpp837Sm8kfoyRyMUGkKfJyNsZ3pZ28e81Nz/pKst6Nmu+nj
         TXRkrwQb0Bk/rFeQadxJWIn4iCc7IIrIi3CVPDygIE3hRTY6sim2NIec2FibTPZVHw+k
         DjJyXfoZG1hn1rzl0YsuMW6MO+yu2XboOy0vAh8GP8q878UKDj4pFqNrAxKXdtPQq6O9
         LXlSBSYHMnip5YsaWjYOdnSJfsEhcWFKJPE4sAXpV4mvMvMBubooaWZI+T+/T/q6RFa/
         kjiSu/m66gShUrlghbSnYHY3gcKQpjEJnwvzQaV+4V1aZvdO0Ys6N7l5ElYgsLnGiEhF
         7jfA==
X-Gm-Message-State: ACgBeo30CoxZ2sZ0cVNLZPgmm1fHH8LXXVc7R3CbLe66Q47GK5m0RgQb
        Bn1kWfV2CqggloSoW2fBlrNEZO2pxiVqcacYy7c=
X-Google-Smtp-Source: AA6agR4bWqaXzrMfAuWVUlGSauhzfUBElkoPylyAvoNSnorSGhAqryJpPx4nBeFm9b6j/Mqmg/8T0l5I1I0peyn4Kg0=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr438420ejn.302.1661374341791; Wed, 24 Aug
 2022 13:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220818221212.464487-1-void@manifault.com> <20220818221212.464487-2-void@manifault.com>
In-Reply-To: <20220818221212.464487-2-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Aug 2022 13:52:10 -0700
Message-ID: <CAEf4Bza=Ra8uC3HuQgcaDx4s78mdRtrD+z7=qStCX5MTnJ7fOg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, joannelkoong@gmail.com, tj@kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 18, 2022 at 3:12 PM David Vernet <void@manifault.com> wrote:
>
> We want to support a ringbuf map type where samples are published from
> user-space, to be consumed by BPF programs. BPF currently supports a kernel
> -> user-space circular ringbuffer via the BPF_MAP_TYPE_RINGBUF map type.
> We'll need to define a new map type for user-space -> kernel, as none of
> the helpers exported for BPF_MAP_TYPE_RINGBUF will apply to a user-space
> producer ringbuffer, and we'll want to add one or more helper functions
> that would not apply for a kernel-producer ringbuffer.
>
> This patch therefore adds a new BPF_MAP_TYPE_USER_RINGBUF map type
> definition. The map type is useless in its current form, as there is no way
> to access or use it for anything until we one or more BPF helpers. A
> follow-on patch will therefore add a new helper function that allows BPF
> programs to run callbacks on samples that are published to the ringbuffer.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf_types.h      |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/ringbuf.c           | 62 ++++++++++++++++++++++++++++++----
>  kernel/bpf/verifier.c          |  3 ++
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/libbpf.c         |  1 +
>  6 files changed, 63 insertions(+), 6 deletions(-)

[...]
