Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7F33E931
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 06:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhCQFo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 01:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCQFo5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 01:44:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF3C06174A
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 22:44:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 15so1746120ljj.0
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 22:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aW3l1v4i0+mhV7RJ7jgYexGTTGS7RrtlRCneTO6vhd8=;
        b=I9/jn4YzrAlh+8qWGeA1UxX4mEIS+an/KfJTEP0+PzcLbONOxkKhS/bXoSaFP1MphJ
         qZ28Hr+0hEiRCCv7i824Tran0tQYI7vEPVNYJOsyniogCjPPldYKfTM24oimw8UfdpsJ
         3GPRbhGpSLT6BtU4sRjKsXgQv7tP8ZPudsNdmocc2V7mbzt9Ia7vulEYKrJ4zmEPLDnQ
         be9xs64xRaHVQuvkHOzvhReQxBDlBnIAY/f0xHfKrnmwXaLNNwwdG6jALqjt6yDkvd6D
         Ip8vnGcOhBko+EcdXeklAaQc1CNKhUC37pAvdOhm2Exmu8aeeeWbAm0iq3OKs07p7qCy
         u2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW3l1v4i0+mhV7RJ7jgYexGTTGS7RrtlRCneTO6vhd8=;
        b=KcMquThK/WRDSbJZ/jxKfKkvIU+txHrs/D3Rq4L16kS1TWm5Q7s4WJxjtNI5tFZpQI
         CtC0KeOJJbKpbw/0sVPFEa+eZPiPedtepKANeYI3mKsmOu8y0bmB1Pn89lQQyP18//w8
         NsDpD4LsLx3xYTt8p32WxI46UdUm7v3k9LG7SsuPWIA74YYUcoUSJaQwBt5urWF+zcmD
         c2+GIQEyfGmtqBjvyecreJ5TYfRP9W8Uti0Nsfe0R6NfcG12aT9j0Hsf9t0h9BH2gTtC
         64uPa1ANpk2K6PI3UIerjVaKVkYrLUxjePDQlxduj6opv89d8IAU5lnXBCHDCqosUGwy
         qaww==
X-Gm-Message-State: AOAM531McKQgN76jKnutaXBEtJ2XRI0wuAOSxYLjrN6WhxK6BoHqTLc3
        WN7WxesshEJpWQhiA+AoD+i+1LbWpBDV0ibSY5Q=
X-Google-Smtp-Source: ABdhPJzrEhekEMtz/fqgA53hPGEMhCdsPy0qf7On3q765f/0NAqnVLZvFZpmE7EoxGAf6F3W8czPjdCCgMI6uon8Znc=
X-Received: by 2002:a2e:8ec1:: with SMTP id e1mr1355259ljl.236.1615959895941;
 Tue, 16 Mar 2021 22:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210317042906.1011232-1-yhs@fb.com>
In-Reply-To: <20210317042906.1011232-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Mar 2021 22:44:44 -0700
Message-ID: <CAADnVQLY1ftbZxFqAMSN4amWoYZN0ka3DyVLXAWhgsTO7V9V+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: net: emit anonymous enum with
 BPF_TCP_CLOSE value explicitly
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 9:29 PM Yonghong Song <yhs@fb.com> wrote:
> +       BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
> +
> +       return 0;
> +}
> +late_initcall(bpf_emit_btf_type);

I think if we burn a dummy function on this it would be a wrong
pattern to follow.
This is just a nop C statement.
Typically we add BUILD_BUG_ON near the places that rely on that constraint.
There is such a function already. It's tcp_set_state() as you pointed out.
It's not using BTF of course, but I would move above BTF_TYPE_EMIT_ENUM there.
I'm not sure why you're calling it "pollute net/ipv4/tcp.c".
Consider that BTF_TYPE_EMIT macro is serving similar purpose
and it's scattered around net/core/filter.c
