Return-Path: <bpf+bounces-498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2C7023FB
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 08:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86112810CC
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03174699;
	Mon, 15 May 2023 06:00:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E01FC8
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:00:14 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E412D41;
	Sun, 14 May 2023 23:00:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so22492455a12.0;
        Sun, 14 May 2023 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684130411; x=1686722411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWJZN0AxnMLj8Z4KaxYfGt0FY36qubWQkKlCweV20LE=;
        b=iKjTvLOaLIAQInv4Zg3BQl2vPIyVFhi3CpcLEmlrMGBMoqotkbBGotUeAdfq21fElc
         cy/xMPodX7Gzzg1tBArbJcBknuUJ1HSw/3aqtfOO8R7DPQ8RJTLgnpxXyYhfxWd+zscU
         w0bmdI7FYW8O+e6RwW3bylQil94PcQ6lDb0Xc7KCrXCXraOs08V313MQmwhDBdnw7b0D
         t2jeED38yEr3U0W2Jfy6fSbtsCWW1YhGM6jxcOjAqQOMWw8KJpGFSxbPqdP4NrJN0OCv
         yyRiVX/WJFFmUChE/F6w4x8K6n3qxFApsZxtSAYsjc+mF8WoZ9Ap+0GJru6DYRta7Syk
         zhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684130411; x=1686722411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWJZN0AxnMLj8Z4KaxYfGt0FY36qubWQkKlCweV20LE=;
        b=UjBwIhlwUi5DhBtXeWZCUUZ+UEkYJIpT4FgKhcGJgSPxDUDvTg6VobATjDTW5O59ap
         lT2NxBf+fINzpt7qgan6EJupJot/EaFwTQv4CCMrhf5z/KfeZHK5Lc5UBE0WuJUNED33
         S+TWZnLyEA6P1z4J5YvHuAtG4F54swIA1euYqcuj+O+a7JodIKBc9SqKkvzKdgz9MsfF
         fmyGGM/8X3HOgjDklGyjGczdGqkhggLgr9cfZLXE0uLUF5m9sAUY+I3imvhLM0dOLDmy
         RTkCcL2IKj6JqTb5c2u4xXvH4fxFi0YHxgSTjENlBK6OhBUXQE2aEpJ1a4JGHXSw3Dxz
         0UnA==
X-Gm-Message-State: AC+VfDyxb/JOdOgsr927K8/p59r7pg4/OKFh8DPedXuIOiXgw21QSti2
	kZfHNGZ2ynD76h3UjyeDVLJfvKRq2CwuqBqj2I0=
X-Google-Smtp-Source: ACHHUZ428Sh5bSg84RYNX+ILZH5/eZRrfIEPJc5zLusPZ0jIaVj393VeEHUomPxsyyo61gVIkyWMBWrJD7tI0NjcfMo=
X-Received: by 2002:aa7:c747:0:b0:50b:fb49:c4a8 with SMTP id
 c7-20020aa7c747000000b0050bfb49c4a8mr25276264eds.27.1684130410646; Sun, 14
 May 2023 23:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510122045.2259-1-zegao@tencent.com> <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
 <CAD8CoPBBipQWP0xT5unAshL93OtXLQox_rz0f7rfrGgy05UVJg@mail.gmail.com>
In-Reply-To: <CAD8CoPBBipQWP0xT5unAshL93OtXLQox_rz0f7rfrGgy05UVJg@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Mon, 15 May 2023 13:59:59 +0800
Message-ID: <CAD8CoPCfPmqZH6BJCk3Y1-02BLVVsbQ6OeaNOhcfGWmdF0oX8A@mail.gmail.com>
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
To: Yonghong Song <yhs@meta.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
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

Dear all,

On Thu, May 11, 2023 at 9:06=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote:
>
> I'm afraid filtering in user space tools is not enough, cause it's a kern=
el BUG.
>
> it would 100% trigger a kernel crash if you run cmd like
>
> retsnoop -e 'pick_next_task_fair' -a ':kernel/sched/*.c' -vvv
>
> which is caused by that BPF_LINK_TYPE_KPROBE_MULTI accidentally
> attaches bpf progs
> to preempt_count_{add, sub}, which in turn triggers stackoverflow
> because the handler itself
> calls those functions.

I managed to see the big picture of this problem by digging into the code.

here is what it goes:

rethook_trampoline_handler{
   preempt_disable() {
      preempt_count_add() {  <-- trace
          fprobe_handler() {
            ftrace_test_recursion_trylock
            ...
            ftrace_test_recursion_unlock    <- it fails to detect the
recursion caused by rethook (rethook_trampoline_handler precisely for
this case)  routines.
          }
          ...
          rethook_trampoline_handler {
          [ wash, rinse, repeat, CRASH!!! ]

There are some pitfalls here:
1.  fprobe exit callback should be guarded by ftrace recursion check
as well since user might call any traceable functions
just like kprobe_multi_link_prog_run calls migrate_{disable, enable}.
In this case,  detection in fprobe_handler only is not
enough.
2. rethook_trampoline_handler should use preempt_{disable,
enable}_notrace instead because it's beyond recursion-free
region guarded like 1
3. many rethook helper functions are also used outside the
recursion-free regions and therefore they should be marked
notrace

I've post a new series of patches to resolve cases mentioned above:
  [Link]: https://lkml.org/lkml/2023/5/14/452

In theory, bpf_kprobe as the user of fprobe+ rethook, is spared from
suffering recursion again by applying these. And
  [Link]: https://lore.kernel.org/all/20230513090548.376522-1-zegao@tencent=
.com/T/#u
becomes optional.

That leaves one final question, whether we need probe blacklist or
bpf_kprobe blacklist depends on how we deal with
user requests if one of its expected hook points fails because of
recursion detected. Do we need to reject them in the first place
by blacklist or  let it fail to execute the callback silently, which
needs your gentle advice.

Regards,
Ze

