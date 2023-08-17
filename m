Return-Path: <bpf+bounces-7975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82F77F297
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09621C212FD
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA8E10786;
	Thu, 17 Aug 2023 08:58:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB5100A5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:58:09 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA51210E
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:58:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc83a96067so47993695ad.0
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262688; x=1692867488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crlYGKquqF5t5yJzuYzOspJUZ1j4poI8LPHia0IINUw=;
        b=DksOOuTp1UVrleiR8CEK0iz/auSb6d/LPavN/30BDmNJ0cdz7LS99xeIxjET/PJ41X
         h81Ebion1q7krwAQiA51IC+KPYAqix6+FMf3GyFu87M3wpXcLnJ/nLO4LuaIACrnECZC
         CQtdKis22ego1txUw9OgYHzv9B7tY+JdrfxRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262688; x=1692867488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crlYGKquqF5t5yJzuYzOspJUZ1j4poI8LPHia0IINUw=;
        b=ghR/RsicgksonY6xAd9LyuGy//IWuVAaJGUCzDWlHQUhsyPQ4TZL770PwUA6OcVoh5
         MYa6sZgI1nrN6jGscB5HembJhqo6oDkifzXRhP+V8LwTv7wSRC2bA3Q9tpUY9OUYUhQi
         4iYrJqz+pzWqJtXhkfwzACciyBNjTidXXW8y/1o1voaGymNY2yhiPwyh+dDeEnH618xb
         JVIFlbZfpVsrTU+UUoVgJCh+6eZfnNob9dC89e4afuAKJW0lvla+V4AdLJLq1x8OeVo/
         SVY4/0b0kQQU9cZuR7xmFNS2I6gRCdf1royo8eI5uB4gXwsxsGITszTgp6msHpbSRfWj
         D9Yw==
X-Gm-Message-State: AOJu0Yzxif9+rr4ygP+jsIz27Y4XKJ7NeVyv/Y/DZZM5AUxhIvB90WfW
	3KKE4Z07AdyoOcGjKg2DnGfZs4AtMbfQbVJhObqF7g==
X-Google-Smtp-Source: AGHT+IHPdZNMxsM5+V5vX1EyN/E9ZUkGEZfEzPzHjovvpTHCp44OCZVb5aKpzX0DMTkIEr47E1RrBt56OImd/BKdS3c=
X-Received: by 2002:a17:90b:4391:b0:268:c7fc:b771 with SMTP id
 in17-20020a17090b439100b00268c7fcb771mr3404103pjb.14.1692262688334; Thu, 17
 Aug 2023 01:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181867839.505132.10717747708330472036.stgit@devnote2>
In-Reply-To: <169181867839.505132.10717747708330472036.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Thu, 17 Aug 2023 10:57:57 +0200
Message-ID: <CABRcYmLxL=F3xuNKV12oPt_aHoLM8gDLeAxMeVQsk-iuXi2mSw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] bpf: Enable kprobe_multi feature if CONFIG_FPROBE
 is enabled
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 7:38=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
> converted from ftrace_regs by ftrace_partial_regs(), thus some registers
> may always returns 0. But it should be enough for function entry (access
> arguments) and exit (access return value).
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>

