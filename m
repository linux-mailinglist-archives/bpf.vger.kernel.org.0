Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5671D52A87D
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351158AbiEQQqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351106AbiEQQqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 12:46:52 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3174EA1D
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 09:46:51 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j6so14968921qkp.9
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83JZuRYGMhEYFc20Maeu6xSYCHW0XJW5bKDmH70MtQo=;
        b=MNP5Ej/XjSsUpaMUaJ9NuwYfo0zef1CZTQthL3MVO8gWobO7oyeJrXOpOSaeaLUCFm
         c7k+CFrdZxeGI8qeZXwXjCJI6mJoinSIpCAJfLiSK9OD21444+ryy9dcXkKFu7tc7eV0
         +hNgtoFGDvxjFW/jhAF+mhmdTTJyrCGj13Q/cF2IuwfoN7cGMbBJV7T6YFYfxcf9olm0
         RzrNYWjJxKx+im/DZ73EydtDYF+7co7Qs8ZASh6fmVMbmlwspJ7im4yk0oH41nQguoEX
         Al/ulRuW4TpbRUY0SGxUTHbKLQYz5c0lohSqa23uvM0Ip3afPh5craHMXWWd4ZTUfVh4
         piSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83JZuRYGMhEYFc20Maeu6xSYCHW0XJW5bKDmH70MtQo=;
        b=XM0A6IcdYgrUb8aq2QKnR3yosmHP8bSOBbmTVvX6Lx6xDxHQa217Q0AksjVDgWW8H5
         ug7iNyzf/DRYWV5il1Gft7KaiFlAyu+VRd1Z4xi1yfgVA1u76wFENqKRFLvCdRajH5Y4
         49qgTV/LCahnQVbXEjYaTCA0tg0raXakPLAnobnkU6FoHyasHlnxz6Wkhpf/zpAzzf45
         gsl8S1cSTdZmBABIkm5Cdm12SESHz1cIGoq5brdyicoQ3NfEEaVloE5BHtwlUFmL1Bcc
         dQOm/JuI3ptTZQz39yoKjx7hCQ5yK/XGX+LDFCL1c86faCes2OE86GULOtlCe2Pu9FZw
         FRrA==
X-Gm-Message-State: AOAM5323DK7bQNRnNTxLECT2qqkvof2G/+OM3LEs1VCYXOhCwRgpNqk7
        QHKWY1+5PK6b/c/GQ98yq0T8f/c34bPSt05+Z/dtfeiMCzw=
X-Google-Smtp-Source: ABdhPJzeqcJmMVRjW5QfNTw/P0HR+k0uX08XAMJ34XFFpjsqr9C4JesoakSwocgg+0eX8kqVZOQSben0aWT5/Rt9ACY=
X-Received: by 2002:a05:620a:146:b0:6a0:267b:49ea with SMTP id
 e6-20020a05620a014600b006a0267b49eamr17120215qkn.256.1652806010221; Tue, 17
 May 2022 09:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com> <1652788780-25520-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1652788780-25520-3-git-send-email-alan.maguire@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 May 2022 09:45:09 -0700
Message-ID: <CAADnVQJ7xn4dzX=d7d7mBtdQAUHza2xVZaHbmQHgD5yjV94uXQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add tests verifying
 unprivileged bpf disabled behaviour
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>, bpf <bpf@vger.kernel.org>
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

On Tue, May 17, 2022 at 5:00 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> tests load/attach bpf prog with maps, perfbuf and ringbuf, pinning
> them.  Then effective caps are dropped and we verify we can
>
> - pick up the pin
> - create ringbuf/perfbuf
> - get ringbuf/perfbuf events, carry out map update, lookup and delete
> - create a link
>
> Negative testing also ensures
>
> - BPF prog load fails
> - BPF map create fails
> - get fd by id fails
> - get next id fails
> - query fails
> - BTF load fails
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

It fails with clang build.
See BPF CI.
prog_tests/unpriv_bpf_disabled.c:207:36: error: implicit conversion
from enumeration type 'enum bpf_prog_type' to different enumeration
type 'enum bpf_attach_type' [-Werror,-Wenum-conversion]
ASSERT_EQ(bpf_prog_query(prog_fd, BPF_PROG_TYPE_TRACING, 0,
&attach_flags, prog_ids,
