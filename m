Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77663DABD
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiK3Qfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 11:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiK3Qfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 11:35:48 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6A884DCA
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 08:35:47 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h16so11512782qtu.2
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 08:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlGYTTmeO0EUox22y7jt3qfj33sZxc4kBIXv9Hio3X4=;
        b=Ta+9ZV6veBLcewaLVaKLLBPK1EYk5skvb7SppnWat36NhrXRkK8XZqdyS8ZmJMXDPW
         iGLpTyJcEbORvx+xbvgV0gI0bhrFAs9Z/t4z4QRxlau40yDqCSL5eQryVQ5lTTcXkMTP
         t18xpMEzzrwo8aT86whoaUEqlwM5zAkXOAYFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlGYTTmeO0EUox22y7jt3qfj33sZxc4kBIXv9Hio3X4=;
        b=8NJjyrqyKcso2sPRQpXa3mWj60Q0tlwxATgPNJnoeJIwAqY2As6X5/vS/BxXI04HW+
         YU15F1KlMv3vRUUmnE4TD4YB0NKJKA/k43z4kmv6MMDCM6J6V7bNJMQY/Ew544WYUdPp
         JvGadVSf5cQ4+y6DCwBYcDLmrH5O1mMRENZ1KD7OWH4QV6thJMUU9A6sESQkEqY7EFEB
         8OQB2+4/vS1QDibGazLuKSM/TpsYcUVXclHUKl3u0Sw1Xcw+GXDKFYMkAkGlG0BvzJah
         ax01cNcga1CMQrRAIsZLraS3DGmPP8Slsf+NjkxyT8iRBX8bbPgLa+1IvypVkII6sNXO
         pBaw==
X-Gm-Message-State: ANoB5pmrskusl6ZvOQ9YO4g7WamiIC/EzcYqENPnQnA3sbwXZyAoHMQl
        BiNU1swtGtKbLInRevs9GI8TV2WkGrEpsA==
X-Google-Smtp-Source: AA0mqf6cvtJtyr6wJGN9ZYKMymZQTcDi5I5jgI0fEhO9Nqn7irc3+merWal4wGRLr0PlZtV02t7K8g==
X-Received: by 2002:ac8:5299:0:b0:3a5:3623:17b2 with SMTP id s25-20020ac85299000000b003a5362317b2mr42858080qtn.543.1669826146377;
        Wed, 30 Nov 2022 08:35:46 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id b4-20020ac84f04000000b003a5612c3f28sm1078420qte.56.2022.11.30.08.35.45
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:35:45 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id fz10so11508816qtb.3
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 08:35:45 -0800 (PST)
X-Received: by 2002:a37:2c45:0:b0:6fc:a3eb:b504 with SMTP id
 s66-20020a372c45000000b006fca3ebb504mr115076qkh.216.1669826134401; Wed, 30
 Nov 2022 08:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20221130082313.3241517-1-tj@kernel.org> <20221130082313.3241517-2-tj@kernel.org>
In-Reply-To: <20221130082313.3241517-2-tj@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Nov 2022 08:35:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8wvB4vo-PaCSMSRaCd2c+rk8OnE72eF+skDVMdk9LsA@mail.gmail.com>
Message-ID: <CAHk-=wg8wvB4vo-PaCSMSRaCd2c+rk8OnE72eF+skDVMdk9LsA@mail.gmail.com>
Subject: Re: [PATCH 01/31] rhashtable: Allow rhashtable to be used from
 irq-safe contexts
To:     Tejun Heo <tj@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 12:23 AM Tejun Heo <tj@kernel.org> wrote:
>
>
>  static inline void rht_lock(struct bucket_table *tbl,
> -                           struct rhash_lock_head __rcu **bkt)
> +                           struct rhash_lock_head __rcu **bkt,
> +                           unsigned long *flags)

I guess it doesn't matter as long as this actually gets inlined, but
wouldn't it be better to have

   flags = rht_lock(..);
   ...
   rht_unlock(.., flags);

as the calling convention? Rather than passing a pointer to the stack around.

That's what the native _raw_spin_lock_irqsave() interface is (even if
"spin_lock_irqsave()" itself for historical reasons uses that inline
asm-like "pass argument by reference *without* using a pointer")

And gaah, we should have made 'flags' be a real type long ago, but I
guess 'unsigned long' is too ingrained and traditional to change that
now.

              Linus
