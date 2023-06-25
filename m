Return-Path: <bpf+bounces-3402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B473D181
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C41280FDE
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E924613D;
	Sun, 25 Jun 2023 14:33:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99020F4
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:33:17 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4F11A;
	Sun, 25 Jun 2023 07:33:16 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-62fff19e8fdso16230776d6.1;
        Sun, 25 Jun 2023 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703595; x=1690295595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AH6aGEIJ/M0kCk++IHrMsAmXAQFXLs8+wl2scd1PTE=;
        b=hF+B03F5e0d4Xfa97/fClhINCvbNqQYvPAnFyEvZgS7oWD5WA4MuEON3k7cHVQGJ56
         j9HsSDQrGlpW1rvq6M2JpdrI9sm9gBCQ2LunK0KeIU66pYIH9t0bgNwWlpGQhfRLLpp+
         eN7iZapl2M1k85D0Nuw6h7InQMbx2LgqM12jRv4sWzuNfkID3IsLWrnc4ShkI5Qs69An
         WsR3Oot9cglSOTzod5pOhfAs5X1C9HVLjaaTYvOYz49UYWycsN5Hh/uTMB41PqyiOfuG
         K02KeYj4PpEVJhwcxFcgQiDsPNBWUIak8vbNzWLJYYf5wgRqfhdw5U5ru9hlAC87SGSn
         oxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703595; x=1690295595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AH6aGEIJ/M0kCk++IHrMsAmXAQFXLs8+wl2scd1PTE=;
        b=A7z1Msfyysjc2r9fONoLu+sIWl/Xc+zWLoviqkMALS4q0efCjme+6K7US8etYNJQNy
         cvQLpdIq9lBqe75JZNkQDe/2fq3HU2LLoD16NPgFRhJbnD0I8mmWpeSy0LuIaIdNPAnp
         VJ+yCwNiWp0UeFjmuGmfLSvb7tdN1asNKbP48DgqqQ+yMbrfY6zBaUBwm4ybMgPxO0FL
         WZL5AFu5KG3UG3Yf94cRvB85ytig/edYP76kVxmTnc1NhIS7eZ89FQpBF8+vB09pZzPi
         fxm/JA6qjJ+xjTgXp0q27TnML2ZQIT18xdnJsXxNZcB4XaYCt1v9CocNEVaTLzg/zgl1
         fxxQ==
X-Gm-Message-State: AC+VfDwA/dQK3bh2H5pNQ9A/GW5lJtkB++ccLlrX6RdJA63xfOGrLLk+
	6YdUUwuWG6mj/vMON/Q9cJoMuVnDZX5fWLB2nas=
X-Google-Smtp-Source: ACHHUZ5cxvavhVh8EdBzue2JzIbmSu9cSvkd99p0WXOSfgz7ZBDsGz2kwVl9l4+DydokyFTRFSkSMtz5NZ1SaIq3Td8=
X-Received: by 2002:a05:6214:2a8f:b0:630:14e0:982e with SMTP id
 jr15-20020a0562142a8f00b0063014e0982emr22585890qvb.22.1687703595647; Sun, 25
 Jun 2023 07:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-12-laoar.shao@gmail.com>
 <CAADnVQL5b+qnKc74bqi1UJ+PXjE81ZvATDEJJcsjV=1UDaSpdg@mail.gmail.com>
In-Reply-To: <CAADnVQL5b+qnKc74bqi1UJ+PXjE81ZvATDEJJcsjV=1UDaSpdg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Jun 2023 22:32:39 +0800
Message-ID: <CALOAHbAaxYcFOUYRGAaJgvMK=fLpziWLp-ynoUmZ-HY-avx+4A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 11/11] bpftool: Show perf link info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 1:14=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 23, 2023 at 7:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >         pids uprobe(27503)
> > 6: perf_event  prog 31
> ...
> >         pids kprobe(27777)
> > 7: perf_event  prog 30
> ...
> >         pids kprobe(27777)
> > 8: perf_event  prog 37
> >         tracepoint sched_switch
> >         bpf_cookie 0
> >         pids tracepoint(28036)
>
> uprobe/kprobe/tracepoint are really the names of your user space applicat=
ions?

Yes, they are my test applications. I just named them that way for an
easy test :)

>
> or something broke in bpftool that it doesn't show comm correctly?



--=20
Regards
Yafang

