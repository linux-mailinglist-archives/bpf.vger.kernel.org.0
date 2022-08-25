Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105F55A192B
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiHYSxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbiHYSxc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 14:53:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A8B6D51
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:53:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v14so4769896ejf.9
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=F3UQw/oEPAVWlomN/rgczr4FtllspZQh2OL7U169HSQ=;
        b=NUFrgp0lDQsvE7u2asfA4WsLP9PYdsMIfxYatQ/EUpFeJrI2uAWLJ4UphN3rMvAuhQ
         H6Kd9ySNnfp5+dyFFQavnva/Z/yvGYfFaVs9d2PTyPxtPYPfvS/aodgv0jLhWu++fyjR
         O1Zf1cPbMLfFabwD8DkwM+7n2pi1cnEtBhA+806hZvaZSrDugDotmuCLP6rFBRBmo4Ck
         yN/9MRb1IHK8szO2kYMn1nUAYuAhqW8EIu8zTmxk0pUOIYjUu5uL594VQw71CgPMNHVU
         Mt3HiC3/Tyz+Xkz2K+4SJu8oHTQ2htFlu5FMxs84c7B21XTWYFPl/jtZAwpsHs9yiOIp
         BGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=F3UQw/oEPAVWlomN/rgczr4FtllspZQh2OL7U169HSQ=;
        b=xrE0pbmUIl4W+ZgOIzmxYOoL1fMWGBH02YcNowwj4RYX6xLffa3ChBPkWiV2Sjt3cS
         ewzRdzTg75n0i9TyZUYUCr+2A1LvWz2flifLc5nW8nBdRTNNRJNzLZjLtJ4Znh8nNhG6
         I0Wrqljp83szgZBno/DtjhqU8QD3b/koqTrWPKvWqvGt09rhI/+xDDjMLM5A2jlS8XZ+
         aT0jW9CLIHh/zx3po6vJjSK7hlAkrDVSMATMUlGWeXBOGNiWYO8+xn3FKWEyK26qg/k/
         TZnMEONAVEe4VV86/0S6VOULSUm6McurKYnAtn4Mcpx71PaR0pxOWmbhR78OxM1a6at2
         /XfQ==
X-Gm-Message-State: ACgBeo0U79dfmNG5sXGx+A8dq8pGcQF1wOOyd6M9btOaSYX417bS+Htd
        QeWalhBh7JTHNsI/6I3gkL+576PSJonbGxm3LUs=
X-Google-Smtp-Source: AA6agR5mIIE9S0NLT5FxUuQNWPKZfFm++rtEplObppeqxYZgZum+h3FOiJu/l/9WO8VFf7XlFSvecWihN/bPwm8OHSc=
X-Received: by 2002:a17:907:6096:b0:73d:9d12:4b04 with SMTP id
 ht22-20020a170907609600b0073d9d124b04mr3405042ejc.745.1661453609950; Thu, 25
 Aug 2022 11:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220824181043.1601429-1-eyal.birger@gmail.com>
In-Reply-To: <20220824181043.1601429-1-eyal.birger@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 11:53:18 -0700
Message-ID: <CAEf4BzaQ9ZS0a4Y_nTaXUX6m5PM0VC9B92o9uhGxwydZkocMXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next,v4] bpf/scripts: assert helper enum value is
 aligned with comment order
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        bpf@vger.kernel.org
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

On Wed, Aug 24, 2022 at 11:11 AM Eyal Birger <eyal.birger@gmail.com> wrote:
>
> The helper value is ABI as defined by enum bpf_func_id.
> As bpf_helper_defs.h is used for the userpace part, it must be consistent
> with this enum.

I think the way we implicitly define the value of those BPF_FUNC_
enums is also suboptimal. It makes it much harder to cherry-pick and
backport only few latest helpers onto old kernels (there was a case
backporting one of the pretty trivial timestamp fetching helpers
without backporting other stuff). It's also quite hard to correlate
llvm-objdump output with just `call 123;` instruction into which
helper it is.

If each FN(xxx) definition in __BPF_FUNC_MAPPER was taking explicit
integer number, I think it would be a big win and make things better
all around.

Is there any opposition to doing that?


But regardless, applied this patch to bpf-next as well as an improvement.


>
> Before this change the comments order was used by the bpf_doc script in
> order to set the helper values defined in the helpers file.
>
> When adding new helpers it is very puzzling when the userspace application
> breaks in weird places if the comment is inserted instead of appended -
> because the generated helper ABI is incorrect and shifted.
>
> This commit sets the helper value to the enum value.
>
> In addition it is currently the practice to have the comments appended
> and kept in the same order as the enum. As such, add an assertion
> validating the comment order is consistent with enum value.
>
> In case a different comments ordering is desired, this assertion can
> be lifted.
>
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
>
> ---
> v4: fix variable name typo
> v3: based on feedback from Quentin Monnet:
> - move assertion to parser
> - avoid using define_unique_helpers as elem_number_check() relies on
>   it being an array
> - set enum_val in helper object instead of passing as a dict to the
>   printer
>
> v2: based on feedback from Quentin Monnet:
> - assert the current comment ordering
> - match only one FN in each line
> ---
>  scripts/bpf_doc.py | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>

[...]
