Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA52725C431
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgICPFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 11:05:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729261AbgICPFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 11:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599145523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOVrEUYdk3kqYhz58nsd0EQRqeC7szhYtr6POf0XNXk=;
        b=Rf3+K3jQr6uuz4NZRTagmZmhO0EYl05e6+r9lWqT6WXvyIkUF6yt8srq/LPRn32vhnEpAA
        Ob34dIAhTQQUx4+HpouMZPT8fqkcecy0lICXEpNzU51ilBcjNSbdkH5WD0KqVmSNJP2aH8
        fgy0Oxku7cUJPe6copNAeTYmdDg26iY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-9Rt-K7kZP2-eWUeFHckIkQ-1; Thu, 03 Sep 2020 11:05:21 -0400
X-MC-Unique: 9Rt-K7kZP2-eWUeFHckIkQ-1
Received: by mail-wm1-f72.google.com with SMTP id u5so826969wme.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 08:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOVrEUYdk3kqYhz58nsd0EQRqeC7szhYtr6POf0XNXk=;
        b=pru3MPany95Ez36CCozrcfFa/L/NKghLds2pPdV4Q7d7CwVNcb5G7fHiYFhLGM+PDL
         kDetbsJkSU4ITaoE3oOhtsKyAYYgzvGtDqke+Ld/L9uriG8Vjmsq5Nu7Ed2bQqqeuLWF
         4JzYDKh0SSGGvlX2ysYHdstiLGw3WI03W6GMnlIwaai0y/a6CeTACGaWsYyk6D/JAQev
         pboO7msc08w9G5jgRNALvfB9lbLduToSdc1oK2rU6SAWejm0rJc/40rQKqZ+ePjlGBeZ
         q7PSoY8LrFJrfqloDuJ7sGuppzv8z5b7BTB4EMXwWop/jDaobWSExJogoICsyEHhjS7i
         e3Yg==
X-Gm-Message-State: AOAM530KbLU9b4NfHDQ5gg2OfaCAb5ky/pML65Ig9lpyWTpq5wCiKNVe
        4m/2e7a7CrooJ5ltrq54Un/mJvBdzhu3bbUFDjAQw0jxWsQ1zEY3jSemxqmUs50HfV5YKNIyI32
        nWPSfI9fxlzR6TQKx2+4hQaWXQulj
X-Received: by 2002:adf:ec87:: with SMTP id z7mr3142360wrn.57.1599145519883;
        Thu, 03 Sep 2020 08:05:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLjJFPN1NxLKDMd8KkXAaAkuxu9RF8fHmq47C7XEZtFL+g1yuVpolpmRGsHYUXlE0mZH59Yh+KTHfIc4ZPNjg=
X-Received: by 2002:adf:ec87:: with SMTP id z7mr3142345wrn.57.1599145519689;
 Thu, 03 Sep 2020 08:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 3 Sep 2020 18:05:03 +0300
Message-ID: <CANoWswnqtp1hQsr=XAkviJ62mTkhXMqXEF0bOh971Ys-rgc3iQ@mail.gmail.com>
Subject: Re: [PATCH RFC] bpf: update current instruction on patching
To:     bpf <bpf@vger.kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Breaks
#76/u bounds check mixed 32bit and 64bit arithmetic. test2


On Thu, Sep 3, 2020 at 6:02 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> On code patching it may require to update branch destinations if the
> code size changed. bpf_adj_delta_to_imm/off increments offset only
> if the patched area is after the branch instruction. But it's
> possible, that the patched area itself is a branch instruction and
> requires destination update.
>
> The problem was triggered by bpf selftest
>
> test_progs -t global_funcs
>
> on s390, where the very first "call" instruction is patched from
> verifier.c:opt_subreg_zext_lo32_rnd_hi32() with zext_patch.
>
> The patch includes current instruction to the condition check.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  kernel/bpf/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ed0b3578867c..b0a9a22491a5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -340,7 +340,7 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
>         s32 delta = end_new - end_old;
>         s64 imm = insn->imm;
>
> -       if (curr < pos && curr + imm + 1 >= end_old)
> +       if (curr <= pos && curr + imm + 1 >= end_old)
>                 imm += delta;
>         else if (curr >= end_new && curr + imm + 1 < end_new)
>                 imm -= delta;
> @@ -358,7 +358,7 @@ static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
>         s32 delta = end_new - end_old;
>         s32 off = insn->off;
>
> -       if (curr < pos && curr + off + 1 >= end_old)
> +       if (curr <= pos && curr + off + 1 >= end_old)
>                 off += delta;
>         else if (curr >= end_new && curr + off + 1 < end_new)
>                 off -= delta;
> --
> 2.26.2
>


-- 
WBR, Yauheni

