Return-Path: <bpf+bounces-8640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B19788CFC
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE7E28172D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9B1772F;
	Fri, 25 Aug 2023 16:12:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C12571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:12:07 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377C1FD0
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-565e395e7a6so526571a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979925; x=1693584725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8MLhs3IfeRC8yy9z6+Fa7fpyQgi8tcq6XmRwm/8Nn8=;
        b=BB6WxysYDMEr2xwwK59SBU99pmVr1e5MTAkEqlZGzqL2kXzO4tGtCYBA/dXHM5/49Y
         oHvyi4wrljHIncqRzGD9VACZ0xiPgcVa7ker+oxni2UKE57XTU+Wui8/R6Yeq31Hf1zu
         aujLXiNJyl/OQ5rIarFbSvoPWbCyeoq19phfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979925; x=1693584725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8MLhs3IfeRC8yy9z6+Fa7fpyQgi8tcq6XmRwm/8Nn8=;
        b=ge1F9e0EPJgaD2UuPEnbkvPlluFAgZW0ppcrA6NC3Pax8F18cEIPAZpIkLvF0YvMza
         exa0n2NfT/5Xs+OgoLfhBnX9U0j1tZ+9GJcbujvpYZ5t6LGKGosng031JGH+7xWj5nAk
         V5q3TlwzixPS3XiJudpqcqR+UXh7t4mKSq7v6HJJ+AQe98+xV8qRUvWUmx6rw/EE7yoz
         OmwRikAszv5rpaXFUaM0TAOIZ6b4UfZPq9pbkup6w/7+/5Gg/EnVHNcXKHOb0v9LkxFf
         j2HCpnmrnSNB3nwXc61XTQaq5rz2SVls4euBwmCx/DEEYeV+yRcn/h+ChWVXh/JPCrgF
         2ryA==
X-Gm-Message-State: AOJu0YzWvtBPLNQyGj1FRE+99QMpWuby768zF/VJeKIovRPyRGuozhf4
	5G9YIShJqJcv3va2OYS8n6MbFpEsKfTQafrJLs2Zkg==
X-Google-Smtp-Source: AGHT+IET8rQZ5xah8Zdkmp/PwyqZ2Z7qh9Vx9+xr62A4BxIguP08Fq+SgE93rxtJ2HmVHbjTMXJjf0sNSYxDm+i2j8o=
X-Received: by 2002:a17:90a:fd14:b0:26d:ae3:f6a7 with SMTP id
 cv20-20020a17090afd1400b0026d0ae3f6a7mr15511414pjb.21.1692979925072; Fri, 25
 Aug 2023 09:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280373992.282662.14835192462715188987.stgit@devnote2>
In-Reply-To: <169280373992.282662.14835192462715188987.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Fri, 25 Aug 2023 18:11:53 +0200
Message-ID: <CABRcYmKCd4iW8Yk0Z5p2H2HNpnbuuegZRA5BC_OekuPan25wfA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] Documentation: probes: Add a new ret_ip callback parameter
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 5:15=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add a new ret_ip callback parameter description.
>
> Fixes: cb16330d1274 ("fprobe: Pass return address to the handlers")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>

