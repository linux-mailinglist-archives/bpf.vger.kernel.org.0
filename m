Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57456D84F4
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDER3q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDER3p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:29:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942B75FFD
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:29:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50263dfe37dso3174542a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kic4xDWrNjbQmDexRPtuE/SYeDc81hmLCpfWIv8qrS0=;
        b=Rak8mPzosGTRQBi4Uazoz+MVLHs+g3K53uhnigFglGW/FwpfVDQshoGRtee/p9CoiP
         demefs6O/+qWHIsGhXt/I09rY041AMjFO9NziFsk5Uiw4cdJCvVkOb7CDpzgB1Ba7Wqf
         VwJphltqkf5lXdqqD3V6NVkV9wL5dw2mM59C7CDfCEkk1zIpdHn/S+gl87jOxIitr22i
         +nySQfHes+c00eRDCh0dASA/hlaFxfrwpYapyh8V9QRyG3Wb049n3aRc0fwCWukcRQC2
         cIR12/23vlAhFNoDATmrUCSwEdtllOCpLnL2FYVdAZU7bYjjlWnyPsmQGBzUC7pBy5jq
         3YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kic4xDWrNjbQmDexRPtuE/SYeDc81hmLCpfWIv8qrS0=;
        b=XtyN0J6t4NxXCgL7uia1WUOjdOqqjMBD7YaU0AcJubWuErND+OSUlyFol1DJEWti7C
         TN03bNQUVb9+uESBCQua5E40XE1aR8Et+HYASVG8jQW6gzFK/eP8GxNVZZZXcP/+ZPS7
         r32IMG5b9c+zMM7bQGqoX6K770hOcHOCdypcnNbDladE6Ew4MagsmHdDquLjfEysOjSZ
         dvga7YaEggTw9yc02r/Lv7r0b/hd5K6IlVNrxtGTqsQHuQfpD8b8tj5l3YptBWF3ok9N
         vLin6o+hOarWOBaRaKaYIvNw0fMoxbUGAT1grxW5gG4RK6s1vZ9zAy0jl/GT5231wcNk
         qOPg==
X-Gm-Message-State: AAQBX9chiv8bEDHObW2SujeEqPtC18m6yyyjKY+HQL05bUnTa9q5kD42
        NLCYrjHosxuD4jUKdAxiITDg5blt2P+ffZPvDJCfRQ==
X-Google-Smtp-Source: AKy350b2KOokRGcrQZ4HcALJecu5tA/Mttitx2jT5t/SsvvjjL4xknuaNJ9KT0MzL/OuN6IO0H7VRN+XOnIOgMxuc24=
X-Received: by 2002:a05:6402:28ca:b0:502:3e65:44f7 with SMTP id
 ef10-20020a05640228ca00b005023e6544f7mr1834781edb.3.1680715780186; Wed, 05
 Apr 2023 10:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-8-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-8-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:29:29 +0100
Message-ID: <CAN+4W8jxes-_HGCXUnE9X1iz1CDLEA7Wq=36-cvqinxHZQYXxQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/19] bpf: ignore verifier log reset in
 BPF_LOG_KERNEL mode
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Verifier log position reset is meaningless in BPF_LOG_KERNEL mode, so
> just exit early in bpf_vlog_reset() if log->level is BPF_LOG_KERNEL.
>
> This avoid meaningless put_user() into NULL log->ubuf.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
