Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF66E34C2
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 04:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDPCn2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 22:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDPCn2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 22:43:28 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0199630CF;
        Sat, 15 Apr 2023 19:43:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id me15so1916161qvb.4;
        Sat, 15 Apr 2023 19:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681613006; x=1684205006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emh2Okv2wtPboESKlb9uAvYp8mFKsbIQggX9WGkmmVA=;
        b=FBqaM60tznk3PqkeiIJOe8qPlXA7CzcxGp3cR4bLX9cI+aucjWVbEdFh5fhQ2kj1KV
         K0LZtbb63OrxwZkpij9AKw2or4UitoTw0K6WRfonLuMUgMuBXkKKsDNW1WV9k5dJOBkd
         wH9Wwf99onwF9EivFsFjGcbEWphRkg0TpC4Md2Us4ntmaSM9na1YxrK1kNTSBVo/3UJi
         2v5YFVCKgTFWunuk6NxaPQqTK63CByOWgBl33uP4MjjLjiYpEIvO45rpUWyYPSQu8UcD
         kNmgPRp2V2ef8Qctg0nSjqkInQQtjaQFT5sQ7oupK3pfRnPsddhmqITSHW+5MGD1fsCI
         OnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681613006; x=1684205006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emh2Okv2wtPboESKlb9uAvYp8mFKsbIQggX9WGkmmVA=;
        b=Wg5EJj+1YVq8YjybSCp4UTbts3et5IDzah6kKmIzXNb9T2DmiiOpCU49Syx8aMmCxX
         UI9PN70UDXAeB8ko7Q1XeGrHy5OB5GFzFJll7jmVD+if9oetYICzu+Y8e7m2OEkvu0P4
         ILAog1o9AkdNGADQWUSkBGs5xvCvBlnF6PBJJCDgrpKtUVCRC29SInAGK99DuMDltUba
         qqQoKhm3qSg/xkMsRWK2ZnKZBmkEocsTn6h6WKuobxryDY7vt7CViHiRWzkyDTKpt6cs
         eDzmTItwhlgU6Z8Na6EJ/YW6WRX3MmCu6IMTq01FX+AsTwFLUQYf0L3823eS/jXyvDVX
         fDHA==
X-Gm-Message-State: AAQBX9ePetH1e62JtLFugIXTZTmnphP68eBmC7JJg7Gcnxf6sdD3/okz
        v7g+cIazpF1zATDRzcwS3nXr5E3F1DyTUg2daSCcwIUDdAo=
X-Google-Smtp-Source: AKy350Z6KtN6UyhQVcp+nh44u6AxqibNwzsunsv2Mhtz3En9ISlSb5f9GUug0kDFh9BlG5pihoQaprHmGWVTZkzFrJQ=
X-Received: by 2002:a05:6214:c69:b0:5ef:52f0:7b1e with SMTP id
 t9-20020a0562140c6900b005ef52f07b1emr12671857qvj.31.1681613006151; Sat, 15
 Apr 2023 19:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230414221702.554c44fe@rorschach.local.home> <CALOAHbDUkvyu0hWXfcveJBW_dxDkqUTVBmwXt5Y-ERBv9GksbQ@mail.gmail.com>
 <CALOAHbB9VvOAuA5kG3YpS-XMqX9AFGxbuOQWerJTQYgsqU182A@mail.gmail.com> <20230415114635.15d9eda8@rorschach.local.home>
In-Reply-To: <20230415114635.15d9eda8@rorschach.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 16 Apr 2023 10:42:48 +0800
Message-ID: <CALOAHbCFWCzV6PQXkB7YyyPuLOZv27yABDADgbwi1F76pOzwVg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add generic test_recursion_try_acquire()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 15, 2023 at 11:46=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Sat, 15 Apr 2023 22:33:17 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> >
> > I don't have a clear idea why TRACE_CTX_TRANSITION must be needed, but
> > it seems we have to do below code for the fentry test case,
>
> The issue is that there's still cases that we can trace when
> preempt_count hasn't been updated to the new context. That is,
> preempt_count is used to determine if we are in softirq, hardirq or NMI
> context. But there's some places that have:
>
>  normal context:
>  func_a() --> traced
>    --> interrupt
>     func_b() --> traced
>     preempt_count_add(HARDIRQ_OFFSET)
>
> Now we drop the second trace because it is flagged as a recursion when
> in reality it is in a new context, but the preempt_count has not been
> updated yet.
>
> We are currently fixing these locations, but it's not there yet. And
> since there's tools that relies on not dropping these locations, the
> transition bit needs to be there until this situation is dealt with.
>

Got it. Thanks for your explanation.

> Can you change the tests to allow a single recursion?
>

I think one single recursion should be acceptable. I will change it.

--=20
Regards
Yafang
