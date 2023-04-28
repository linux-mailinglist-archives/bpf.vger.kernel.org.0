Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB896F1748
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbjD1MJb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 08:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbjD1MJa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 08:09:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19301FEA
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 05:09:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-246fd87a124so8389105a91.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682683768; x=1685275768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlMkUeh9xu7RaTJiHDnkhfpDO7yqYG9IjdoJsF3F6C0=;
        b=Q+/g726Lq+oqPlPH6eCRxpVbg71egFhWaV0dsxBLj3VmLnv5buTnt8XXRtS30QkmxM
         gN2xqnf03qxPd6p1RyNi3g5NFd2YThwmDHvQJJ8bngqh5iCcdJptEVzR5qEAeQKKfbLo
         XU6s5kmlN0HLvwJE2PqQ46TmUWCNGnoaUpvCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682683768; x=1685275768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlMkUeh9xu7RaTJiHDnkhfpDO7yqYG9IjdoJsF3F6C0=;
        b=Muj4bgl8fFBeOyPeZxEly1p5Etkpi6tMuIxWYyYaYvIPRhdECCD8CK0ueh5asqdtzk
         W6QwnosOHNer5y6kio7x8MPCS/vlH+qYF9WZpjWMy8uOG3ygtC4ut3mFmHVSxbbK0a3h
         53ovyYAzakhJw0Cv6BLyZyAyCuSsX90CD1I9U6XCxbsR8iXV0JveOaLCY8tJ+tJLlQas
         9lV0FfUs4v+KVucUWmeVF7OPctvKWLmDKXB8tOHa9+aaUAccOW6+rxPFgnkrGMDahgcZ
         acT+qH6FPLEEyP3WLXQo3/Rvo9GDTii8/X+BAPF+KcdgjGiBVbiKfaBGIWrUOipffwZh
         cTlw==
X-Gm-Message-State: AC+VfDxHdX3287yRkvweU+xx0Cun9hxn8ul/THu+bOq9IlOZmwHyGdXj
        GpAYl4MCfXTGcah9rCryR8TRTCaEVjoJWevd5Bh97w==
X-Google-Smtp-Source: ACHHUZ5hxBPp3cBJHuuYdP3WzxV11DAeDePQ7aDqsPEsBRQ0j8Ac62aGLafZc/PswC5MmKwxMAht+TSZrJ6s94mBp/U=
X-Received: by 2002:a17:90a:a502:b0:23f:7666:c8a1 with SMTP id
 a2-20020a17090aa50200b0023f7666c8a1mr5350347pjq.18.1682683768161; Fri, 28 Apr
 2023 05:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230428034726.2593484-1-martin.lau@linux.dev>
 <ZEteyNfBuJXlxnhG@worktop> <7801acd8-2a97-857e-dd99-07a3f85002cb@iogearbox.net>
In-Reply-To: <7801acd8-2a97-857e-dd99-07a3f85002cb@iogearbox.net>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 28 Apr 2023 14:09:17 +0200
Message-ID: <CABRcYmJZ2uUQ4S9rqm+H0N9otjDBv5v45tGjRGKfX2+GZ9gxbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add fexit_sleep to DENYLIST.aarch64
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Manu Bretelle <chantr4@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Manu Bretelle <chantra@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 1:08=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 4/28/23 7:51 AM, Manu Bretelle wrote:
> > On Thu, Apr 27, 2023 at 08:47:26PM -0700, Martin KaFai Lau wrote:
> >> From: Martin KaFai Lau <martin.lau@kernel.org>
> >>
> >> It is reported that the fexit_sleep never returns in aarch64.
> >
> > Just to clarify, this was only happening against kernels compiled with
> > llvm-16. It was working fine against kernel compiled with gcc.
> >
> >> The remaining tests cannot start. Put this test into DENYLIST.aarch64
> >> for now so that other tests can continue to run in the CI.
>
> +Florent (for visibility and/or if you plan to look into it)

Ah, thanks for the quick fix Martin & Manu! :) It's an interesting
failure mode, I'll try to have a look at it when I get a chance. (I've
had my eyes set on the other failing selftests already :) one more
eheh)
