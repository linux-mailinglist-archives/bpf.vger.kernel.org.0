Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E94AA31D
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349213AbiBDWYv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 17:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349198AbiBDWYv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 17:24:51 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F3AD3B2B7B
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 14:24:48 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e17so10419487ljk.5
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 14:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N54sf+iIhght26Vz13JszBtsuz/tfVBuwvPWIP5OlAw=;
        b=iuhBwcue9AaxsAgIGQkyYXsAvagyI95r3iozYysQIYzfoI7TGDF6/qrxQGlj5qBkyS
         DlPvPxfmyPRNpgoFkx7odqS2CukeMYmBbRs+0su7gzcZwWnnnhBHJQVogexqAYITC2bw
         eyR8cVIxApaSDk5fiRf5JuJ2NlCwShJAFSc44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N54sf+iIhght26Vz13JszBtsuz/tfVBuwvPWIP5OlAw=;
        b=iX9Yzi8xrae8Tgf3lBPSWFGUtl4Al6XPdT9nJIOPX6+m+81GxzLpg457GM0nNBUJU4
         9tZAp9FJ+prtRJNW5n8vvSrfPgXkdwESNlfClARFjLNo5tUeL7PMBbd77gUn5m1n0juN
         qMPdQemfOsG9S212E9HzRvojPl72xfj+9bbqprcQmDJlk/pO6YMG8rPIngvVEOEf0VDQ
         u1mopE4YbNjjiNp1xX+10lKwuRd0zryg6jZ9A1BoIHv23XPvzlincfK5sXYp4nFxfyiR
         nl7tWv5/NRDoU7d3PjUlM5xcBB5t6Le1Mgbl6ytw04OGQFARTTFtC7M79s0GxWNf+a31
         jBiw==
X-Gm-Message-State: AOAM532c2z/FhJ0iIvJTNOTnCtJLTEv1AKMhrjp1oZMhF7hIe+wPGb9r
        papeAlz1vACmpFKbV4tEL1D0NH/atGHmXk5J9Uh2Vw==
X-Google-Smtp-Source: ABdhPJxyvGT8nD8ZyJmBlQMt8OGN3pH+9/5bMLKUdB8M9gQD/Jvxf4vJ+Ey1dUjDCMQN+m9OyvfXNLiwRG2z6jP/0f8=
X-Received: by 2002:a2e:908a:: with SMTP id l10mr644231ljg.310.1644013486775;
 Fri, 04 Feb 2022 14:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20220204220435.301896-1-mauricio@kinvolk.io>
In-Reply-To: <20220204220435.301896-1-mauricio@kinvolk.io>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Fri, 4 Feb 2022 17:24:35 -0500
Message-ID: <CAHap4zuWvKru+rMztAPdJk+BES5pZCJy-tOegV4h03TX3vbkjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix strict mode calculation
To:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 4, 2022 at 5:05 PM Mauricio V=C3=A1squez <mauricio@kinvolk.io> =
wrote:
>
> The correct formula to get all possible values is
> ((__LIBBPF_STRICT_LAST - 1) * 2 - 1) as stated in
> libbpf_set_strict_mode().
>
> Fixes: 93b8952d223a ("libbpf: deprecate legacy BPF map definitions")
>
> Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>

This patch fixes the problem but I'm not totally convinced it's the
right approach. As a user I'd expected that `LIBBPF_STRICT_ALL &
~LIBBPF_STRICT_MAP_DEFINITIONS` disables
`LIBBPF_STRICT_MAP_DEFINITIONS`, but it doesn't work because the test
at libbpf_set_strict_mode() returns -EINVAL.

What about using one of the following ideas instead?
1. Remove the check from libbpf_set_strict_mode().
2. Define `LIBBPF_STRICT_ALL` containing only the bits set of the
existing options. `LIBBPF_STRICT_ALL =3D ((__LIBBPF_STRICT_LAST - 1) *
2)- 1`.
