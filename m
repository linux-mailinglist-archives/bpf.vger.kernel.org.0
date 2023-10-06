Return-Path: <bpf+bounces-11529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618FB7BB2C1
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CA51C209C4
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB17466;
	Fri,  6 Oct 2023 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbvhbFyA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D15CB5
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 07:58:54 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D293CA;
	Fri,  6 Oct 2023 00:58:52 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so1208791fac.0;
        Fri, 06 Oct 2023 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696579131; x=1697183931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dzmcoPg4c1fBky5mvbNlQevg6ir0Fo8DQjjuoUSzGc=;
        b=fbvhbFyAOSNc1SWwoyTBlEKcSgTQiZxJuMe+u3FAf+kjCn0OAxIj+PEIqN1ts+7/SR
         /9+ct27P7sFWuwLr9+62D84gk4Nc5H3XQGDhPzMziXsUsqtRDdxk2vW9uK2w0j4ey7Cs
         1gCUjIhBpdKENoj+IoBRIWhoBw05vjemqeeRD/WIZDZ7o/A075rxxsEc746Sa9vo5h6z
         n7oVeFAtlSaC6dqzrfsxv4TCXiQ1bjrcdJ2c2YntGZsgdLqsZ8Wpsk9s3P5+T1+MB8H3
         xB/Z0lsWb1GzbLesRqSBW0UmXC+1/xeI9upLaQjj9zbOj5KIyPAYYhKGydOGRGV4TXSc
         K6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696579131; x=1697183931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dzmcoPg4c1fBky5mvbNlQevg6ir0Fo8DQjjuoUSzGc=;
        b=xRjnt9JejtvtCO8cFwNPOzADxh8Ya53Lx/fdelBlEpG/EqHyQtEvsPnej6I+nk1lZN
         x42QdqCIYd47g4+N4PbzQZsMwTxzu1xzD7kzDVuZE48FpXk9QohWmKFfxCMQTptchPce
         zq40vqGiPxR89sYYhzuH3SbyGUhgrDpBt/J3E0PTJPfmLJRYf+GnqOw4JLeU1mCVHUBR
         6ZDJ78eWV5GtwVOPkZGFTl5jshM6rjOjYcRxVPBHZJwlVeew+k7rfVBTMLdFd9p5VExW
         M1IdoiWhnOXFs7rRN7mybMawVVOzkuVmoQEkHG93rrne6uy/bTW1oTr+Mg4G7axb3VH2
         p5/Q==
X-Gm-Message-State: AOJu0YyITuebWhVWDoqc0kMm6XKRdHRDxS8DQle4STk89A//17csy7Mj
	wsWkXcjDK9tznUW+Zf6Up+oQxIUD7WAPjKstebA50BzWJH8C/g==
X-Google-Smtp-Source: AGHT+IFWGCuzv4q8qYE4D86Cf5KkElzxyDFngkcSx8DktI0+KpBKS/vpR8lCY0JqvHiWOsQV/+KVYTydyox9exRR5PQ=
X-Received: by 2002:a05:6870:7196:b0:1d6:7f77:c922 with SMTP id
 d22-20020a056870719600b001d67f77c922mr8202007oah.28.1696579131492; Fri, 06
 Oct 2023 00:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003083836.100706-1-hengqi.chen@gmail.com> <202310031055.3F19F87@keescook>
In-Reply-To: <202310031055.3F19F87@keescook>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 6 Oct 2023 15:58:40 +0800
Message-ID: <CAEyhmHQxbdJss1AmCFsHVrfM_OdwuEA4s6=oT6zqg7sQAg=rQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] seccomp: Split set filter into two steps
To: Kees Cook <keescook@chromium.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, luto@amacapital.net, 
	wad@chromium.org, alexyonghe@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ BPF maintainers

On Wed, Oct 4, 2023 at 2:02=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Tue, Oct 03, 2023 at 08:38:34AM +0000, Hengqi Chen wrote:
> > This patchset introduces two new operations which essentially
> > splits the SECCOMP_SET_MODE_FILTER process into two steps:
> > SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.
> >
> > The SECCOMP_LOAD_FILTER loads the filter and returns a fd
> > which can be pinned to bpffs. This extends the lifetime of the
> > filter and thus can be reused by different processes.
> > With this new operation, we can eliminate a hot path of JITing
> > BPF program (the filter) where we apply the same seccomp filter
> > to thousands of micro VMs on a bare metal instance.
> >
> > The SECCOMP_ATTACH_FILTER is used to attach a loaded filter.
> > The filter is represented by a fd which is either returned
> > from SECCOMP_LOAD_FILTER or obtained from bpffs using bpf syscall.
>
> Interesting! I like this idea, thanks for writing it up.
>
> Two design notes:
>
> - Can you reuse/refactor seccomp_prepare_filter() instead of duplicating
>   the logic into two new functions?
>

Sure, will do.

> - Is there a way to make sure the BPF program coming from the fd is one
>   that was built via SECCOMP_LOAD_FILTER? (I want to make sure we can
>   never confuse a non-seccomp program into getting loaded into seccomp.)
>

Maybe we can add a new prog type enum like BPF_PROG_TYPE_SECCOMP
for seccomp filter.

> -Kees
>
> --
> Kees Cook
>

Cheers,
--
Hengqi

