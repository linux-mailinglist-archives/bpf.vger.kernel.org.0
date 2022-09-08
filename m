Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477EB5B28A4
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 23:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIHVkd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 17:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIHVkc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 17:40:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E820598A6D
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 14:40:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r17so13758970ejy.9
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y7uCupdfGICNU3IGLTSItOIJHsGgc04rv9t+0y6y8ro=;
        b=DFhMM5KGo+56LHU+PwKhd2RK+ero4rd0nSAzCmclBFgx1fJSOZ4+V6hatTe5d4IK4N
         jYDKE8cjKgX0amB7uNEMFR1axTeFMtK1hYUiEixD8mj4B3C1iQsh8g/shKwz3O8qltb1
         MXLCRaymx2sXrKt3w4Pw5anbyGhdP1eKhACrwkXP5UWz9sxLJFShEm4Cv5oHDzthhsmu
         lRnX8vGZwFMlda6CcPjXWORilrPrAEveyXkVXt/cV+qhS92E6VO2jmZErQxoKy11SrCX
         EKp++UMN8U+wwNw7oTkbPnEtZ5SH0QIVlnEXCvRrmRSB21Kkd9pgF5/6641f1/L89URH
         MOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y7uCupdfGICNU3IGLTSItOIJHsGgc04rv9t+0y6y8ro=;
        b=ei5iImtah3jpsbK3y8H2nf5CPX/uV+6TaioHYNThhqKURDdpzttt4lJvlY0jya74yE
         QMT4tstR6Y2bDyMUBBK3v480byf9mL/IJOIEMUrNEQMtdJA/fZRvWQtHSspzhk5r9REB
         nZmeY3py33wSLjuKXbVVXBgfuKCRFRAlzf4PpzM5TEdipAXr06QAb4Z6r5pPf9YeTCXM
         sqO2JOJoe/VMUzcz8Xtt5r+zMgmIxvNS5MgxHJfBPMnP54VhIaODYQW0i6eRiGfPa4JB
         ltZWRea+fALU5zr3jGj5OUPTnk2+XX/qvRo2N+/5NCR3lZhnTg642XOLExvF2CtsL5r7
         JUzQ==
X-Gm-Message-State: ACgBeo1SYD4wMXKQFv53+MX2Zyx5HpIqKSFp+8lQQG34qEG7flb3RpK5
        GaCM6qmHTeYQ5RuvtmZ+fZruQFcnjiKtzHcp+qY=
X-Google-Smtp-Source: AA6agR5w+KVJ79wKPpBykkoDoh+ntTXDrwk+Z+TaXEcj6sWzGpHAgw7/wSI0Jz9GEcN+hbxFfuQ8VL0hUs3E2aKXd2E=
X-Received: by 2002:a17:906:58d1:b0:76d:af13:5ae3 with SMTP id
 e17-20020a17090658d100b0076daf135ae3mr7818368ejs.708.1662673230403; Thu, 08
 Sep 2022 14:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
 <20220830172759.4069786-2-davemarchevsky@fb.com> <CAJnrk1ZpZ1uLtyiaOK5Sij1nANa8xhOsxMq7PKzyKjVEcL0VtA@mail.gmail.com>
 <93490d2e-6709-e21d-a38a-40296a456808@fb.com> <2d2bd4ef-e8c8-194e-1d12-a45bb63c9b44@fb.com>
 <687d070e-6607-7aef-0d84-6c7dbc0b574d@fb.com>
In-Reply-To: <687d070e-6607-7aef-0d84-6c7dbc0b574d@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Sep 2022 14:40:19 -0700
Message-ID: <CAADnVQJDNLjPUuAK7ONLswwJq-qXZEVUj2Q8bvQbRG7DQuobyg@mail.gmail.com>
Subject: Re: [RFCv2 PATCH bpf-next 01/18] bpf: Add verifier support for custom
 callback return range
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, Sep 8, 2022 at 2:37 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/6/22 9:53 PM, Alexei Starovoitov wrote:
> > On 9/6/22 4:42 PM, Dave Marchevsky wrote:
> >> On 9/1/22 5:01 PM, Joanne Koong wrote:
> >>> On Tue, Aug 30, 2022 at 11:03 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >>>>
> >>>> Verifier logic to confirm that a callback function returns 0 or 1 was
> >>>> added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper").
> >>>> At the time, callback return value was only used to continue or stop
> >>>> iteration.
> >>>>
> >>>> In order to support callbacks with a broader return value range, such as
> >>>> those added further in this series, add a callback_ret_range to
> >>>> bpf_func_state. Verifier's helpers which set in_callback_fn will also
> >>>> set the new field, which the verifier will later use to check return
> >>>> value bounds.
> >>>>
> >>>> Default to tnum_range(0, 1) instead of using tnum_unknown as a sentinel
> >>>> value as the latter would prevent the valid range (0, U64_MAX) being
> >>>> used.
> >>>>
> >>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >>>> ---
> >>>>   include/linux/bpf_verifier.h | 1 +
> >>>>   kernel/bpf/verifier.c        | 4 +++-
> >>>>   2 files changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> >>>> index 2e3bad8640dc..9c017575c034 100644
> >>>> --- a/include/linux/bpf_verifier.h
> >>>> +++ b/include/linux/bpf_verifier.h
> >>>> @@ -237,6 +237,7 @@ struct bpf_func_state {
> >>>>           */
> >>>>          u32 async_entry_cnt;
> >>>>          bool in_callback_fn;
> >>>> +       struct tnum callback_ret_range;
> >>>>          bool in_async_callback_fn;
> >>>>
> >>>>          /* The following fields should be last. See copy_func_state() */
> >>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>>> index 9bef8b41e737..68bfa7c28048 100644
> >>>> --- a/kernel/bpf/verifier.c
> >>>> +++ b/kernel/bpf/verifier.c
> >>>> @@ -1745,6 +1745,7 @@ static void init_func_state(struct bpf_verifier_env *env,
> >>>>          state->callsite = callsite;
> >>>>          state->frameno = frameno;
> >>>>          state->subprogno = subprogno;
> >>>> +       state->callback_ret_range = tnum_range(0, 1);
> >>>>          init_reg_state(env, state);
> >>>>          mark_verifier_state_scratched(env);
> >>>>   }
> >>>> @@ -6879,6 +6880,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
> >>>>          __mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> >>>>          __mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> >>>>          callee->in_callback_fn = true;
> >>>> +       callee->callback_ret_range = tnum_range(0, 1);
> >>>
> >>> Thanks for removing this restriction for callback functions!
> >>>
> >>> One quick question: is this line above needed? I think in
> >>> __check_func_call, we always call init_func_state() first before
> >>> calling set_find_vma_callback_state(), so after the init_func_state()
> >>> call, the callee->callback_ret_range will already be set to
> >>> tnum_range(0,1).
> >>>
> >>
> >> You're right, it's not strictly necessary. I think that the default range being
> >> tnum_range(0, 1) - although necessary for backwards compat - is unintuitive. So
> >> decided to be explicit with existing callbacks so folks didn't have to go
> >> searching for the default to understand what the ret_range is, and it's more
> >> obvious that callback_ret_range should be changed if existing helper code is
> >> reused.
> >
> > Maybe then it's better to keep callback_ret_range as range(0,0)
> > in init_func_state() to nudge/force other places to set it explicitly ?
>
> tnum_range(0, 0) sounds good to me.
>
> Would you like me to send this separately with that change, so it can be applied
> independently of rest of these changes?

Whichever way is faster.
We can always apply a patch or a few patches out of a bigger set.
