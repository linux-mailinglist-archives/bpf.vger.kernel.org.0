Return-Path: <bpf+bounces-4643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644C74E051
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34D7281401
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 21:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38C16411;
	Mon, 10 Jul 2023 21:36:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563A14AB4
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:36:54 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F0F4;
	Mon, 10 Jul 2023 14:36:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e4c868ee4so3356914a12.0;
        Mon, 10 Jul 2023 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689025012; x=1691617012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPHLwCYSrzehX+poMBnyQydgb702LDDTYd8W73ZnNTE=;
        b=drwfvugvpq5SG1Mzzkv8dvjVvQuxZuyWFoNqKsyLCJyYVJoEeOHFj5Z6qgaZcUcXBi
         Xfb/wgI2+Jf3kQ82qzvmH1ogZMj3Qcyubf1/0LkmpBiH8UXZ63UOumxrcXM1R+C/EnAQ
         DNyzPrk3KEbAkISce+h7Pk7HZMoffBJsArMSEbe0e87t7TsqHZM5nbkQqeLf6S6qzBmO
         mCpsUQu+hmpoS5A2zv4mpMp5hYXAlBGglVT9m8JfnvwwiFCrnYlnwhbQcVs66ADq1j2Q
         JONNGu3OZxa7uZm5ylgsV44zjtjTW8MvGcG/oy+HCGL66MYirwKjShH+9F8MAhFCABrS
         unfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689025012; x=1691617012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPHLwCYSrzehX+poMBnyQydgb702LDDTYd8W73ZnNTE=;
        b=dX9J2btNwilVxz4Nlq+ki3gqrtLzmgcyyLhGMqkFF98aC+Lbw5xIih0U3ebdVGMxHM
         vexQEF1kt35gW/JhQ/Yes+BPXjAtLU4Qlg9byeJBGaRU4GaUtFn9wfC8FMb+6++fbEuA
         TrQ3O6oqJsBK2uFdWMGggchK+Sw0s2JERcM7vf3VpgOPIosNZErg19sGZdtNSuizi6UH
         ItetsYyfViHs8XMH5cVWDW2TKDDYZvJ0vQnJ4K7Ew80NtkR0gFzYToTkwuGpp3fvgL5M
         BIcxW6R6TEzRuwv9hdlGsqXIWNJYSY5T1Qv71wYYrup0thZHK8eX2j9BarTbWnB/KZV2
         0wlw==
X-Gm-Message-State: ABy/qLZ55PFNfvPpAfdtZyPpmkwG7Ln/N2f59ilTgqEhb3//l0rox3QD
	laEctBjSSRQc6jGdYfysQ9hzmYjRX6s93s7R0s4=
X-Google-Smtp-Source: APBJJlE4s1l1x+VII7uSBaO+SFsR7XDvpab0BU22qp+Rpa87o/Qc5GXhXuccu11ijfq6NMJjBjjj2cExjhlHnDRRX70=
X-Received: by 2002:aa7:c654:0:b0:51e:1af0:3a90 with SMTP id
 z20-20020aa7c654000000b0051e1af03a90mr12744434edr.37.1689025011946; Mon, 10
 Jul 2023 14:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com> <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
In-Reply-To: <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Jul 2023 14:36:39 -0700
Message-ID: <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: andrii@kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 9, 2023 at 9:05=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> On 08-Jul-23 4:46 AM, Andrii Nakryiko wrote:
> > On Wed, Jul 5, 2023 at 9:39=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd=
.com> wrote:
> >>
> >> Hi Andrii,
> >>
> >> I'm seeing perf test failure because of commit d6e6286a12e7 ("libbpf:
> >> disassociate section handler on explicit bpf_program__set_type() call"=
).
> >>
> >
> > Yep, this commit would reset catch-all custom handler, which perf is
> > setting. I've just sent a fix upstream ([0]). And once it lands, I'll
> > cut a v1.2.1 libbpf bugfix release with just this fix on top of v1.2.
> >
> > Can you please double-check that this patch indeed fixes the issue for
> > you? I tried to do this locally, but for me perf test 42 fails both at
> > current bpf-next, with the above commit reverted, and with my fix
> > applied on top. So I can't be 100% sure.
> >
> > Thanks!
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/patch/202307072311=
56.1711948-1-andrii@kernel.org/
>
> Thanks. A quick test seems to be working fine.

Alright, thanks for confirming! I've just released v1.2.1 bug fix
release with just this fix on top of v1.2.

Thanks for reporting!

But given v1.2 was cut on May 1st, and the offending commit landed
some time late March, I wonder how did this slip through the cracks
and go unreported for so long? Is there something we can do to catch
these perf-only regressions a bit sooner?


>
> Ravi

