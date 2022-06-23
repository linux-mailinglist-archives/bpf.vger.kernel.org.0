Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD5558A7A
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 23:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiFWVKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 17:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWVKA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 17:10:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123337A2D
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:09:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c13so694327eds.10
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3fN93irlt8vgDW4hKqbSxKPWsTPMN5h9pNYJXqICNW0=;
        b=ijQHjh+ndHH6mlMLmASSdPwP62YH3rUr73biUczpa915hkwuIwIYrgmUn0dyHLm16p
         9L3o6qNyNJBhAbgu7g3Ti2BFTLMTSep8LmQ/aKR8YGt8ddFYZ1/dLNh2P/WdPG666Its
         w5Ddt+boCevRmPbhJdalQJ6AkoLqiCT/7GumkISCuZSDEkD9pnuYRfUXVF543c9ZFJrj
         M66aCb/9IiYd+9sgoyJJZMljSGi209smxz81RuG+ObGR9k8GuUfabqHez5/954U3JlgA
         IShJBv98TxM5bbNBYbdOyDfCly6+a9TSauOspJVXdvgqoioiguY2KgA2LSeJagHUa2/K
         sdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fN93irlt8vgDW4hKqbSxKPWsTPMN5h9pNYJXqICNW0=;
        b=dAXXr7J6RcpR6YnadxxW7LMOPEDNylHNGeK3ZlOeLHCMHJ8LADggZw0dTDc2QU/kJq
         opTgGyXBcfU+3IX+qZWwaNgOJWgAJcjqID2z1IycBYmSTjCQAAehZphc8F1vAZmMiEhT
         hJ7xC63VTzaJAZyFfatMM2/KT1zjgHWT/KYm6bnVJLqregDTEL0pd4vVu3X3MoFCzowr
         +Fu/r0Yn6r5fK9TCpvWR7jtLLldCjkCnUWUzcSJfMS1i3FeKHzzcluUcLki8fO5JHin6
         Rx7+vb8VS4G4SHvE66NLzkNvSL27rWWMBBIvY5j4yNJg2XTwPx0S/Tqkcn1i0oeSKK8z
         arxA==
X-Gm-Message-State: AJIora96+V9HLKwV9NCmWIMb6SgHiTCDoOalt7Ro6tD1thfmcwygOtVo
        8bR5XuMbFHxLh5H8FhwYN8UfFEAFwwaDBfYOZgY=
X-Google-Smtp-Source: AGRyM1sZTj0NNvffRaLQtk1xRMuAZmv9u/LLf5QMMOK/S9daSz3PncFzD98VMR0/gONR4RJl7Uu8O5VDumMHqW0n5VY=
X-Received: by 2002:a05:6402:4496:b0:435:d605:6ff8 with SMTP id
 er22-20020a056402449600b00435d6056ff8mr5624696edb.357.1656018597999; Thu, 23
 Jun 2022 14:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <YrQicyVuXTF3WecL@kili> <f3c818802a7df5a58256ac1494d6267e478d8dbc.camel@gmail.com>
In-Reply-To: <f3c818802a7df5a58256ac1494d6267e478d8dbc.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 23 Jun 2022 14:09:46 -0700
Message-ID: <CAADnVQJTMw3Yx4MVQvtLKhr3zjc0-iVh_Up8+YBPH1enzCk=YA@mail.gmail.com>
Subject: Re: [bug report] bpf: Inline calls to bpf_loop when callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 2:05 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
call_insn_offset - 1;
> > --> 14420         env->prog->insnsi[call_insn_offset].imm = callback_offset;
...
> >
> >       new_prog->insnsi[call_insn_offset].imm = callback_offset;
>
> Yes, I agree.

Good catch. The fix makes sense.

>
> Alexei, could you please suggest how should I proceed:
> - submit a new patch with a fix, or
> - submit a the complete patchset with the fix included?

The patchset already landed (see bpf-next). We don't revert
for cases like this. Please send a follow up patch.
