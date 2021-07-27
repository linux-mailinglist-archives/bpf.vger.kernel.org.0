Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9223D7D06
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 20:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhG0SCY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhG0SCX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 14:02:23 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7254C061760
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 11:02:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f26so18444827ybj.5
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThXtBGdLwxouqjUodnzfmW13LqQYqEOYVHm7x2AmAeM=;
        b=Juurl1jL2CYcMGYyHaJJuT9gNww/TF5phCC0GqA+eNwRL/tVRZ0Z9VJkY4jzpczNNK
         JCnHq6mTly0sGz/EPLz9U7kmOGsRAeVu7vvynaKzpyuCsHrs0gnKWf2raZNnQ7zVQD56
         4idS+iIC3oSXirkH0JRtE8D8E2A9U7VgFxinJVZchfwGVjxPm+zuv0svtRIvMXbJTEnn
         GC/Th4ks4v3kqxWli6pnUTlEXLBpWnSHJQ+LJUgLHtipUkYGPhrdGgumi3ujMS28uhPF
         bn+kPtm8d4GBbuBTD8BpXGRUoGdPuGgDH+er2o72x5U34JveULKGRHRi0QrH3xYH6kVw
         oNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThXtBGdLwxouqjUodnzfmW13LqQYqEOYVHm7x2AmAeM=;
        b=MSaz/cfOLlzV98eYykrygrQWIdnZK0orX0G9NYW4MDW0uXIcFWFMDcR/QNNUCWfoWF
         EiYC8SRtOEG/sa7ZYcPzYhjZeU6LflSqZYoqbgHT/9PhezsN9na9KWGOUGSlUFFQ6iTe
         mFZXxjDAxjLXKC2hWhcSFj1xcEv8vyBGuP81yc61CAE1/8ZPes77IOzTDAMt6aj8lUpi
         IqV7OkzarMnWTX9OnCyWJUuWcI7kaAAUttI9CXEUWDZJH8UT9nOoC8OU7piDTJWDgNoO
         XoeXKt8QwkoJKk08DLhOe2sqxklWYMC7ziS/SihyOWhSOP1yzeMwUOQDeyo4riGHWhl7
         ENSw==
X-Gm-Message-State: AOAM5328MPDOXt4Bjlb127KPJyHi2RArDFnwTGY/QvYclgEb60N9rZK4
        mRaRutObjU57zjbXZLGZ72pcvoC7uF7lFf5a/nk=
X-Google-Smtp-Source: ABdhPJyGGztbKk5r6i2ClJ8IxeEuKHP+qpiiNlTbQoZCzjyFnSXcYLLFS+aZPrgVFjTfBdNvZLMR4+2JYps/sQLmMCk=
X-Received: by 2002:a25:b741:: with SMTP id e1mr33324293ybm.347.1627408941905;
 Tue, 27 Jul 2021 11:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzaSN+aN5RV=anaGewGAmqOWJRZpHtSeMfYcJ2HZ98LqLQ@mail.gmail.com>
 <20210708021727.5538-1-joamaki@gmail.com>
In-Reply-To: <20210708021727.5538-1-joamaki@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Jul 2021 11:02:10 -0700
Message-ID: <CAEf4BzYqTgi1wmKnZsfpQbCL4vq35MtCNodx1FTOH=qx1oaP1A@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Use ping6 only if available in tc_redirect
To:     Jussi Maki <joamaki@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 7:20 AM Jussi Maki <joamaki@gmail.com> wrote:
>
> In the tc_redirect test only use ping6 if it's available and
> otherwise fall back to using "ping -6".
>
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
> ---

The tests weren't broken per se, they just required a more particular
environment set up. So I consider this an improvement rather than bug
fix and applied this to bpf-next, where it's much more important to
have all the tests passing in an ongoing fashion. Thanks!

>  .../selftests/bpf/prog_tests/tc_redirect.c    | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
>

[...]
