Return-Path: <bpf+bounces-5720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B775FA67
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7842811C3
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AA4D515;
	Mon, 24 Jul 2023 15:04:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F5DDA3
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 15:04:56 +0000 (UTC)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B89AE73
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 08:04:55 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48137f8b118so3787571e0c.0
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690211094; x=1690815894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHqIG05NkrccDXJAf8XbSXjmXmn2uQaX/nG1JkN2ZQ4=;
        b=rHvVEBAR04v4zkCIM9x/6ysbPN4+cOs6SbN3rIMINLLg0x+sDuZfw2BqPor1/IUIN8
         ALSQxb8q5eqRYWUlJfLhl6IOxbB5N/PBOpktXBprHnEBFZCDc2Tb27CiyMLywa2o56CJ
         eJ//Trf+64HEm3uqZFXu22fs8wIo92ugIwJbUXmsDvSlepLpBTJQhgR/xZLggJshgFF2
         4oxkB7rx7chZN20ZnTaoNqEb8ZSgQLVV8XdL/U//Q8hSEfq+XwApKvzretRKAFz9XEqM
         y+SGPqK7u0GgtJAN0SgQhn4TqNLjUqPFQccj2M3hUDsi3APWIIq2p0yDcAYLEWV8/Vs2
         gYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211094; x=1690815894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHqIG05NkrccDXJAf8XbSXjmXmn2uQaX/nG1JkN2ZQ4=;
        b=foqQgGivcT9bUQWr0aqRh4qgI7HDW+hRIuq5E2wgTKoIkjiwlRrshm8ra7eG2omnn9
         GPErj39WvJaqLeRVVFmorzbz/87mZ/8ztEFepoDezXDR7Piz1WWH3GmAlajud0zgwEci
         zG7lWx8kTSi/YBCQmtZOMLHA6R+HAbr5aNqtZ/oNQMR6aq0o/2nBYjHZFBivq5SLNryM
         gqQslFz2h0DFp031wbx54SO/dJP+YNq/hD1685WWc0Rj5FP4YRCkQEnUvZcJR3t6d7iX
         6PUxX98N8kdZE0zuWJJTtiCn9j1wFrqeuttgtI844/yWqcQT9Vv7SqYwUOqD35bxTvmA
         1lrQ==
X-Gm-Message-State: ABy/qLa/RZqg+miYIHP+P9IoXCTz63cr9SZHMSgwyCTK1AiHlL0WynK4
	xJVhvRHjXt5Ey/qfTfBityJecTH4WNTyJMlyo/434QEhDGc=
X-Google-Smtp-Source: APBJJlEV03X8EXPg2+YL+/MvfIsUzRACx0EuuApez+Zu6wzEIT8lcNJNnENWD8Chl5ND6A8tSTVD9KJ6pVgAUKMC3CQ=
X-Received: by 2002:a05:6102:32c5:b0:445:4a0c:3afb with SMTP id
 o5-20020a05610232c500b004454a0c3afbmr2814071vss.8.1690211094071; Mon, 24 Jul
 2023 08:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
In-Reply-To: <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
From: Timofei Pushkin <pushkin.td@gmail.com>
Date: Mon, 24 Jul 2023 18:04:43 +0300
Message-ID: <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 3:36=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 24/07/2023 11:32, Timofei Pushkin wrote:
> > Dear BPF community,
> >
> > I'm developing a perf_event BPF program which reads some register
> > values (frame and instruction pointers in particular) from the context
> > provided to it. I found that CO-RE-enabled PT_REGS macros give results
> > different from the results of the usual PT_REGS  macros. I run the
> > program on the same system I compiled it on, and so I cannot
> > understand why the results differ and which ones should I use?
> >
> > From my tests, the results of the usual macros are the correct ones
> > (e.g. I can symbolize the instruction pointers I get this way), but
> > since I try to follow the CO-RE principle, it seems like I should be
> > using the CO-RE-enabled variants instead.
> >
> > I did some experiments and found out that it is the
> > bpf_probe_read_kernel part of the CO-RE-enabled PT_REGS macros that
> > change the results and not __builtin_preserve_access_index. But I
> > still don't get why exactly it changes the results.
> >
>
> Can you provide the exact usage of the BPF CO-RE macros that isn't
> working, and the equivalent non-CO-RE version that is? Also if you

As a minimal example, I wrote the following little BPF program which
prints instruction pointers obtained with non-CO-RE and CO-RE macros:

volatile const pid_t target_pid;

SEC("perf_event")
int do_test(struct bpf_perf_event_data *ctx) {
    pid_t pid =3D bpf_get_current_pid_tgid();
    if (pid !=3D target_pid) return 0;

    unsigned long p =3D PT_REGS_IP(&ctx->regs);
    unsigned long p_core =3D PT_REGS_IP_CORE(&ctx->regs);
    bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);

    return 0;
}

From user space, I set the target PID and attach the program to CPU
clock perf events (error checking and cleanup omitted for brevity):

int main(int argc, char *argv[]) {
    // Load the program also setting the target PID
    struct test_program_bpf *skel =3D test_program_bpf__open();
    skel->rodata->target_pid =3D (pid_t) strtol(argv[1], NULL, 10);
    test_program_bpf__load(skel);

    // Attach to perf events
    struct perf_event_attr attr =3D {
        .type =3D PERF_TYPE_SOFTWARE,
        .size =3D sizeof(struct perf_event_attr),
        .config =3D PERF_COUNT_SW_CPU_CLOCK,
        .sample_freq =3D 1,
        .freq =3D true
    };
    for (int cpu_i =3D 0; cpu_i < libbpf_num_possible_cpus(); cpu_i++) {
        int perf_fd =3D syscall(SYS_perf_event_open, &attr, -1, cpu_i, -1, =
0);
        bpf_program__attach_perf_event(skel->progs.do_test, perf_fd);
    }

    // Wait for Ctrl-C
    pause();
    return 0;
}

As an experiment, I launched a simple C program with an endless loop
in main and started the BPF program above with its target PID set to
the PID of this simple C program. Then by checking the virtual memory
mapped for the C program (with "cat /proc/<PID>/maps"), I found out
that its .text section got mapped into 55ca2577b000-55ca2577c000
address space. When I checked the output of the BPF program, I got
"non-CO-RE: 55ca2577b131, CO-RE: ffffa58810527e48". As you can see,
the non-CO-RE result maps into the .text section of the launched C
program (as it should since this is the value of the instruction
pointer), while the CO-RE result does not.

Alternatively, if I replace PT_REGS_IP and PT_REGS_IP_CORE with the
equivalents for the stack pointer (PT_REGS_SP and PT_REGS_SP_CORE), I
get results that correspond to the stack address space from the
non-CO-RE macro, but I always get 0 from the CO-RE macro.

> can provide details on the platform you're running on that will
> help narrow down the issue. Thanks!

Sure. I'm running Ubuntu 22.04.1, kernel version 5.19.0-46-generic,
the architecture is x86_64, clang 14.0.0 is used to compile BPF
programs with flags -g -O2 -D__TARGET_ARCH_x86.

Thanks,
Timofei

>
> Alan
>
> > Thank you in advance,
> > Timofei
> >

