Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024736E9D7B
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 22:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjDTUym (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjDTUyl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 16:54:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099E423C
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 13:54:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso1493127a12.0
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682024078; x=1684616078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f8zODwR8TUz7+tcysXubjIEbYTXEyqLVaEEeS8I30g=;
        b=B+6+xjy8twPN01WDXIaq3hB6APc81nbufQcgFQZQQOsPlVlt+mf9Im7Lf5H3Ms5pPr
         dEzF3oj+WiZbkeeDbXvme+QKlLHZ03+dOJRfDXooF43BncVQzBfUh7kLglE9rj9kUEDV
         pRiI6xO2q3ZWXmq1IfxKWPKdCKuY+u2J2IduaqdG3zfvi18TK5j/ntj0G8UvEnFUiNni
         BqMBaWyuexoQP2JBIn7SYwyDvYggwHutBq1ugXIR0M0SB8SFwpIPBKUSvkpNRbWN9hAJ
         7BQhoB/e/VtDm5AYLkOVPPM4wTfOhIMRWfpMDMKkw2qsCanNDtRxRWnsaHziP2meTU0s
         frBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682024078; x=1684616078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f8zODwR8TUz7+tcysXubjIEbYTXEyqLVaEEeS8I30g=;
        b=I41iUAIO29dvN0F7VuZSf9d7xpZoVsfB/fHNkQaFEmmoHjwv1ForMb5AA8wVUhzKya
         6BSBd3pyOolFWTCvkMxnUIatoLwT/euO2GMbW86bgTVQRbecWOyu3oxh8leaa/yYy8h/
         Z7mkLl9UXurE2pDAM1YfS5BotKaNrpliJ6MpjWF3H+D/AzKrhT7FQW63paWPcdoslttx
         n23NI+1WD/VReLRf+aaiBct2i/5qCc/gbViWAlsLyuuN8m0YQNlvwU14xRsvoxQnegEf
         2EC0AVA+gOZalMkrLS5eiqq5UOFzCBJW4OXwUBFeEyPgJ5gsUUu3aYxX1COAEUDKo0WF
         9tEQ==
X-Gm-Message-State: AAQBX9fbI027iHddnnaOr4ejt8i4JdYuSNrOQzUJjqgjIwCC2t38AkR5
        hD4GgDY2oTjzeAQbS3YG6jspshlWZDdlrml4alE=
X-Google-Smtp-Source: AKy350ZMsmusalbI4GWPsbMes17vSDQMrRKMh8d+Ra6qGwa/UG2kkakmRrhhRz1kvZiGZSOfjAHxxRZ48KmKPFWofpc=
X-Received: by 2002:a50:c3cc:0:b0:504:efc0:9f97 with SMTP id
 i12-20020a50c3cc000000b00504efc09f97mr1245079edf.3.1682024078366; Thu, 20 Apr
 2023 13:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <xunyjzy64q9b.fsf@redhat.com> <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
 <xunyjzy6z3vu.fsf@redhat.com>
In-Reply-To: <xunyjzy6z3vu.fsf@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Apr 2023 13:54:26 -0700
Message-ID: <CAADnVQK-Dig-5DB6tM_sgggyvqHUXSbBud0R=rAPWT2VRtQ-ZQ@mail.gmail.com>
Subject: Re: sys_enter tracepoint ctx structure
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Viktor Malik <vmalik@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>
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

On Thu, Apr 20, 2023 at 1:37=E2=80=AFPM Yauheni Kaliuta <ykaliuta@redhat.co=
m> wrote:
>
> Hi, Alexei!
>
> >>>>> On Thu, 20 Apr 2023 08:59:09 -0700, Alexei Starovoitov  wrote:
>
>  > On Thu, Apr 20, 2023 at 6:57=E2=80=AFAM Yauheni Kaliuta <ykaliuta@redh=
at.com> wrote:
>  >> Hi!
>  >>
>  >> Should perf_call_bpf_enter/exit (kernel/trace/trace_syscalls.c)
>  >> use struct trace_event_raw_sys_enter/exit instead of locally
>  >> crafted struct syscall_tp_t nowadays?
>
>
>  > No. It needs syscall_tp_t.
>
>  > test_progs's vmlinux test
>  >> expects it as the context.
>  >>
>
>  > what do you mean? Pls share a code pointer?
>
> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf=
/progs/test_vmlinux.c#L19
>
> SEC("tp/syscalls/sys_enter_nanosleep")
> int handle__tp(struct trace_event_raw_sys_enter *args)

I see. That bit is correct and that's what bpftrace is doing
when attaching to syscalls.
What do you see in your patched RT kernel when you do:
cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/format
?
Depending on the answer we might need to fix
the kernel side that has to use struct trace_entry
in syscall_tp_t instead of plain long long.
