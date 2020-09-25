Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACFA278EF5
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYQpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIYQpR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 12:45:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B9FC0613CE;
        Fri, 25 Sep 2020 09:45:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y14so3052259pgf.12;
        Fri, 25 Sep 2020 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruCEryVFyAOn3Txfm384BRQUI0WS36tIHI9atsfBz/4=;
        b=NOC83klTMa/B6Y6Kt6iQ/A5oCUqhE3U6VAb96tggPynZTwJM2eMUu5p4Z7lpPKAoEa
         HzX4Z0ruwL7YNnauYGynp7rwc1cCrHiDOqjn42iminWT0UhtajgdEfmkP8J+SI0AeSph
         qaT0GLEuXQCEbNgXXjDTFP9od6z43+v9ZGE4sAnqYH3s4f6oCM2r3MN9Fa7EtKQlt8B1
         M998jx/BOxkqJWyOC3L/YpvcDbjvefT8RBs9BOX3k4Q05JGq8q5UuVuJYHOSLrU8KPzk
         sM24X41y9k7PyGoK7GYsmRN6VW/nq2wmRIK0jH6rAukl+nU1Sb17uLYTWq41pwywp4DE
         wncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruCEryVFyAOn3Txfm384BRQUI0WS36tIHI9atsfBz/4=;
        b=PYdis7zCOfQ6FmHAkX5od4wz7+FSoMEyIPmr2oxjGu7QB13qJbP+oMYVT7VmCpGx2c
         vAmc5Bj9m1T+8R/OwX1OaYeoM6DP5RBUZEcztBFQkwROpVi6YahQ62mBIYWbOG+rRhoM
         99uvmZNDVOY1dQs/mx0XDAJNq7seF0yhqO0rcSapzdl5Sxii1caduYvGv3agNRcP2ht1
         kUmqPtS27T4F6H1aLcoprrh1e1q397+2VJ0V/x9H2PXDiWLrgwpHanutXN+3Uu07L6+C
         xVEkuz6J/npWq1rEKT+kmgKTSzqkXjaizMFfGkfNtTYMnMqYlz3ZdYVacVeHexkXFW7K
         Nshg==
X-Gm-Message-State: AOAM532aGAXN/VZIs+PM9UjDOsQumYCCGUyjwie5LUdHvqIa8rCrtfN+
        iF94jeosqea3SdelSVHtSGTLBhhuS2EHIV3AT/M=
X-Google-Smtp-Source: ABdhPJyLs9CmSuxL1C3wljdQpenEpIvO5wqWImFZHDW9uWc8lmXcNuFA4qC9zIGeu17/Yl8ddcf0atBt5fqjZbZZZpM=
X-Received: by 2002:aa7:9491:0:b029:142:2501:396b with SMTP id
 z17-20020aa794910000b02901422501396bmr151396pfk.48.1601052316926; Fri, 25 Sep
 2020 09:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <c14518ba563d4c6bb75b9fac63b69cd4c82f9dcc.1600951211.git.yifeifz2@illinois.edu>
 <202009241601.FFC0CF68@keescook> <CABqSeARb7GNU9+sVgGzgqqOmpQNpxq1JsMrZJvS2EC05AyfAVw@mail.gmail.com>
In-Reply-To: <CABqSeARb7GNU9+sVgGzgqqOmpQNpxq1JsMrZJvS2EC05AyfAVw@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Fri, 25 Sep 2020 11:45:05 -0500
Message-ID: <CABqSeASM9B77QrWRbqRF19N9-m-bm779-7a3qEDa8NumjBsorw@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Thu, Sep 24, 2020 at 10:04 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > Why do the prepare here instead of during attach? (And note that it
> > should not be written to fail.)
>
> Right.

During attach a spinlock (current->sighand->siglock) is held. Do we
really want to put the emulator in the "atomic section"?

YiFei Zhu
