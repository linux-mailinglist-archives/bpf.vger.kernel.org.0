Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740DB5AF1C3
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiIFRFZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbiIFRE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 13:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687371012
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 09:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735A3615A8
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC607C433D7
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662483102;
        bh=eVzpS8UbW3F7NnvzwrjmHwwSUdB2CW3lOO+QslUAmMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cfh+rX1bbJpQZhf2thYL+rRVmsQT5fzFiqJxuS3h4Av6FjxfQkab1TBbd2X7qo2aE
         lHomKAqra3t2d7KxyOVIY0qLVlbpUpcdaXhttQRQ12y2eTfqtyAghmmorC7aCLVAHn
         kvFiv/8zbxI+DE3bFOG9a2Wjb3Crm/eS06TkK0FYEWizWbu7fMXvoqLPvGmpySGoDb
         k2TYPqQvoax2ENnnbZ5fNhp14UKAyNbk283brLZWmoEm3sRdkaNiG8AbkyCwatLFLg
         /e31tTc4uluMAotDrFEr2/x3+kg85dCsYYYEG8+X0KkqTO1DMY12qwr7/t3epJ8WkW
         88B4phwOOSJUw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127a3a39131so8817693fac.13
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 09:51:42 -0700 (PDT)
X-Gm-Message-State: ACgBeo3VK6ltn9uck+L2NATLDwWv8XXUodk8L/+J1VxHI6PI2sTssLTg
        ySm9tUtCDB0ABNbQM4bE4XRAIRA4ylUgcrwmZa8=
X-Google-Smtp-Source: AA6agR59TCxORs6AceoiEdZNr/mAmlVPxMXuIFwRm5jFfAtyKclw0Q9AlD5fCR70mTRxQKrSgTnEclX8gL6kpYOhjf8=
X-Received: by 2002:a05:6808:195:b0:342:ed58:52b5 with SMTP id
 w21-20020a056808019500b00342ed5852b5mr10812855oic.22.1662483101976; Tue, 06
 Sep 2022 09:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220905072219.56361-1-ykaliuta@redhat.com>
In-Reply-To: <20220905072219.56361-1-ykaliuta@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 09:51:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4fKb17XXW5LhosJb5PPPFM+G0bqde1d6MC62TtrM=SVQ@mail.gmail.com>
Message-ID: <CAPhsuW4fKb17XXW5LhosJb5PPPFM+G0bqde1d6MC62TtrM=SVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: bpf: test_kmod.sh: pass parameter to
 the module
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 5, 2022 at 12:25 AM Yauheni Kaliuta <ykaliuta@redhat.com> wrote:
>
> It's possible to specify particular tests for test_bpf.ko with
> module parameters. Make it possible to pass a module parameter as
> the first test_kmod.sh argument, example:
>
> test_kmod.sh test_range=1,3
>
> Since magnitude tests take long time it can be reasonable to skip
> them.
>
> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/test_kmod.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_kmod.sh b/tools/testing/selftests/bpf/test_kmod.sh
> index 4f6444bcd53f..3cb52ba20db8 100755
> --- a/tools/testing/selftests/bpf/test_kmod.sh
> +++ b/tools/testing/selftests/bpf/test_kmod.sh
> @@ -4,6 +4,8 @@
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=4
>
> +MOD_PARAM="$1"

Shall we use $@ to pass all remaining arguments to insmod/modprobe?
Otherwise, users may get confused when some parameters don't get
passed.

We should also add a help/usage message or at least a comment in the
script.

Thanks,
Song

> +
>  msg="skip all tests:"
>  if [ "$(id -u)" != "0" ]; then
>         echo $msg please run this as root >&2
> @@ -26,15 +28,15 @@ test_run()
>         echo "[ JIT enabled:$1 hardened:$2 ]"
>         dmesg -C
>         if [ -f ${OUTPUT}/lib/test_bpf.ko ]; then
> -               insmod ${OUTPUT}/lib/test_bpf.ko 2> /dev/null
> +               insmod ${OUTPUT}/lib/test_bpf.ko $MOD_PARAM 2> /dev/null
>                 if [ $? -ne 0 ]; then
>                         rc=1
>                 fi
>         else
>                 # Use modprobe dry run to check for missing test_bpf module
> -               if ! /sbin/modprobe -q -n test_bpf; then
> +               if ! /sbin/modprobe -q -n test_bpf $MOD_PARAM; then
>                         echo "test_bpf: [SKIP]"
> -               elif /sbin/modprobe -q test_bpf; then
> +               elif /sbin/modprobe -q test_bpf $MOD_PARAM; then
>                         echo "test_bpf: ok"
>                 else
>                         echo "test_bpf: [FAIL]"
> --
> 2.34.1
>
