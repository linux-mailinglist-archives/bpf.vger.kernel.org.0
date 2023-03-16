Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F226BD422
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 16:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCPPmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjCPPlr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 11:41:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD148C2D92
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 08:41:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso5665116pjb.3
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678981260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWtxiI6u3PLhzROb0W9QCRbZR4W+y7+CKl0MvD1ECyo=;
        b=R8KsDUcAMUsseamt0Cr5S1eKcoh15UqdwSMkn4d7vwtdALOwqU8QZwjAvRozwdLhn7
         r3cgfRZlSvqQQtTOojoPN3BvROAr2RN2N6iqHgE0MGaYDUeEo04lWChsnKhdE6TsXnR5
         sSE4EOaIGqV+RLyCU40lTPOdlwCsqd8pMiH18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678981260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWtxiI6u3PLhzROb0W9QCRbZR4W+y7+CKl0MvD1ECyo=;
        b=Nl8vsaQO8JT7xzYuxLD39Ar6sDscIcMpF9H70ueENa9nH8G8mbIbOuWo7exVddOpZF
         YBQs5DXYgdvD6w6G3shO2KRa+Dw2YdzN1MdlrTmMuBnweGgvCdXUTM6Fa3cmGHNCI40a
         5DZUUg/2BuIXpPgfNo8rBmmGMyT7NKWtfauIpjAK0YkeTkohfwZDFfpYk1JG1LqX/9dw
         WWf9nfIROiN725DU/CYmZpKKuczsMSABEyccHdvIihCOvc/3T9FJiegxc/wf28xdLcSg
         ZlU2BLREtEvGvZa+8mKZy/ujDnU/D2dWj7Qa8ztlPXmq8uG8PhP/Eb+S1Ib9u72wxuOY
         lvlQ==
X-Gm-Message-State: AO0yUKURjCY8qUIDHVeabjccNBtuN7SG13f3CT7pSoinbLFCcxrDM1Qy
        0lFW/QOoxu7jOh1/sQlcBFTHW3xwzOI1au6PTL2Osg==
X-Google-Smtp-Source: AK7set9qa9SraVDU2uIf/xPTxeISitKn+URkcvoZFmOq+KmcsDmQNGj9ek7q83Ak97zDy41okMWoMpxW7ecgklX9jN4=
X-Received: by 2002:a17:90a:df96:b0:23f:1caa:233a with SMTP id
 p22-20020a17090adf9600b0023f1caa233amr1196529pjv.1.1678981259713; Thu, 16 Mar
 2023 08:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230207182135.2671106-1-revest@chromium.org> <20230207182135.2671106-5-revest@chromium.org>
 <20230315194334.58eb56ab@gandalf.local.home>
In-Reply-To: <20230315194334.58eb56ab@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 16 Mar 2023 16:40:48 +0100
Message-ID: <CABRcYmLLbRGZXWwEpyLW1YFz87tTPA8pCL7oLd4K6Hp9Etr5LA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ftrace: Store direct called addresses in their ops
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 12:43=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue,  7 Feb 2023 19:21:29 +0100
> Florent Revest <revest@chromium.org> wrote:
>
> > @@ -5445,6 +5445,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, un=
signed long addr)
> >       /* Enable the tmp_ops to have the same functions as the direct op=
s */
> >       ftrace_ops_init(&tmp_ops);
> >       tmp_ops.func_hash =3D ops->func_hash;
> > +     tmp_ops.direct_call =3D addr;
> >
> >       err =3D register_ftrace_function_nolock(&tmp_ops);
> >       if (err)
> > @@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, un=
signed long addr)
> >                       entry->direct =3D addr;
> >               }
> >       }
> > +     WRITE_ONCE(ops->direct_call, addr);
>
> I'm curious about the use of WRITE_ONCE(). It should not go outside the
> mutex barrier.

This WRITE_ONCE was originally suggested by Mark here:
https://lore.kernel.org/all/Y9vW99htjOphDXqY@FVFF77S0Q05N.cambridge.arm.com=
/#t

My understanding is that it's not so much about avoiding re-ordering
but rather about avoiding store tearing since a ftrace_caller
trampoline could concurrently read ops->direct_call. Does that make
sense ?

> -- Steve
>
> >
> >       mutex_unlock(&ftrace_lock);
> >
