Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F257BEF4
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiGTUIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 16:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGTUIG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 16:08:06 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF047BBE
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 13:08:05 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id t7so4102519qvz.6
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBt2aXduXrk3yTFTMljU9bjqy/gjhF70VjHkOj8ezJQ=;
        b=fpOe6RRt86snubDzij/nij4d7nEXqB7gZ5vUfuXDSb4mEXI7wFsTEUnHWkadGGT+SV
         qS+CfCoE5Ak9EtNzmTrS+G1bH3Ag74/yRC8BQjNdDixQOlm9cufa8URUF5fsbgKUUeKo
         WDJw+qHQONYANM93QWG1sw9uf+4Rdn1X+Kjg0VMn+KupawJfnkDA0o8lSk+xWs5+PzUm
         JwcBAeybMS+er8/b3SvFrgoCVIBIw0mlK80q/LlmAd0ULWTRwDSOkKNN0tqZZdGiGt68
         Ord3doXJBGbROeZfkwFVjDZhAwsM/enKr7kzThzTHfLsghQ96ifMMzWPIuSxxRMq/kFa
         DHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBt2aXduXrk3yTFTMljU9bjqy/gjhF70VjHkOj8ezJQ=;
        b=r/j2MxKNBCe1SeFMjxsSpMpMBaSbLkgot8ipe9uysO8cwIViBQoiY2jCXlx+JFUjD1
         XuV9KGBN2ZpjhjQ27VSNVTLCRU4h8VZYpm+2rAR/eeB3BXXHZC3nKawAjDymtp9NwtnF
         MyHhhoLqQv2+EoGK52LLlq0knfnDg76gMjEI9w2pFOvDRYDbcSOZNllGrJBiMis8n2lL
         2kV4o8NmLK7BZvl+LfACA1lOuXigZPw92ZaGuP8WSSmxrqo1NNC6B0C7XV9ZmH9hNqG1
         VRucRHAMkJz4jEjZYJXbDX1nO2CJjYXVZ+au9Ai7eQrBIjjCXt2QUs5sM1ERhPIWptN3
         h+Gg==
X-Gm-Message-State: AJIora9CFnwNS1IiZkpBFF4CGe7d8MZ6ivmEZC0TW43vljZQBgprXkf9
        UILJ77NTJJNsUDnwUGovQyfXOmHBKVM+0juPfJaIlQ==
X-Google-Smtp-Source: AGRyM1vyf1j8XqVCErCglA0UEjOSGZrnbuaSbmW1xdUCg7HF23L5loulxZKywUcdPsvfRbBWorrP7qBY6KYLgxte8fk=
X-Received: by 2002:a05:6214:761:b0:470:8558:d1c3 with SMTP id
 f1-20020a056214076100b004708558d1c3mr31210261qvz.107.1658347684520; Wed, 20
 Jul 2022 13:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220719170555.2576993-1-roberto.sassu@huawei.com> <20220719170555.2576993-2-roberto.sassu@huawei.com>
In-Reply-To: <20220719170555.2576993-2-roberto.sassu@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Wed, 20 Jul 2022 21:07:53 +0100
Message-ID: <CACdoK4LMvLyV2z5quN1BE4VrxGJK-f1YfuHWoQrJaH_eKyHZog@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpftool: Complete libbfd feature detection
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        terrelln@fb.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 19 Jul 2022 at 18:06, Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Commit 6e8ccb4f624a7 ("tools/bpf: properly account for libbfd variations")
> sets the linking flags depending on which flavor of the libbfd feature was
> detected.
>
> However, the flavors except libbfd cannot be detected, as they are not in
> the feature list.
>
> Complete the list of features to detect by adding libbfd-liberty and
> libbfd-liberty-z.
>
> Fixes: 6e8ccb4f624a7 ("tools/bpf: properly account for libbfd variations")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/bpf/bpftool/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 6b5b3a99f79d..4b09a5c3b9f1 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -93,8 +93,10 @@ INSTALL ?= install
>  RM ?= rm -f
>
>  FEATURE_USER = .bpftool
> -FEATURE_TESTS = libbfd disassembler-four-args libcap clang-bpf-co-re
> -FEATURE_DISPLAY = libbfd disassembler-four-args libcap clang-bpf-co-re
> +FEATURE_TESTS = libbfd libbfd-liberty libbfd-liberty-z \
> +               disassembler-four-args libcap clang-bpf-co-re
> +FEATURE_DISPLAY = libbfd libbfd-liberty libbfd-liberty-z \
> +                 disassembler-four-args libcap clang-bpf-co-re

Do you know if there is a way to fold the different feature-libbfd-*
features into a single one for FEATURE_DISPLAY? Or should the various
features be all moved under feature-libbfd with multiple attempts,
like you did for disassembler-four-args in patch 1? My concern is that
users may think some features could be missing when they compile and
see that detection fails for some items.
