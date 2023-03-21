Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742EF6C3CE7
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 22:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCUVmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 17:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUVmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 17:42:12 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9911724124
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:42:10 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id c1so11897523vsk.2
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679434929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDfUW3+1v7UB1svzFHjxoW+eFCQZwpGjpojk/1REWww=;
        b=NL+Mlc/9bVGBw3VFWGJzqzkxHvlPnlrKBB+SJRM1gnAIXxbrUG0LpjtZYG8ovrTv36
         UimygkcG2+MK6k81It2QzLeJ+oX9qBdzlLTZmf6HmSfpYfnDpb95RWenFF+JOF3m9JX6
         nmIXoTqq9x76BFuyTTjKHdlh5GPmP3uSWNdS7TnTsCA9MMEyqIN5tT09tCrA+28wlZTT
         E0xAHfiD9BtKfwk+jzKm6BzmZMtsBLJmjXR2zrA9w7FVO+MpYcwyfzsEQLFGXqWKCOKa
         vYfeRzV5mzeYBn4K8+bxCXB4x8FIKpah76xsodJI6TMVvMh7JD9JwprlnyvH4s7FbSEw
         c5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDfUW3+1v7UB1svzFHjxoW+eFCQZwpGjpojk/1REWww=;
        b=aSBA6iTOmzrldvKw+p0a679cuGOO5IiLEeMZwBrrL2HgUVAMY19a85fBqrvE48WCer
         il+9huHiVE8EaoE5vHeNikd8eyYzmp0noflVdQa3ktS1g/YMnVRt2+rbUw8yMdezhcxD
         O9f4q9eEvZvU3nx302BIYg9f8lRXfEBkL1vURtxkIlG4UrGq1r+7UrlUQFhI3p4O6jdq
         b3FreYDrpo0u2Ph/REUpsc4XyqcWxRIFd2pZ39jV+AUOrEdzWgqNs3/wPbuWh4Wtlc6a
         LuAxtxo+hUrAHLOXkakJDwYVsS5Rt3euIJunZfB5C57LPmBxtveEF3+KLmISqIQqE9zv
         f1Xw==
X-Gm-Message-State: AO0yUKU8MVQyFz+5b1Q8mssoFA1zdA/pGljeYwIkHeGVkNV57BelERG2
        V2MSXS/z4in4LzoTri/94wkKDlMgoLBpGIOHW8qBLvZaMeiS0WLR2+W5LA==
X-Google-Smtp-Source: AK7set+X9mr3oF6LQ1rEm7DytM6tKQYZMUwTMIE1RViPlHd+YMQ5t9c+54Gs2DZwL6youIq/dughKdkkU0Trd5DhI18=
X-Received: by 2002:a67:e04a:0:b0:425:f836:59ba with SMTP id
 n10-20020a67e04a000000b00425f83659bamr2623301vsl.7.1679434929576; Tue, 21 Mar
 2023 14:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-4-aditi.ghag@isovalent.com> <ZBoiShkzD5KY2uIt@google.com>
 <FB5E0B90-2A54-4B35-9393-1E4F018FFBFC@isovalent.com>
In-Reply-To: <FB5E0B90-2A54-4B35-9393-1E4F018FFBFC@isovalent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Mar 2023 14:41:58 -0700
Message-ID: <CANn89iLcBqGDtOpfny0i4=UV8OUEjWb7RDLizpDP_+wUQeODcw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/5] [RFC] net: Skip taking lock in BPF context
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        kafai@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 2:37=E2=80=AFPM Aditi Ghag <aditi.ghag@isovalent.co=
m> wrote:
>
>
>
> > On Mar 21, 2023, at 2:31 PM, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 03/21, Aditi Ghag wrote:
> >> When sockets are destroyed in the BPF iterator context, sock
> >> lock is already acquired, so skip taking the lock. This allows
> >> TCP listening sockets to be destroyed from BPF programs.
> >
> >> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> >> ---
> >>  net/ipv4/inet_hashtables.c | 9 ++++++---
> >>  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> >> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> >> index e41fdc38ce19..5543a3e0d1b4 100644
> >> --- a/net/ipv4/inet_hashtables.c
> >> +++ b/net/ipv4/inet_hashtables.c
> >> @@ -777,9 +777,11 @@ void inet_unhash(struct sock *sk)
> >>              /* Don't disable bottom halves while acquiring the lock t=
o
> >>               * avoid circular locking dependency on PREEMPT_RT.
> >>               */
> >> -            spin_lock(&ilb2->lock);
> >> +            if (!has_current_bpf_ctx())
> >> +                    spin_lock(&ilb2->lock);
> >>              if (sk_unhashed(sk)) {
> >> -                    spin_unlock(&ilb2->lock);
> >> +                    if (!has_current_bpf_ctx())
> >> +                            spin_unlock(&ilb2->lock);
> >
> > That's bucket lock, why do we have to skip it?
>
> Because we take the bucket lock while iterating UDP sockets. See the firs=
t commit in this series around batching. But not all BPF contexts that coul=
d invoke this function may not acquire the lock, so we can't always skip it=
.

This means the kernel will deadlock right before this patch is applied ?

Please squash this patch into the patch adding this bug.

Also, ensuring locks are owned would be nice (full LOCKDEP support,
instead of assumptions)
