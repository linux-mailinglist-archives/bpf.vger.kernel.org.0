Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E656E9902
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjDTQCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjDTQCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 12:02:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081041FE3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 09:02:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u3so7394935ejj.12
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682006547; x=1684598547;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNyh2SqdsT0eIdUDD2Aic9+d0UcFAkJlkSbPvSGE5L8=;
        b=eJqKDM5YhSzyhYkC1uDGNS4fA3eU+LzZz/bNHYFRfa4Led8J0dZWxpB7SMvGrPZKNk
         wO2KER1BV9PZPaSoogGWlRq3wGzBHbN3L9b8WBS2YB1u+YNjInlJSGIuf/XPidftFTAJ
         qFTzSA0X6PenKAjFz+3OXu6P710MpemxVejFfy1WK9oTw3YHa/5R9CGRyLmpug8kPyKo
         sjyC8x+bgLUi0RdUZEcTOiBVhEmO2E5EX0wY/WiRvMF4oJfW57os3dfNlj9T1vHLfmzZ
         uTY7WcXgetC/5+SZ6pF+y2oitVJUmvSXQtH/30tjmSACK31Ohsk21eybKHbfKk81LoBo
         XcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682006547; x=1684598547;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNyh2SqdsT0eIdUDD2Aic9+d0UcFAkJlkSbPvSGE5L8=;
        b=CfDoxXhiSaf+505r+z3Bd7kttzNtxrec6X5ME/klcB4/1+xduA8uffckk+1KVb8uA5
         nagtS8ambGf/ipXpmCRmCJpd36QMO9ploJKUbTBeXTC00+ynamjcrEaAmxRPntyARkhy
         R7LYMSQX0JxhiAdBfd1dxyQoOZaTpq0Sz2DdAv8XED9d6WDU7wMivpvPJTdPibdPp/Rd
         CwxYyElR5ygXBSvmsOKt17kMCBYDxDHjgl00pAG2hytq6n04YPUaueXznnepuU8yQJ/M
         d7ni4HfyIV8Ap+OBz6WVLzv0Pu6w6a18RyHtZ6yR9RuD6MYXLdPzGpV+r246u7mMzZwp
         s1yw==
X-Gm-Message-State: AAQBX9fiU1f/Gldg0OwezW2Rb3tzcMhziYD4Sy+sk3Z27b764s4Ubat0
        QDYIBbqSHqRX+z6yDjQQjIk0fXrRz/B8lTjQpQg=
X-Google-Smtp-Source: AKy350aN0tyxgAyAUgMi5ASSLZoOug4TSG6NSDuEU030f4gFxV4bjOKovk5JJNq6f2szj0oqls0LD5saGLhG3NWVW3k=
X-Received: by 2002:a17:906:4fc5:b0:93e:739f:b0b8 with SMTP id
 i5-20020a1709064fc500b0093e739fb0b8mr854136ejw.3.1682006547329; Thu, 20 Apr
 2023 09:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <xunyjzy64q9b.fsf@redhat.com> <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Apr 2023 09:02:15 -0700
Message-ID: <CAADnVQLT1+b3SY8MuXss3tvng9RP43DmFAzaByAa6OuiWwZwbg@mail.gmail.com>
Subject: Fwd: sys_enter tracepoint ctx structure
To:     Yauheni Kaliuta <ykaliuta@redhat.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Artem Savkov <asavkov@redhat.com>,
        Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 6:57=E2=80=AFAM Yauheni Kaliuta <ykaliuta@redhat.co=
m> wrote:
>
> Hi!
>
> Should perf_call_bpf_enter/exit (kernel/trace/trace_syscalls.c)
> use struct trace_event_raw_sys_enter/exit instead of locally
> crafted struct syscall_tp_t nowadays?


No. It needs syscall_tp_t.

> test_progs's vmlinux test
> expects it as the context.


what do you mean? Pls share a code pointer?

>
>
> Or at least use struct trace_entry instead of struct pt_regs?


no. It needs a pointer to pt_regs.
See all of the pe_* flavor of helpers.

>
>
> I have a problem with one RT patch with extends trace_entry.


Just extend it. It shouldn't matter.
I'm likely missing something.
