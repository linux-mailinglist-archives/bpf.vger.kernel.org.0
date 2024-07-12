Return-Path: <bpf+bounces-34679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB2C930100
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB8B2842FD
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FB381A4;
	Fri, 12 Jul 2024 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMYT0Kxr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE56BE65;
	Fri, 12 Jul 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813122; cv=none; b=INv27WakXI3zml9km7anERbRLzp9oe3h7edwMwVFmgL4xLlwOfMEIn/YxdYGB6FEUlPGjh3Eh+XbxaB+N2W0WyHjVAnL80pBww1Q4QQE+O3exDjGd+tle70y3b2oihIeUf/YMkXnT5vpCOYeY8Cc22M9MWd3uZt5jmDj30kN7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813122; c=relaxed/simple;
	bh=eU80/SHzM9zfUD2s2UKYMH3sX2bKdh9zL0swUl003EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/XQ1FcP++W8K9Fy7L0rokDpOExFeuTAjubb5xsQWYI4g4WYjIp4c+Th1Vqtk3VyHBBvt1fv7zlSDlFFMVW5w6FhMG3BsHN5lYrXgBoeTXqMSBhvzEnJF4TVrF0fU+Zl3smYAWScznFts93XTZiSh14YS/WaCFlTvTX9EPvCO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMYT0Kxr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-77d3f00778cso1776288a12.3;
        Fri, 12 Jul 2024 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720813120; x=1721417920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmnmy4k0ZE5aqRykzl3xnNbgqOchAuqitUDaQSLA3rE=;
        b=FMYT0KxrE3YqF7Yc17phStl7k3+0K4YihiLGPsC8sacRZHRwseLxFj+g8drLkFnAcb
         lO9bfbfJCclJXX+xVLLDg8YttUg7C02nKAekCRgQ+9KLxLWfdW7ljk0Kcm8tvtCuMEFx
         2MWr8j+Ud28BSn9T+IYYiwoBH4pRzFtwVjNPTJdY7mw8rO2FeMI/SvmRu2h89bsWGe+V
         WNOWm9gVQGysn7gAUAyEVc+NERzWELFr8LLL4mCRJlRrPHbqamQT+Mww0rUIxqJqIkgh
         sC1VnUP+WmNCWVyZlvIQJmLL+uTTSicSpE+vZxpcHc+V5Fj8oJ2bZH26VK4ARZwGpZ4i
         cypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720813120; x=1721417920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmnmy4k0ZE5aqRykzl3xnNbgqOchAuqitUDaQSLA3rE=;
        b=xLCFWjEBl24YW6QDZn+gH2KD7xihdK4ndeyuU1jFcz1fU6fuE6CK3D+8AiGun36Ghq
         4c+i4hWysHdWU+/TrBXnMH2Hk1ynazjzbiceFcXRxYZPNDF5D7BtJThusASQp9I7eYuV
         cH52iRgrh5UyudU+ekdf8/+DH8m/dw4fP4/d02wj3BwXEq9d5ntsjrKHvrhBZnk6i9Yp
         X4WEQ9uJqrzCyKgvgBzVILRxb9KAAzizXIaDiaaNqKA/heaZA+shmh2YT4NFBiUSIYrn
         L3WZBAAfKlZZuK/O+Byh8+dklkX4ZX2g1vp2OySOuyZanIBn7w2g9b0PDPn+ufsshYev
         e1HA==
X-Forwarded-Encrypted: i=1; AJvYcCWqzSXr1fZ5j+ovISdTNoLFVyYL+yjI6dJ+NWJhd4/Qzlzd6TKsAI6a9lREWEBgBSBEPuAAXY/VKL6Sg34kBWb4j6+IHxE/YnGnfwvfYjuXgU0FLoGmchANAtYYwruLsMDnD7A1pmU553cql1qeWmjG0KZdSAOiHZhAVHPzDBg0
X-Gm-Message-State: AOJu0YxMuGtQVy/FyERl21l3Bc6otXB7NmMkwaSoSZ2jbHRyv4L7LOIg
	zKq29saW7oJS+229hongnSekjyY9G4kJ3czYKzutacRXfyWtSCsj058e5GXvxAHgwNDGYD5jWa9
	9avExL2bdX8Lh4/DrwM4TtK6mSrk=
X-Google-Smtp-Source: AGHT+IEkYnIKZnwHEfRtBSBINEAoGjGPp7B+wrUPdkTTmh+byt4UPf2Fue9+13vnLFXEZOMLaAdMdmDHRfcvVg/F0yY=
X-Received: by 2002:a17:90b:1e42:b0:2c8:6118:11a8 with SMTP id
 98e67ed59e1d1-2ca35d90dc7mr9306588a91.49.1720813120419; Fri, 12 Jul 2024
 12:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709204203.1481851-1-briannorris@chromium.org> <20240709204203.1481851-4-briannorris@chromium.org>
In-Reply-To: <20240709204203.1481851-4-briannorris@chromium.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 12:38:28 -0700
Message-ID: <CAEf4Bzb6-DLL966XKyMhe+nmpvdqYVrzfmfkAiDdFHNyD0qGWw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tools build: Correct bpf fixdep dependencies
To: Brian Norris <briannorris@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 1:43=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> The dependencies in tools/lib/bpf/Makefile are incorrect. Before we
> recurse to build $(BPF_IN_STATIC), we need to build its 'fixdep'
> executable.
>
> I can't use the usual shortcut from Makefile.include:
>
>   <target>: <sources> fixdep
>
> because its 'fixdep' target relies on $(OUTPUT), and $(OUTPUT) differs
> in the parent 'make' versus the child 'make' -- so I imitate it via
> open-coding.
>
> I tweak a few $(MAKE) invocations while I'm at it, because
> 1. I'm adding a new recursive make; and
> 2. these recursive 'make's print spurious lines about files that are "up
>    to date" (which isn't normally a feature in Kbuild subtargets) or
>    "jobserver not available" (see [1])
>
> I also need to tweak the assignment of the OUTPUT variable, so that
> relative path builds work. For example, for 'make tools/lib/bpf', OUTPUT
> is unset, and is usually treated as "cwd" -- but recursive make will
> change cwd and so OUTPUT has a new meaning. For consistency, I ensure
> OUTPUT is always an absolute path.
>
> And $(Q) gets a backup definition in tools/build/Makefile.include,
> because Makefile.include is sometimes included without
> tools/build/Makefile, so the "quiet command" stuff doesn't actually work
> consistently without it.
>
> After this change, top-level builds result in an empty grep result from:
>
>   $ grep 'cannot find fixdep' $(find tools/ -name '*.cmd')
>
> [1] https://www.gnu.org/software/make/manual/html_node/MAKE-Variable.html
> If we're not using $(MAKE) directly, then we need to use more '+'.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>

I almost gave my acked-by and tested-by, but then I noticed that this
leaves fixdep, staticobjs and sharedobjs directories as
to-be-committed files. Please check, something is off with .gitignore
or where those are put:

$ cd ~/linux/tools/lib/bpf
$ make -j90
$ git st
On branch master
Your branch is ahead of 'bpf-next/master' by 4 commits.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        fixdep
        sharedobjs/
        staticobjs/

nothing added to commit but untracked files present (use "git add" to track=
)


Other than that the changes look good, but we should be leaving
uncommitted (and unignored) files around.


Also (in it's less the question to the author, but rather all the
maintainers involved), which kernel tree is this intended to go
through, seems like it was marked as "Not Applicable" for bpf, so I'm
wondering where is the proper destination?

> Changes in v3:
>  - add Jiri's Acked-by
>
> Changes in v2:
>  - also fix libbpf shared library rules
>  - ensure OUTPUT is always set, and always an absolute path
>  - add backup $(Q) definition in tools/build/Makefile.include
>
>  tools/build/Makefile.include | 12 +++++++++++-
>  tools/lib/bpf/Makefile       | 14 ++++++++++++--
>  2 files changed, 23 insertions(+), 3 deletions(-)
>

[...]

> -$(BPF_IN_SHARED): force $(BPF_GENERATED)
> +$(SHARED_OBJDIR):
> +       $(Q)mkdir -p $@
> +
> +$(STATIC_OBJDIR):
> +       $(Q)mkdir -p $@

I'd probably combine the above two rules into one, but it's minor

[...]

