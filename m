Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8E28A42F
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 01:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbgJJWzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 18:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgJJTyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5552BC05BD0F;
        Sat, 10 Oct 2020 06:26:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so6730193pfa.9;
        Sat, 10 Oct 2020 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVFCs8xXG3UZzqj41Vd+QbKEjQvzFTw086//8JQkmAk=;
        b=nRqb4ZE058ecg0wB9M928Xcs3pdAmmYenHmHIKwtKIeDBkj22u265jtqAy+oGUqTuP
         3Kbtl4e9BhdhDhLaIKfzGQmiDJ8fyWCLLoVOHFAs7/Pq7T+C36pd8cHKZlwBFA3qG4sj
         i6qhyFyFCo6wA+30BWi4e3TqjdPphXZ5bEb+GGtWhrP+9adNgfvwcF8q5v0Bs/5qU2Fj
         F6lZwCXDnXRBt18iSeRVgmmLm8WKb4d3WaJq60FL2G6W9xhs49E0qR8Pv3V9NGNnFjnK
         CRfPAGtZ0lJ/fQ9SXWWGbPSaoIDJRq9tVGbgJ8OFLdz4GCUrvQQELdFrYIWPdhJg3T6r
         isyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVFCs8xXG3UZzqj41Vd+QbKEjQvzFTw086//8JQkmAk=;
        b=dmVYu1eGmaSNM4SxB9avI/op8LObx9M70kByOZRwn1eyHDzydF8POfbO8aeJuteUW2
         KeuE7ptTuj2pAXddZaN9+BlfZ7ejfdyQvMKfxmBWkGvPjm404RQ75QolYIYk/UcNUT26
         hMARH+UDP2xlF8VpliewIduy4GngqAXJoJnTlTyfQRGbG4LHDzD7WD7aHvLyMpNQZ5l4
         vX8xKXk+coldejvgaTOBNtMoibP6kcKgwPKZaBdlfCsY8H8IcX2+TPlNRTiNMeNA8oPJ
         k4TtNfLtks5W1udSJGDPj7K3ZtacJPxlmAVu6ci6f1Ij7v3aQdYD099Jpenm1ACZT08K
         xY4w==
X-Gm-Message-State: AOAM5305xjxWyMfVPs6G/GGG3zzrkH4U6eOR4im8fIzB09vnyu+jR/py
        djbZ/kuhYNSYqHoaJJG/Lkc89HFH/W5YkDWlUkQ=
X-Google-Smtp-Source: ABdhPJxJZH4rfHRGX8OWQzzQRKi6l0cfQ8gJdZhGHNFZtth6oqmXK/1KFPFUYgnj0yT0dLv9Ky3MZHKlrHUdMvDhlFM=
X-Received: by 2002:a62:750a:0:b029:152:4d07:aec6 with SMTP id
 q10-20020a62750a0000b02901524d07aec6mr16211235pfc.48.1602336387840; Sat, 10
 Oct 2020 06:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook>
In-Reply-To: <202010091613.B671C86@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Sat, 10 Oct 2020 08:26:16 -0500
Message-ID: <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 6:14 PM Kees Cook <keescook@chromium.org> wrote:
> HAVE_ARCH_SECCOMP_CACHE isn't used any more. I think this was left over
> from before.

Oh, I was meant to add this to the dependencies of
SECCOMP_CACHE_DEBUG. Is this something that would make sense?

YiFei Zhu
