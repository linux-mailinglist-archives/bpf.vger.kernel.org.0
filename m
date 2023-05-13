Return-Path: <bpf+bounces-465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E770158F
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 11:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74C6281B46
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863031391;
	Sat, 13 May 2023 09:19:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FF137B
	for <bpf@vger.kernel.org>; Sat, 13 May 2023 09:19:47 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C4A35AD;
	Sat, 13 May 2023 02:19:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so19049701a12.1;
        Sat, 13 May 2023 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683969584; x=1686561584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/ffD06cwDqqYw9ZZG01Fo5tfB2NmW+1D8qbzBkTPeA=;
        b=LmwSMi02wUb7imyTUGCdjBF3bcsZMsz0W7Y+n+AgTjFQ2omGRi0diD5jOswF3DmkgR
         O5yJygYBDy4gGsW18EBQEtG64HsubWz+WnQlkK4jzdtMSbGcH5qTyf0BUB9ZhwhJxGth
         Y2XQRrK3Th+PRjNhtggJLt8UNEn60p9KNqG3YjPUewtgcfKnXl4Z7n2YA6V23b+P3LZ4
         vEaxEmAscJsu41kUQWtUbI17SKsWL9LSK07xuhO9yWrmJkTyUL164RsPcU0o8+PGQMK6
         6T2GjcPICWuHoaJXMgHSiS6q94qCUv9hRTEfxE/iDLPjL/LvGhqySUCc2XWvUgHb2qBs
         C/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969584; x=1686561584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/ffD06cwDqqYw9ZZG01Fo5tfB2NmW+1D8qbzBkTPeA=;
        b=YcfQr0ZSjpeEQjr3qCAUKK87VqI+gP2StL7TCNyVEtKp6i+3CnWj8YSITZbfIE3jn/
         Yi+bX1TjCXlkl3kymEXjXcCuYjcwa5OM10ACgnSS0CL+j3nIPqwdsRRmrnOmsyXOc5Sp
         HFn0gWSjZwsnjmNPYtVTgXkuUM1T+JqrGrNn58yl712HlAH1T7+lvz9o7qbI4q4J2Zxq
         LAIlohwF102OiNc2JgAdyEPNKGwcJ9gwR96/5NZhtk2LFudsviOweRMivbhSlayWbvWi
         HhJtacAQ4BkjBn667oatC5w9ILfVMOhpsCZneQ8UYeUt8ikkEs0DXjJI/WtmvCrXFjjg
         y76w==
X-Gm-Message-State: AC+VfDwe5votAg5Jxx44AY4JQZ5wf+Vcehbu/8SwSS9S26tKJmql4nXg
	UFQxeAqlSsyr1qz8R5COsxLjRgA6FpMDAgDcTLWOCA+vWSssqQ==
X-Google-Smtp-Source: ACHHUZ7DaW4VctCEmtrHbde+hfICyYiY0rVh/EkpovE1xbD08Yhm4ZkW6TZILWDyHTadFqYDWa70SgLN6pjyi7tuWP0=
X-Received: by 2002:a05:6402:605:b0:50d:91c8:9e10 with SMTP id
 n5-20020a056402060500b0050d91c89e10mr20037487edv.10.1683969584084; Sat, 13
 May 2023 02:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510122045.2259-1-zegao@tencent.com> <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
 <ZFvUH+p0ebcgnwEg@krava> <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
 <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com> <20230513001757.75ae0d1b@rorschach.local.home>
In-Reply-To: <20230513001757.75ae0d1b@rorschach.local.home>
From: Ze Gao <zegao2021@gmail.com>
Date: Sat, 13 May 2023 17:19:32 +0800
Message-ID: <CAD8CoPBYfAyb6FtQ8KsqO-f4jfsYXoqe9heWcQkFprX=TQ50PA@mail.gmail.com>
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yonghong Song <yhs@meta.com>, Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Exactly, and rethook_trampoline_handler suffers the same problem.

And I've posted two patches for kprobe and rethook by using the
notrace verison of preempt_
{disable, enable} to fix fprobe+rethook.
[1] https://lore.kernel.org/all/20230513081656.375846-1-zegao@tencent.com/T=
/#u
[2] https://lore.kernel.org/all/20230513090548.376522-1-zegao@tencent.com/T=
/#u

Even worse, bpf callback introduces more such use cases, which is
typically organized as follows
to guard the lifetime of bpf related resources ( per-cpu access or trampoli=
ne).

migrate_disable()
rcu_read_lock()
...
bpf_prog_run()
...
rcu_read_unlock()
migrate_enable().

But this may need to introduce fprobe_blacklist and
bpf_kprobe_blacklist to solve such bugs at all,
just like what Jiri and Yonghong suggested. Since bpf kprobe works on
a different (higher and
constrained) level than fprobe and ftrace and we cannot blindly mark
functions (migrate_disable,
__rcu_read_lock, etc.) used in tracer callbacks from external
subsystems in case of semantic breakage.
And I will try to implement these ideas later.

Thanks,
Ze

On Sat, May 13, 2023 at 12:18=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 12 May 2023 07:29:02 -0700
> Yonghong Song <yhs@meta.com> wrote:
>
> > A fprobe_blacklist might make sense indeed as fprobe and kprobe are
> > quite different... Thanks for working on this.
>
> Hmm, I think I see the problem:
>
> fprobe_kprobe_handler() {
>    kprobe_busy_begin() {
>       preempt_disable() {
>          preempt_count_add() {  <-- trace
>             fprobe_kprobe_handler() {
>                 [ wash, rinse, repeat, CRASH!!! ]
>
> Either the kprobe_busy_begin() needs to use preempt_disable_notrace()
> versions, or fprobe_kprobe_handle() needs a
> ftrace_test_recursion_trylock() call.
>
> -- Steve

