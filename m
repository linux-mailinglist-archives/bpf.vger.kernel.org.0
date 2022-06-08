Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E35436FC
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbiFHPQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbiFHPQA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 11:16:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F3BCE88
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 08:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B16961C17
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 15:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CFBC341C6
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 15:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654701092;
        bh=VztodrHMKiXkLJGDHqQsLNvDOTBnqwi6gtUtcCqbgwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fUfZoTSL32wrqzNkuDL2+3Ky8E1tJgZAZlMZuAxi9kqWLNsvMcn5YsWFk3AnBBwQL
         +tqBUMFEfMou/t7m5oRkm+wyca0fdKmRsEOvFLE0UBGGvFWGFpJ8JGI453ck4bRRsS
         u+eX6NS74cLNc2VQm1yfq/nAPR98G+Y5SHpC9m69QC1L1SnlAf3RyzuL+qqOe4gbhD
         KRRepeQ6Z6A6WNNLdVvK6AufNiUHvI2zPK3ViYXxaCvDtSyx9QummSX0gPTL/vu8wd
         4exlEnOj6Qd9LTSldWy2tar8IDK4BAbIOAxPqR1gy2uaGQur/Jj78eFH911WbqGu0c
         81nJa0+QEalDg==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31332df12a6so64426347b3.4
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 08:11:32 -0700 (PDT)
X-Gm-Message-State: AOAM532wGqDzZr6pbs5lD2sQScA/n+saBJ4IwoTdHLN0S/x3Je1uHsRu
        aL2sjBEq4fQIfHWW9sg0hadF7b16S/wMgFfMULWT9A==
X-Google-Smtp-Source: ABdhPJz3ZquWd8I6Tms60D0isIhoG8wJtbGnatoms0PzACZuMebl2zlEVC83F72y/Y0uOV4eLQDvc4QWxo8PFA+R6U4=
X-Received: by 2002:a0d:f502:0:b0:2ff:3e75:b4ea with SMTP id
 e2-20020a0df502000000b002ff3e75b4eamr36674184ywf.171.1654701091943; Wed, 08
 Jun 2022 08:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220608121428.69708-1-quentin@isovalent.com> <20220608073800.5185b78c@kernel.org>
In-Reply-To: <20220608073800.5185b78c@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 8 Jun 2022 17:11:21 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4SZej4J5yXngSjbu_0ukDQAk0h32TTntmxk9hAJajWtw@mail.gmail.com>
Message-ID: <CACYkzJ4SZej4J5yXngSjbu_0ukDQAk0h32TTntmxk9hAJajWtw@mail.gmail.com>
Subject: Re: [PATCH bpf] MAINTAINERS: Add a maintainer for bpftool
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 8, 2022 at 4:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  8 Jun 2022 13:14:28 +0100 Quentin Monnet wrote:
> > I've been contributing and reviewing patches for bpftool for some time,
> > and I'm taking care of its external mirror. On Alexei, KP, and Daniel's
> > suggestion, I would like to step forwards and become a maintainer for
> > the tool. This patch adds a dedicated entry to MAINTAINERS.
> >
> > Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

We talked about it at Kernel Recipes. Happy this is happening, Yay!

Acked-by: KP Singh <kpsingh@kernel.org>
