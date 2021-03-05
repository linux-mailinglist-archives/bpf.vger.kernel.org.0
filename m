Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4779332DFF0
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 04:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCEDKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 22:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEDKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 22:10:20 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E395C061574
        for <bpf@vger.kernel.org>; Thu,  4 Mar 2021 19:10:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k12so945994ljg.9
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 19:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nvOmoAD+MOZyrbIjNhhHfZ9y+BLsKMGUvuZNiXcqtk=;
        b=OdBgtyLfZA68giU+1j724IpXhu8Cvr9sjGA9wgeLQZCxNC032lbUo+fHkU1guqoEXG
         9BNTyJEfugx/MCsx6gKioEoa/LjNc8CrBC5pvdnBDY1CkAm1dKPptOV3i0Nqq9kFYxLm
         Yn0YJFFAT5/OfH2S45lTjicRWusd1zNiy9ACIvITovwuVsLSHYZ4kRo/qeL06DP9t/vK
         ZYqI5HiZ4Cu7FPDuD9Lwz82/CDWLCaV+stWm7TD3Nbi615mdr7LtP6SrhB/hWmYJlAlb
         WDElpxbjPrwZDhiZycBZzlZ4VP3lS5/N81Jfu/a3fAqkIsUOud6nBQ+yqyuJ+n54sU9T
         E4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nvOmoAD+MOZyrbIjNhhHfZ9y+BLsKMGUvuZNiXcqtk=;
        b=RXb0FpMmi/OMfFBa75GrkLfmjC9pvKKlOKpRBD1ROl80P+6oOGmrNr9sZawaDhkLSb
         +cDF5LMd9MSNBqvJT9CHxX1s6oHXJ3VAEY6u5jXSqEUyieP8megAnvz+Y7d+XMNcZkP7
         Rwi0jVcqy/lkEruKO+Mpn1Z0vwMXW5GgftDqwaflV7OUzlJs/gDNCIouM3u3gKusvj9r
         mVJ2oIRsGPnIfLmXAeNiMaos06/8aWE92Gcz2oIBpV6HYLP84T4KS6349DqQI+YDcF9S
         XmI4UDnmLbd3iQnRAPqZwipUn65p1dJsL7I9FB4MJftu433lkRSeEfugHrmxL3+m2tth
         mtXA==
X-Gm-Message-State: AOAM531HwnLxw6IFNdun2CxFEjkqZhuQh7b2DvSx++DWYSTSEeFuhTfV
        csQQlNgbVvGrdK/WVkoE6uAz6hSeRRc3I3P9bow=
X-Google-Smtp-Source: ABdhPJyTvUNlabNgWZ19Eiyi+8CZlzdRr41hubP7iDhanT8ephaqHizXSJy9BLe7U60l7bbShXbJutuaH/E31dYZ8mg=
X-Received: by 2002:a2e:3608:: with SMTP id d8mr3838303lja.21.1614913818740;
 Thu, 04 Mar 2021 19:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20210303110402.3965626-1-jackmanb@google.com>
In-Reply-To: <20210303110402.3965626-1-jackmanb@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Mar 2021 19:10:07 -0800
Message-ID: <CAADnVQLUJQF=0fJSOTfTRN67RY2K+71X=DxBtRgmATg7i+8-Ug@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 3, 2021 at 3:04 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> Note this still goes on top of Ilya's patch:
>
> https://lore.kernel.org/bpf/20210301154019.129110-1-iii@linux.ibm.com/T/#u

It didn't. I had to manually patch it in.

> +static bool is_cmpxchg_insn(const struct bpf_insn *insn)
> +{
> +       return (BPF_CLASS(insn->code) == BPF_STX &&
> +               BPF_MODE(insn->code) == BPF_ATOMIC &&
> +               insn->imm == BPF_CMPXCHG);
> +}

I've also removed unnecessary () and applied to "bpf" tree.

Thanks!
