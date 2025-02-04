Return-Path: <bpf+bounces-50339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE82A268CE
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7D21884470
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D120A5CF;
	Tue,  4 Feb 2025 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvqAkjbw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39C205AD2
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629685; cv=none; b=WWmJLW2NU1r1lKT7Xq/R6Ve5vD2lA8LcYs8EjaNCA/i+6p7GQFzTojm+YxDXekM0Xefn5TsIPrc+Dhf/82a+ntqIsLhgXd5kKB/ovuB3tPszZ8K74jKqSLAh+/z01lNdtHnOWM267Ps0Gdx40Lnnjj9A73XnKDXZp7zYwz8mX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629685; c=relaxed/simple;
	bh=sKcFJXJTh7oTyqsaZX/BZ3E/a1+/rxVAjCiwpUZmKLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoqOn156I8j4c5HBBnj/gUdzu1WID9aRJoPLXuvnqGGaCHa5BfQmx3Od1gpg6LMw+d7mHccnNy8qx2/ComzEFOFLyJedArP0dwx0Afq3bBD9/GqFnBLggKkbFsh8KzPrFfLkahwElMk7o2JFMJ47nq3XWRgOzmlTeD6uMb6R9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvqAkjbw; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so61515ab.0
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 16:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738629683; x=1739234483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mNEpv7gTbB0335b8JJb/srcBCNEtj77NuFnLzwPBSE=;
        b=QvqAkjbweU5QAmZncXpU2LDrHVSNYT3vMBKPUUF1EWJP/SOmYuAzZSBoOr1Gj/UYAk
         oxjH3tZaTO3QY9XQdpqIxvWmzLDP6e6pSCHjWVxXCsS6dNFS7YQffY7fbusMWJ0HIROx
         9k3hWjcm7yXoW3zReblrVvwepBAUGpaE8oPooOfHvYlRaFIOL3u8jNgQbFrV1yHtW2MZ
         miywLhc4RAWXiG52dOhDL9f5FnEe0Zf05ctL23ifuwK5RgupV6vgwvHcPNpivSxUW8a7
         FfLPpWTKCxlCHtSBZakjUU/QtzYQp980hUeJKSUYHk84KU6jHoYj0vb9AKhUfc6gum8B
         ILQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738629683; x=1739234483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mNEpv7gTbB0335b8JJb/srcBCNEtj77NuFnLzwPBSE=;
        b=SS+V1Ta3u71gXuk1LXoZQl6NtvdzB41PVfD8nErftfkWvMLQeCZKjFIpXmqPDFoHBs
         wk7SVsmkXbLnC6Vjm+/fb8YbPaewc1E6YEk1Dr5A+lycHr5P8dqN3dakJPrtRjYLz/YJ
         pMuDU2Sk0vGWIlpWymOCHWEG0YQTZ03BH8h9mkU/G2tsNnS59CoGmmUHP7lgS43iHfEd
         Fe/14fMvQSVO+VSuPEqyoqn9WFNc5pP2eGaDJoX+Yp811KSmbfWxCm+iIXMC2ZiOCV3f
         xK5qIUy8dV28DJ7ynepXhYn/TjrjLz7LsAEtCQp6LurgZOeh8KxX0rVvnQWV7SwWzOeW
         jLFA==
X-Forwarded-Encrypted: i=1; AJvYcCXNIXiI6iDPbdJJMZ9NpT25fp3L+ywgijuMwNV8X/Z1R0wVNVK77pE3KKYI5UK4+Bav/c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLuuYMXEp38mO1CJEKfazy7czAjruh86mcM+PsDye1HUKbeE/
	OBq4fjihs5eFGDPBp4ExGjSEoZuycYg13FiWZhPCTqsnNzzQoHw8rYzD0L2seyttp9AEhfsQzcB
	9fnSBW7/3NUH2TNULZVjLVdNv1XgsbNk33DRF
X-Gm-Gg: ASbGncurGeHlIXusHbxvViMfbV+tUTQOMFqwRj1+HQa1xgXkvSKWJ/SobfHeWL1j9Ps
	TG627ukP7oFkHGtB8INmoSnrklaZe+SJDIS73ubRJxa5gbL6nXFLXFVqFRnpSlZeviBk40F471A
	==
X-Google-Smtp-Source: AGHT+IFTmsdSrUWZNxyWfmEinctbi+w595ub39Ewf18wox3LV+/XzMdJuttm056+xxql2GVcCqEWSyo+2i00MgHicOg=
X-Received: by 2002:a05:6e02:1c82:b0:3cf:a4e4:8f85 with SMTP id
 e9e14a558f8ab-3d040f52f90mr736155ab.7.1738629683115; Mon, 03 Feb 2025
 16:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com> <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com> <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com> <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com> <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com>
In-Reply-To: <Z6FcHJFYGc7HzSna@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 16:41:11 -0800
X-Gm-Features: AWEUYZlTHqNw7TM6SlCsxIdmp-h0z8pnRnASzLfQef6fDEaFbRsdhgx5tvrKk7g
Message-ID: <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 4:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
[snip]
> Yep, I agree it's confusing.  So my opinion is to use legacy encoding
> and no default wildcard. :)

Making it so that all non-legacy, non-core PMU events require a PMU is
a breaking change and a regression for all users, command line event
name suggesting, any tool built off of perf, and so on. Breaking all
perf users and requiring all perf metrics be rewritten is well..
something..

Ian

