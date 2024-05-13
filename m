Return-Path: <bpf+bounces-29667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B28C4854
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 22:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A750281D49
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E038004E;
	Mon, 13 May 2024 20:39:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D237E575;
	Mon, 13 May 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632758; cv=none; b=CfQo+vh743cWtrbokFeaiGbFsca6FSf30HmgoEcqf5BAMcSNizA2fnI4rJNX7yTvCAHEXkpj42NxFNuamZLffAPw0je5CAITArXQ9KCbeEKufR3LEHNQusd1wIltAI99MMHkd4mXs8RIidHVUXw2/4kJDi0V+YRbGIJbPEnBhEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632758; c=relaxed/simple;
	bh=8vMRy4szMOnPXyhw6N0O+8flCrkzToamhCJ98N3KqF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbiH+KeCBFDamK6M5/5a2Yb2sunHWt8/FFWdwNEMstmkI8OaRsQiE8RtpJXpNZs+kS5ZndwxQfXH5Mi7Z7se5O2EL++okRzb5mnR/GtDLauMbb0TU7RoTTCxxSBQo2igOQXfezVsBahcCzqJClE8CDZ/L1kVfLOAFhE24EJlpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so3106813a12.0;
        Mon, 13 May 2024 13:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632757; x=1716237557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMdSbsIUDp4fnJ0tPLW9CHarXx/pt+cDpbweLwiPVH8=;
        b=sfJfGLb1VSVZPcsKpi/p4IsKa7Xe7Te5N+4rrnMpzqc3Fxybk81IhI0BRLBHmpk1qG
         vzEnXKaWUtQx9dtHTt6bldCleN2NkHk28RnJk3AmWhsVAdGwCOVjnUbSazwH7MYWKkyf
         y6DzuRBtsX/NrYYOhy9OiBgjCPwu5hV24ytmVKPGxGfbjIAROinoOgMdnTGcrff3ABev
         jRlUpiq3X9BtEUa0EzEvqQrJA9vGcuh6Gc3RtEsjLeXXVdBGH38RhmlM/UnnHWtAPChu
         fp/WOWZKP4K3KZeZEYwQbHoMdK5Jk6GzftuBrNOzAQUoJlQ5P8zWZnzo20cddoO6hwjY
         mzSw==
X-Forwarded-Encrypted: i=1; AJvYcCVOh6r1ylxPuKQvBszlnaAMDzzTYa3vARa/SYGREWy6lSDslPSY/lP+U71a7fG0WPlfhJ29ZCsVdTZs7qv22tuD9Z1yBqJ8CbP22EumhbR6xv7Mb5b2i/FuWUMp3rvk5HbB341ur3Xug4MEcD2d6eXu3GKFutDrmKTj+yi554IAwUHMaQ==
X-Gm-Message-State: AOJu0YyT7t7AEvJxInjVokFDHqvlGrJtn4SUVvNQ5K1ziWkzuz7elq/+
	jV2MFZz1F6ot+dIAzxj/oLNYpjKDjwWhN1NJoWR2xUzfX2So7wPH4yvnvAs4DaCtRHWThRoul2a
	rL3QdzAoEei3eqvCYiYNuJuZ66sM=
X-Google-Smtp-Source: AGHT+IHuIwdncaMT0VngdNHIDyv/NgiYmPbs2SORZ20aglicpHu4lF6+t9bFdO0lOajqmUymSh4okJMQuCgcc+8ejDM=
X-Received: by 2002:a17:90a:9318:b0:2b6:24bf:6b19 with SMTP id
 98e67ed59e1d1-2b6ccd6b99fmr8662382a91.31.1715632756645; Mon, 13 May 2024
 13:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com> <20240510191423.2297538-4-yabinc@google.com>
 <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com> <CALJ9ZPP_2=X7XNQrLCV1pQUVH-pnHbW=Kz75ugSy+kda9Xwmpg@mail.gmail.com>
In-Reply-To: <CALJ9ZPP_2=X7XNQrLCV1pQUVH-pnHbW=Kz75ugSy+kda9Xwmpg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 13 May 2024 13:39:04 -0700
Message-ID: <CAM9d7cggLpPVEuMAriR7Zk-xNP6_Ecwx-zg5SyM6emvhRwEP+w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] perf/core: Check sample_type in perf_sample_save_brstack
To: Yabin Cui <yabinc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 11:31=E2=80=AFAM Yabin Cui <yabinc@google.com> wrot=
e:
>
> arch/powerpc/perf/core-book3s.c checks sample_type, see
>    if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
>      ...
>      perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
>   }
> So I think we don't need the "fixes:" line.

Oh, ok.  Thanks for the correction!

Namhyung

