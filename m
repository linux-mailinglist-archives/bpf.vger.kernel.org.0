Return-Path: <bpf+bounces-20209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D549283A585
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142231C21E68
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6A217C64;
	Wed, 24 Jan 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlPFbVgR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A917BDA
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088802; cv=none; b=BYdM/ECBKo27p9LpKf5kbNlnvC32xIazft9dvrBetZclygufMvTKpR+6T++81UcjihhYPi8ock73xH9Emh90A+5dgGrM9znYeJIIU4Ox3dHrM2sUQjS2iBnZQHE+eSqvFicWj6WOCths2kcV+D9yRFB+6BFzxqrz9gwsvUU80pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088802; c=relaxed/simple;
	bh=j5zxh0luW+yhO3QhJC02NjfgjGAdowcFM8kQUUmMPS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0cIRwFh1rvyyUa9VXV+ffSkujmfGBkkdWVJZ8D2uZOYHXM5L649F9OxajYef23Dva452fEH2/bRSR2QPvT8Cyt2Op0eHv8UYRewmNpl5xWdGRu0lAn63WjTKt3O/DeIX98SyiJ3uFS1deKKsiykb3br9t9UsVFCky39wqHwfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlPFbVgR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2148b28ccafso737328fac.3
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 01:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706088800; x=1706693600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsz7nIgCortlYgFwuxGYcUnh3ptjlzk3Lf+JU53xenY=;
        b=HlPFbVgRAYU3VRDo1VPIZmHlG8b7y3Qz9hTpo6pXfKzXK+huX2laWhonisjLOXLfE+
         rKQoYUIlZbC4DYIrLM+5W61V7z/ikL90MLf2oxx7hDTp+Qgjk/Ld0RRuWUsnSvn90JN9
         W6PD41PGu9OD/A1NMnUiqY5d+5Ia9cnAOxb+P7N6uS7diiBNtEXJy4sRoTx1hlfBztjz
         Wntqtr0NpukMzDeDNKdUYSM9jHR8/q6PtnXHY2Dy2/4cjJcJnQjZjHaHWdT6xhXg9fMC
         AusEDxNchcs0u8rhRYLyONuC/YN5t630dgA7pcDvnN96wpvYZZzgifSwKyOdVjswcBg6
         30XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088800; x=1706693600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsz7nIgCortlYgFwuxGYcUnh3ptjlzk3Lf+JU53xenY=;
        b=eP2qwW5+iMuhAHsEUQ46eckXtVEnPWEiFtXUUUDfVPh+dXnPiBU7EoG81hAx9eOuuP
         sv3UB1y9Yjl9wwXKx/YlFTYUExrO6n6l8C9zet/4raj024tUndZ8QxI+jjXa4qX+Ujqc
         ABvi9swQjv+222cHpGHIZOpp/JkE9PGEv5P2aegpaucNaU+MspE/UA7SR87uHq4jFoxb
         MVcVc9ZSOCUm8c3QDZhzlNeYrtqgYjIZ0HJ50l2bw96qvHjwF9HqfxUJXzX/o9qyPQoX
         4qAdvN8gS1kG9E5B7Cd4GSsLxLDWlIKKkPbpdUuKKXowbzEriAx6ApyIXlmIXHfcGzZt
         1/Gw==
X-Gm-Message-State: AOJu0Yy/9bAp8oo1pzCJzTIBihMnQkYVkTZzLtkP9xIgsu4SA0QZ04eY
	auo4zw4ZMuHbG1217OaxtfQZxRCUaMlxkDg4XJlKU9jRcZFQQQgcQt9+78T+EevtGaHi+WIjkmY
	j7sE0nHjbfTBOHN4pUYGsY+sicpk=
X-Google-Smtp-Source: AGHT+IFOYuyXhNr5pteTTVV5gSfNpc7ZNmd7ohJ0qTjwNQpcqLd3tOKlyOMfZnpjL++xFHAK2X9OWE2UNXEKET2kqBQ=
X-Received: by 2002:a05:6870:468f:b0:205:c2c1:bdba with SMTP id
 a15-20020a056870468f00b00205c2c1bdbamr2545729oap.92.1706088800440; Wed, 24
 Jan 2024 01:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123152716.5975-1-laoar.shao@gmail.com> <20240123152716.5975-3-laoar.shao@gmail.com>
 <20240123202807.GB30071@maniforge>
In-Reply-To: <20240123202807.GB30071@maniforge>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 24 Jan 2024 17:32:44 +0800
Message-ID: <CALOAHbAN0egVDqn7UQXK4hhe9G3P2NyvhJVi75PpNTqGdHh5EQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf, doc: Add document for cpumask iter
To: David Vernet <void@manifault.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 4:28=E2=80=AFAM David Vernet <void@manifault.com> w=
rote:
>
> On Tue, Jan 23, 2024 at 11:27:15PM +0800, Yafang Shao wrote:
> > This patch adds the document for the newly added cpumask iterator
> > kfuncs.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  Documentation/bpf/cpumasks.rst | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumask=
s.rst
> > index b5d47a04da5d..523f377afc6e 100644
> > --- a/Documentation/bpf/cpumasks.rst
> > +++ b/Documentation/bpf/cpumasks.rst
> > @@ -372,6 +372,23 @@ used.
> >  .. _tools/testing/selftests/bpf/progs/cpumask_success.c:
> >     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tr=
ee/tools/testing/selftests/bpf/progs/cpumask_success.c
> >
> > +3.3 cpumask iterator
> > +--------------------
> > +
> > +The cpumask iterator enables the iteration of percpu data, such as run=
queues,
> > +system_group_pcpu, and more.
> > +
> > +.. kernel-doc:: kernel/bpf/cpumask.c
> > +   :identifiers: bpf_iter_cpumask_new bpf_iter_cpumask_next
> > +                 bpf_iter_cpumask_destroy
>
> Practically speaking I don't think documenting these kfuncs is going to
> be super useful to most users. I expect we'd wrap this in a macro, just
> like we do for bpf_for(), and I think it would be much more useful to a
> reader to show how they can use such a macro with a full, self-contained
> example rather than just embedding the doxygen comment here.

Agree.

>
> > +
> > +----
> > +
> > +Some example usages of the cpumask iterator can be found in
> > +`tools/testing/selftests/bpf/progs/test_cpumask_iter.c`_.
> > +
> > +.. _tools/testing/selftests/bpf/progs/test_cpumask_iter.c:
> > +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tr=
ee/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
>
> I know it's typical for BPF to link to selftests like this, but I
> personally strongly prefer actual examples in the documentation. We have
> examples elsewhere in this file, so can we please do the same here?

will do it.

--=20
Regards
Yafang

