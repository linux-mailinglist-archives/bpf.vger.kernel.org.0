Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C078B529565
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 01:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350401AbiEPXlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 19:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350404AbiEPXlO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 19:41:14 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F215A3A
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:41:11 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i15so1704934ilk.5
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8xq6+fQokPOmhQXgkmsKmGIwXSOaDzucGTLLFlz3ih8=;
        b=DKx0ETDHbcPf3gUt7HAmoCIGUfOF9rlsM8cmT/JVvbaP5kORPWAvoOao1PZSvVUBGu
         AcLWVm2gpzbTFZejp4GTM35/LBjEphnICyJAbuLZu/fC88ofmKcC9CsK8JNWvLxDVg7f
         cNvXWBJ+fNd2xrnE1+L8NTotn5TVKTLOhVycxIAwhm7lzu5D0xvXrdhjpRWCsG9KJdbz
         dEiQ9G6Pgs6fcDnJsXpQw4mXxeYBitjx4pQKPbcFDxazX9j83rkamQRakZb3ooGqv0dU
         cEyH7cZCL1x+3yK//ZZ1bYVApIVNhPdLZuRu643oz/MHaRmAuyVq2j4vY0PRots9Mzzl
         j/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8xq6+fQokPOmhQXgkmsKmGIwXSOaDzucGTLLFlz3ih8=;
        b=1b39D952l6qwD2ShlUOjV7IyUvoPqAjxVsDpllU2Jg8KVd0qd+2LuDR1mOm/Nxplhj
         H3NLUHmcDjIBvDNvIpPVljpDfJRHSOnMtqpOPFKV4mHb0+2Rw9GYX34OLUeJdyeEo1H2
         BeKRnw4WEejvTrdLLojt5Yx2SOvjQN4cE0822agLj5HOiDrwfjA0i7RcB/3h7t+qL7E7
         OxUOHy/vAQSiR6Ocl67ZvzkeQL90SyoyTm7lG0LyWuO/Qc/WH3KCR0jetIgibUKqhe0X
         7y6i9Sp4L7gDPtOa5UPpaakfr+Rt5hlLwiecIFomFVZTeDj80LS4rZu0b9JH44qawfs8
         ds/w==
X-Gm-Message-State: AOAM5328ZICNlznJJ5g2d+zjDnwaq0fICkyyDowigwP01sPIbyffsL48
        82JFmz2FkliUPsPVsChAJjiLSeIJop0hihcPmG4=
X-Google-Smtp-Source: ABdhPJxFrsMVPaXo0V3bUABtt1DE7z6z4Eyr3SZSMnSi2RfVHbqu4CaRqPaNUWziVPUhxctiztxWZrR6Jphw7BLT/t8=
X-Received: by 2002:a05:6e02:1d85:b0:2d1:39cf:380c with SMTP id
 h5-20020a056e021d8500b002d139cf380cmr295168ila.239.1652744471341; Mon, 16 May
 2022 16:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220516173540.3520665-1-deso@posteo.net> <20220516173540.3520665-10-deso@posteo.net>
In-Reply-To: <20220516173540.3520665-10-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 16:41:00 -0700
Message-ID: <CAEf4BzYXxSerQnw3U5SKU10HAbM1KrTj9z_DvX+tQqaq7+2CUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/12] bpftool: Use libbpf_bpf_attach_type_str
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 16, 2022 at 10:36 AM Daniel M=C3=BCller <deso@posteo.net> wrote=
:
>
> This change switches bpftool over to using the recently introduced
> libbpf_bpf_attach_type_str function instead of maintaining its own
> string representation for the bpf_attach_type enum.
>
> Note that contrary to other enum types, the variant names that bpftool
> maps bpf_attach_type to do not follow a simple to follow rule. With
> bpf_prog_type, for example, the textual representation can easily be
> inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
> remaining string. bpf_attach_type violates this rule for various
> variants. In order to not brake compatibility (these textual
> representations appear in JSON and are used to parse user input), we
> introduce a program local bpf_attach_type_str that overrides the
> variants in question.
> We should consider removing this function and expect the libbpf string
> representation with the next backwards compatibility breaking release,
> if possible.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---

Quentin, any opinion on this approach? Should we fallback to libbpf's
API for all the future cases or it's better to keep bpftool's own
attach_type mapping?

>  tools/bpf/bpftool/cgroup.c | 20 ++++++----
>  tools/bpf/bpftool/common.c | 82 +++++++++++++++++---------------------
>  tools/bpf/bpftool/link.c   | 15 ++++---
>  tools/bpf/bpftool/main.h   | 15 +++++++
>  4 files changed, 73 insertions(+), 59 deletions(-)
>

[...]
