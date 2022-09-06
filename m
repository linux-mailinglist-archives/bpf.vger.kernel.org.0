Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8B55AF8AC
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiIFX4B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIFX4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:56:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C489D95
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4CC1B81AD8
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A54C4347C
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662508557;
        bh=OtubZhSvf3OyG/4a3kAYoH+UX6Pv16PwClH16uoTHr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/eEPe0U21FNvZSFmBC0SWqnuhpFIE4ah0i0DVeVQvJareauWNjnTHUfALOlTwdap
         wU3QYX+AjGkYLAyeFSHzUL/2WkFtjcFQTgjCO0gieVKcp49JAmAxx2sQ1ySqhh4wow
         RMllY3kYEc2YjyELQv87m4MTdYpsupwj0TCHAKo8EBq95VDSUC6o/HnnBxB1eDUvJn
         Ri7fU6iRKERNCLnroQO/ZCOKUWoQ51XhzUbX0M7Dxt3gfh1EmffbpDVi+fyagj3rFZ
         22hU76sCHjaFjKEqFoISnt232/Fp7Nueeu/6CS7AceEjHyCwCz8EL+BR/nbFdE2LW2
         ac3aUyseEmREA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11e9a7135easo32146263fac.6
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:55:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo2ERj7VKUIhj6kzioizV8ZfiPW2L1NeOxsWOf8FNeY9GpTbHXBv
        BBwNROojQnDBgMaKFM+N8F0gOIidU6lTYslgez4=
X-Google-Smtp-Source: AA6agR7NzP2gKzp3zeIJwBfNapBYN9xC3hunkdVWH++SARnszNKruSeJLeZzUjssLsDk45T3nNP2b+2xz/6NZ7Ivaj8=
X-Received: by 2002:a05:6870:32d2:b0:127:f0b4:418f with SMTP id
 r18-20020a05687032d200b00127f0b4418fmr456745oac.22.1662508556446; Tue, 06 Sep
 2022 16:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220906133613.54928-1-quentin@isovalent.com> <20220906133613.54928-6-quentin@isovalent.com>
In-Reply-To: <20220906133613.54928-6-quentin@isovalent.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 16:55:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7jbOkVBJH8BAo+3KPqmMCmnnKpVgS6niGnTy2ekkuBVA@mail.gmail.com>
Message-ID: <CAPhsuW7jbOkVBJH8BAo+3KPqmMCmnnKpVgS6niGnTy2ekkuBVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] bpftool: Refactor disassembler for JIT-ed programs
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
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

On Tue, Sep 6, 2022 at 6:44 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Refactor disasm_print_insn() to extract the code specific to libbfd and
> move it to dedicated functions. There is no functional change. This is
> in preparation for supporting an alternative library for disassembling
> the instructions.
>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Acked-by: Song Liu <song@kernel.org>
