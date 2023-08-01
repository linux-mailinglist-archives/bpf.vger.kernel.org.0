Return-Path: <bpf+bounces-6509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2853276A6EC
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 04:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624C51C20B5B
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C074A32;
	Tue,  1 Aug 2023 02:24:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237997E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 02:24:39 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D9410DD;
	Mon, 31 Jul 2023 19:24:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so18920671fa.1;
        Mon, 31 Jul 2023 19:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690856677; x=1691461477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEFUKD1oOLxuyQDAxx7RR3dAdD2sHSuaqVKiyetEloM=;
        b=GcK+h3AjyXR7hVkxk3FIQ3Yawy76QVp0nMle6Dvzcp+1LoiywylOnsCB4zHcbweJkb
         uk6LBWKFjgYxeTQBmALucKLbvIijuYKEpdAIbDol3OMsnATWdH3QXLRGu59YOmxu/GIR
         U2hG1Mg/IgZMegtUzBAhK3dUI41P9p/agZsrAGGRo67UMEICDZb5fvQSEo/oZK7S7q5e
         VVrap1OSC5gDL3tOubh25U7Ci+0QYS+f1fFv/5wB5BjwszZRFcqehOsfmuHXISa5FYfa
         ciCLO019ebPGKWw9d24heHZLfRDZ/ynF1lF5RZlT9+oUCTya2aQ+mF5LGGcJkLzd3gqZ
         cEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690856677; x=1691461477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEFUKD1oOLxuyQDAxx7RR3dAdD2sHSuaqVKiyetEloM=;
        b=IarF7BdV0SE2hIz+3dZOaI+rrPcZCcZNGWCT3/nvTBk2A6HlHfL4JF4opnurC5+FTo
         N0QiKHHdxlsKmB1Vt53hUCkTiuF5+BmFcmtci/qbs8eXhYNfoK7dXlOf06cFhYfYBtnH
         dPaMLgekeOYz2lVXIompBkfOHp7OW++hHn++KG2zP9q7Hc2T0HXiCI1mSb5ao6xuiNSq
         J96AgnAxq+0z/qPA3yn9W/07Fs/PzmAQp2U4SLHbzXZnr2rRHMdQsIBa2nzbDwAOsu/4
         dDksBYtCY/rUALUuE1rxSKaHKlB5NPxww8pgi1BEaxTJgxIxtsTAIsy8Wo0iOgAQaHmq
         ryVg==
X-Gm-Message-State: ABy/qLYuV0qA0ad3FFz1bVEWqhJ3SIuyaCpeA2Lk9Zc6QkVDfneBxlBM
	t+M4hjZ4ts2yZRpllQRv0Lx0t8CoUf9MNPpQyPY=
X-Google-Smtp-Source: APBJJlHgH3QJP2KHdlcqyNp44pjlSvJl7W1H2iiG5A8JZOhRbhjA3faILEXJ90An4ZJqQ3lKXPvSahkz+35hUzNYaZY=
X-Received: by 2002:a2e:87cb:0:b0:2b5:9d78:213e with SMTP id
 v11-20020a2e87cb000000b002b59d78213emr1286950ljj.22.1690856676546; Mon, 31
 Jul 2023 19:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230731211527.3bde484d@gandalf.local.home>
In-Reply-To: <20230731211527.3bde484d@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Jul 2023 19:24:25 -0700
Message-ID: <CAADnVQJz41QgpFHr3k0pndjHZ8ragH--=C_bYxrzitj7bN3bbg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 6:15=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 31 Jul 2023 14:59:47 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Assuming that is addressed. How do we merge the series?
> > The first 3 patches have serious conflicts with bpf trees.
> >
> > Maybe send the first 3 with extra selftest for above recursion
> > targeting bpf-next then we can have a merge commit that Steven can pull
> > into tracing?
>
> Would it be possible to do this by basing it off of one of Linus's tags,
> and doing the merge and conflict resolution in your tree before it gets t=
o
> Linus?
>
> That way we can pull in that clean branch without having to pull in
> anything else from BPF. I believe Linus prefers this over having tracing
> having extra changes from BPF that are not yet in his tree. We only need
> these particular changes, we shouldn't be pulling in anything specific fo=
r
> BPF, as I believe that will cause issues on Linus's side.

We can try, but I suspect git tricks won't do it.
Masami's changes depend on patches for kernel/bpf/btf.c that
are already in bpf-next, so git would have to follow all commits
that touch this file. I don't think git is smart enough to
thread the needle and split the commit into files. If one commit touches
btf.c and something else that whole commit becomes a dependency
that pulls another commit with all files touched by
the previous commit and so on.
tbh for this set, the easiest for everyone, is to land the whole thing
through bpf-next, since there are no conflicts on fprobe side.

