Return-Path: <bpf+bounces-54399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B3A69885
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A1E19C4AB5
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B623B210F4D;
	Wed, 19 Mar 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWeH6UrT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02702F37;
	Wed, 19 Mar 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410824; cv=none; b=rjJP/KitWqJ0YrJRjgFt7yg2oLZOQkOrFaaepfJ4bUEtKe4d9GjQp+9Lmw7YlUeAhGOeS0Wmtgb5ubh3lsZvS2odTXlErc8iO/Wl8oARt7rzgaNlJ6Lv2fDtoGJopBAqiM8a+mKpqFX/faU0KH8A1FeasWhJGIs3GbciLwo8Sz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410824; c=relaxed/simple;
	bh=3GeC1JJH65FFxexUeqtie/KtYOjHwPDxv8F1wIvtdnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRAbSQX6YhU14S8OW77Qes2qjDb7S2Q1cUJy91WObxyz69DwOuWxZMdweQ/+nUwkH2llVsygWhillNeNPbm+SCpHn/BY03ONTmvK1feGKRQgev7q3FO5i411BrTTqLEHvuBF1fz8O3Y0v6Qu4qFEbQMzHDffiPiPWkjcWMCQeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWeH6UrT; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e461015fbd4so5769271276.2;
        Wed, 19 Mar 2025 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742410822; x=1743015622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EeZZNb7DKFhmsueouZc+UQiOmb8GFuhy8rLNd0PPwko=;
        b=LWeH6UrTHmVoeySyWjUnmw8/T7tEBRZme5XWpx3MJlDn3Ys5REcOL+WW94ex4GtFAQ
         tTAfBWvBwar/ymM61WNET9+AkHllo8c70ZwNJjovjLQSV9CYQHj0FiBXw+DzRs/ymcNP
         3UKziUFOWCrnf2gPFSttrbaDOZwwb7/65UVPcl4Fv1EiZ4ocIbB04j9ue4hy+KYLaQPx
         b9nuyOhijlwLkAAKj9p24t6SRYt0LuXs/P5UIdBDKVeE8wz/unGLEWQ2PYeJvUgkWBpA
         pyBKhk1mjmgriIuKSGYqYR8EdszGYh1n9govJeZUYIG8xL7c8Jpy8SObA2AZJlxzBnpt
         gy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742410822; x=1743015622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeZZNb7DKFhmsueouZc+UQiOmb8GFuhy8rLNd0PPwko=;
        b=rQ9O+Wrg9GI9FlFGcRmfMEdCyJGfiqTYD1MX5+sAJdN0osKv3dz3jSYd+pFXgvdbLt
         mKIwOOHNM+moLr/gAD1EEbtAk3A99OU7c4kxslYYV3mg2Dw/5FVaygHmYLW+8NUdtkTO
         bkAvOHOk0bkTnoE4p8+aIbO73Lx6/KuSWia3fF6z9zSHU1YDVqWYfItDWA9B2AL/Vr+q
         1F019QLNp490zkElAOziRf4XMqdmTtPs8wHHpL+vwDxyJ0ATkPWyhc/4aTmlLzSgCDEU
         0x9FLUb8NKE3/Jcez/Xx08kQOtqI6xCLzyPT4bnBKfnCfx/kGV6OmO5Zx5pFMqWjQycO
         qpxg==
X-Forwarded-Encrypted: i=1; AJvYcCVFeKGRqwbbKhLTFFp/JYzGn2vVuY3Y6LUWP6f01OKM2fadpXOBPx18M6Sb/Dw79lASNHKZUroIOqTUB/OW@vger.kernel.org, AJvYcCVreIpB+1jbff9Dc5I/JHEIIhPwGKb3PX/iI9SNwUVFwCzUtUDJ1oTcBCgtSCXfW4/ENZhs8euOgFFKErRT6J5JIw==@vger.kernel.org, AJvYcCWuDDp4IfiT293f+w0QDv6jmw9PEmHc/aALlPaoahNewq+St2T7Zi78PBDqiXfqG62tPN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxptrkPB2xFulTUDPk69bA65YurvwyXAAtiIxczuxuCTfPefOu5
	Rj/h7guu9Xfmu6lxHTlWO4wGdVMdpj8Vf7qyv4q9WNLhgQq9GhlHoRd5ae1ixZZAJPXM0HRYVhy
	TE9yhrMFxhAt0TZ01nlukgt0y68k=
X-Gm-Gg: ASbGnctPSR7IsiCrqv4uu9ip2E57QuVHG798555xAk0TBfhN2sAP5nCoMkifTPZUgIj
	i3h5D0QVDLPgq056fKYsyxkPr3DDQ4bCTa16cg4XY5lKBl5aknVz7EasGeb0g55gf3ALkSwjgcx
	dqxpMNfZxe3QTNksfqv8lSVwpq
X-Google-Smtp-Source: AGHT+IG//qcQK3ByKaYzffml9wD3a2rj0QJf/1YSWw+Vm4PMgggN6RLgFRX58Wqni7xObwgsTkmVedlGZy8REhVy8bI=
X-Received: by 2002:a05:6902:1a4a:b0:e5e:1816:bfcf with SMTP id
 3f1490d57ef6-e667b39f6f7mr4724420276.1.1742410821660; Wed, 19 Mar 2025
 12:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317180834.1862079-1-namhyung@kernel.org>
In-Reply-To: <20250317180834.1862079-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 19 Mar 2025 12:00:10 -0700
X-Gm-Features: AQ5f1JoVtt4WjP96JIXMlE7UEvFC4fXdKbVLFt5J-rC9rVuEwrayaopAcQ844-0
Message-ID: <CAH0uvogx1-oz4ZjLpcTRArTb2YJOyY1h1pccMXYSgCnHYD9bPA@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Implement syscall summary in BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Namhyung,

Can you please rebase it? I cannot apply it, getting:

perf $ git apply --reject --whitespace=fix
./v2_20250317_namhyung_perf_trace_implement_syscall_summary_in_bpf.mbx
Checking patch tools/perf/Documentation/perf-trace.txt...
Checking patch tools/perf/Makefile.perf...
Hunk #1 succeeded at 1198 (offset -8 lines).
Checking patch tools/perf/builtin-trace.c...
error: while searching for:
        bool       hexret;
};

enum summary_mode {
        SUMMARY__NONE = 0,
        SUMMARY__BY_TOTAL,
        SUMMARY__BY_THREAD,
};

struct trace {
        struct perf_tool        tool;
        struct {

error: patch failed: tools/perf/builtin-trace.c:140

Sorry.

Thanks,
Howard

