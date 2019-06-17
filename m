Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C148BE4
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2019 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfFQS0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jun 2019 14:26:42 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:43034 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfFQS0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jun 2019 14:26:42 -0400
Received: by mail-lj1-f171.google.com with SMTP id 16so10269653ljv.10
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2019 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJyEsDIUJUqFLJmWnYkwE7WwhHZjx3kbt640toUNGe8=;
        b=WP3ib2q2pSi4hB9/71X9pnLn0fZOtPY4zJhm+GSxzE6F9U1JfJ7PgpE3iLV6l8ZWfb
         JrM4PlvFSC/wZgUX8i2b/WvrRAr1mUL+0sBHirPK56iljImDuHW0e6zayO+T/ow2ZYiZ
         qqF3qyi64GTgDHC0YuZfqjdTULZphkHm1ErWy9Cka9D0GwWzEr2HEm0kM16WKga2f6Wz
         fY/5vfPimTu4dYDtxuZxy9JCVC089LBq59jIWG5mr7awcZY3O5JM9Cl3gtPvDrE/T/27
         D5jzxeinaosAT3VxeRcuFqbd3Bwx41Lcaxw282l+7nCj4EcoU1c8v6s/txpPSVyOoGH9
         IEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJyEsDIUJUqFLJmWnYkwE7WwhHZjx3kbt640toUNGe8=;
        b=NhbtvHmvM0FBHfits9SwCSFRMVzo67IQM4p+slK3F8PSc0Y9PWXpbjCyY/7YNC9mPf
         nGryciNpq9qjHcu0s60YRH676SdIYrqU05awzfD6cELsfyczX2gGl8dQyDdtYGRCb9jl
         khEKCavZ1JrKpUuqqRrV55w7Or7LNXjrOGBCWWCm6d/q2EhVs6tnp0Rb0BHGVeLYdo0e
         /4lYLUB0Lmqq9kVvW7gx+w103GmjoMvRlqdIMTTyvuBO/TdDqWmlBQiqm3ntQLPWY0C8
         MVqiAsJe736FlN9qXjbSsEwAsiWNK2hBJtA23OP/5LPkBP82wOl9fP06ollef4Ip257w
         OvPA==
X-Gm-Message-State: APjAAAXjrrI9YnsYWXyGVC0vo1fgzFAOyVZTT476xOChWsyvcQv9Gh6r
        dForCh1dXJ5pL8DaFmvRbu6p6Vn3ZxbyBE7fvkhkIusP
X-Google-Smtp-Source: APXvYqxcJRiRdd6D1c5Pv+BgVobza9XrTYh+KI5O4LB8s7GfwrVCf1d+AcwJDUrBmFJGQQUdsPPShrYphXhjMjlE7is=
X-Received: by 2002:a2e:9603:: with SMTP id v3mr19860053ljh.11.1560796000383;
 Mon, 17 Jun 2019 11:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <f0179a5f61ecd32efcea10ae05eb6aa3a151f791.camel@domdv.de>
 <CAADnVQLmrF579H6-TAdMK8wDM9eUz2rP3F6LmhkSW4yuVKJnPg@mail.gmail.com>
 <e9f7226d1066cb0e86b60ad3d84cf7908f12a1cc.camel@domdv.de> <CAADnVQKJr-=gZM2hAG-Zi3WA3oxSU_S6Nh54qG+z6Bi8m2e3PA@mail.gmail.com>
 <9917583f188315a5e6f961146c65b3d8371cc05e.camel@domdv.de> <CAADnVQKe7RYNJXRQYuu4O_rL0YpAHe-ZrWPDL9gq_mRa6dkxMg@mail.gmail.com>
In-Reply-To: <CAADnVQKe7RYNJXRQYuu4O_rL0YpAHe-ZrWPDL9gq_mRa6dkxMg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 17 Jun 2019 11:26:28 -0700
Message-ID: <CAADnVQ+wEdHKR2zR+E6vNQV_J8gfBmReYsLUQ2tegpX8ZFO=2A@mail.gmail.com>
Subject: Re: eBPF verifier slowness, more than 2 cpu seconds for about 600 instructions
To:     Andreas Steinmetz <ast@domdv.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Edward Cree <ecree@solarflare.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 16, 2019 at 11:59 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 6, 2019 at 6:31 PM Andreas Steinmetz <ast@domdv.de> wrote:
> >
> > Below is the source in question. It may look a bit strange but I
> > had to extract it from the project and preset parameters to fixed
> > values.
> > It takes from 2.8 to 4.5 seconds to load, depending on the processor.
> > Just compile and run the code below.
>
> Thanks for the report.
> It's interesting one indeed.
> 600+ instructions consume
> processed 280464 insns (limit 1000000) max_states_per_insn 15
> total_states 87341 peak_states 580 mark_read 45
>
> The verifier finds a lot of different ways to go through branches
> in the program and majority of the states are not equivalent and
> do not help pruning, so it's doing full brute force walk of all possible
> combinations.
> We need to figure out whether there is a way to make it smarter.

btw my pending backtracking logic helps it quite a bit:
processed 164110 insns (limit 1000000) max_states_per_insn 11
total_states 13398 peak_states 349 mark_read 10

and it's 2x faster to verify, but 164k insns processed shows that
there is still room for improvement.
