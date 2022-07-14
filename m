Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8F574439
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 07:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiGNFIV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 01:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiGNFHf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 01:07:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8145F63
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 22:07:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y8so962111eda.3
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 22:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpk7Y+UDUwnsHzF9bGK99kDtr34OClPDDThITUcPaVw=;
        b=ewaho8H2QM/V2jqaVsNIt9dyL8i2Lzt1U5cMp4kyzUhK5DjiYa2GUxLUxcpjeHfSMr
         ngNEXc7WjnQUly0hn4I+/p6QlIj7s9xbBDDsOGJvoHtIicerLJNuxPNOqeVZfTBqGR2j
         IHtzYPDvOEbMg9uwjH1Uyh7yDmxeNMvBRJ7fPP8zdHmyT2g61L4uY388estzjlX3Wvw/
         V7rmb4Qns9QlpEaIWpJ5bwAviOV5vtznDM0xCxYljqXGb+jD6kdktWDQrrFc8rV8gU3L
         v+ntVYeV3TgBiF9LVmf48QFgaO9DYDib63QhgQoa9Jq/2nHBAOI0lkAD0I0zvZMlewM6
         XQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpk7Y+UDUwnsHzF9bGK99kDtr34OClPDDThITUcPaVw=;
        b=ok3lvjz5l44tqH3Zb+4u3Ilu2JK0YjTy6E+GO4cKMKl+zWpXzFiEhbydvNaK/HEy6V
         9Kmdgv6wl0QRGYgwPv0tZrTGGaJrho0r40BN0ylQrbhyDfKaH8b5TrHyR0a4P9wtNk5q
         TdLH7Pf0CeHcd1jNbmspal7q+XrZ2nz3FWbkq4IcCTQYW9t0aTgygu7tg7Ti/vvlj06A
         B9og72KHqb80LJkXr2/ojGJfmxu05kjcU8FBSAc/zhhIMNN498HwrNA4ojX93v0Zww3X
         4eJCp08H7bBpWf6r9E0zLSqVvXwRR2t/J2h+m07ZNcF/ruLkn8BpVv+S8h6f+XueHOKd
         3mKQ==
X-Gm-Message-State: AJIora9kh6zPpn9BiUepCPLjzQ08imD1KfTLVI/PInZxKSZmsWpWnJ2V
        0T1zRMW2o6pPHspmMZ9/22dM3iR2MRax0Dx6DTsczvFk62w=
X-Google-Smtp-Source: AGRyM1v4VoLdWXeNoUo0UownG7jE+CG4+wisHCvQnw/1wB2yE4knQj81yFV6BIzLOyQoSKoYnORskp8GcIxp/yKYzI8=
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id
 n4-20020aa7c784000000b0043acaa875b9mr9608745eds.311.1657775233295; Wed, 13
 Jul 2022 22:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220712212124.3180314-1-deso@posteo.net> <20220712212124.3180314-3-deso@posteo.net>
In-Reply-To: <20220712212124.3180314-3-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 22:07:02 -0700
Message-ID: <CAEf4BzaK0H8MPSUQY-VLHuqMJtO1EE-4RpLAh=hRMCXN=dZBVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Integrate vmtest configs
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
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

On Tue, Jul 12, 2022 at 2:21 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This change integrates the configuration from the vmtest repository [0],
> where it is currently used for testing kernel patches into the existing
> configuration pulled in with an earlier patch. The result is a super set
> of the configs from the two repositories.
>
> [0]: https://github.com/kernel-patches/vmtest/tree/831ee8eb72ddb7e03babb8=
f7e050d52a451237aa/travis-ci/vmtest/configs
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest | 5 +++++
>  .../selftests/bpf/configs/denylist/DENYLIST-latest.s390x     | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest=
 b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> index 939de574..ddf8a0c5 100644
> --- a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> +++ b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> @@ -4,3 +4,8 @@ stacktrace_build_id_nmi
>  stacktrace_build_id
>  task_fd_query_rawtp
>  varlen
> +btf_dump/btf_dump: syntax
> +kprobe_multi_test/bench_attach
> +core_reloc/enum64val
> +core_reloc/size___diff_sz
> +core_reloc/type_based___diff_sz

I don't think any of these are necessary anymore. Some of them were
due to nightly Clang was stale.

> diff --git a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest=
.s390x b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
> index e33cab..36574b0 100644
> --- a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
> +++ b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
> @@ -63,5 +63,6 @@ bpf_cookie                               # failed to op=
en_and_load program: -524
>  xdp_do_redirect                          # prog_run_max_size unexpected =
error: -22 (errno 22)
>  send_signal                              # intermittently fails to recei=
ve signal
>  select_reuseport                         # intermittently fails on new s=
390x setup
> +tc_redirect/tc_redirect_dtime            # very flaky

same for this, yes it's flaky, but this shouldn't be in this list (I'd
rather people actually fix the flakiness, of course). These configs
should be "known not working" test cases (e.g., like BPF
trampoline-based for s390x, that feature is just not implemented). But
flaky tests should go here, they should be ideally fixed and not be
blessed officially to be ignored.

>  xdp_synproxy                             # JIT does not support calling =
kernel function                                (kfunc)
>  unpriv_bpf_disabled                      # fentry
> --
> 2.30.2
>
