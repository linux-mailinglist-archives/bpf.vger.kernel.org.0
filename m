Return-Path: <bpf+bounces-56463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE6A97B38
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC7C7A4DD2
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F294421B9C5;
	Tue, 22 Apr 2025 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVsZaZZn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B921ADCC;
	Tue, 22 Apr 2025 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365706; cv=none; b=Rqo6s88/XcOvbLKV6k+CYoPh247mSQg5nvo5k9ySkCr2DLE1J/qcXCv3qxiLiBK65Rkgp3nGtKGG04Eec5HFoSX92XRBqibFoyetYPeX40VWU9+EF6HG5965zrUcgzCINuFqWgQOHQreGUQkzVm9rRan9swtKfyRcK/69eB3yuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365706; c=relaxed/simple;
	bh=XF3m4x51FuSvz7z3zzxBjimbbl8jqJRgD++sKZNC1xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABDpVkpVXIpkDkNksyG1eZVXGHhIeABEqLaLjakGDFEAAluVzMONmlMy9L8dH+UNjf0d71t90eEPfkkE4RVED2/64SnGT1ygN92zCR9kyatQJD9EPU4crLVDQGORiNYs8/BCQJs/fFY3Oc58gppSFW6l87ZWxXdCade9hocfHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVsZaZZn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso4193725ad.1;
        Tue, 22 Apr 2025 16:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745365704; x=1745970504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz5VwPMuB5nnVAtrcs+aJqyqBbOyn3MO4mHoWofDRuQ=;
        b=eVsZaZZnQHzhNW2x87izfOjYbYXidyXkaBgG/w81QB3gDWDEfs2B/tNWTv2+cVWNW+
         xjCTXfw3Y+H2noLYHUYTgfYSMgpp8zBsUZWrp+zGEng1ZRCX1UWsqvtMshG0iwK9hICn
         8GV1oifIb+Y2Mv+30ZPAmWNtrGOVw5F7Dd5rQptfrWC0MwmreUHWb/kO4VZPXQ/bEI91
         ZKwpn5rNptR2mJ1TlQfQomWT7baVAHkAbT1gmFfyN6AEGHhTr+T2i7FZ9+fCaSdyrMxZ
         9INVAWHQlChWqZY0S5auiMv1JadO2SfyDBQ2jUW/GHuSY0ApKCBVEPaCuOGTf5abgoWT
         4wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365704; x=1745970504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz5VwPMuB5nnVAtrcs+aJqyqBbOyn3MO4mHoWofDRuQ=;
        b=CpppmxPPz4n9v0PQdIuAaceMbdZXQeC1ylD0bka1PK1e8jZR5kB8w2SIs4XOLwGOAb
         TvG8dcggFKleomnUb27jt64FbNIyKsO0RpcWhI/jQxWbFBVGm4Mz3nB5PEFbZ1zEmenD
         n+1hFvqDy/3ZvfZr4dhxKwijXHSYII2fTlzDT03VuH/COhFuq5PbalWxUfyGzkj/VrD0
         HZR0JfcWZiaXrlKiAUoQ93ESN4RNABM8TBIagg5A5OtcC0M3C9+m4qQdJmtBaSKwtXfG
         5sQLgOeo0GyKcOj6mKj+rWfCTeV6ZUY3Cfb3elXgvDEVtytRaLlNobN66QgS/guheiaM
         /VWA==
X-Forwarded-Encrypted: i=1; AJvYcCV+I6w50wnpylKNtes5ubky3CwQNOWPO5I2Lw1SVvJ3wDyRMRLnvhmlTsqjhKYw3hyPUnQ8R7Kh+NQ31rX3aJ2IObj2@vger.kernel.org, AJvYcCVyvWsEugba4LJb6Rujh4lsrxmaSI+K0eyfKq8fw8ExvT+6AH8G0vWNbKFqEilx91cb1tG1tVKa+1fsLxMz@vger.kernel.org, AJvYcCXPgwdj9/Do0KyFjafwtDV6MS5vUFuqupN4EM14QUKATsfOsEhaswJ8uBKKRuN17aLMM6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLXBFOriZ53yLvNUMeysCKA8WBddF8JTLFAh8QbfDanLJLfR+
	HUMd5t0lkP/IETx7cMqh02iWwG6Rcl4gmTON80iNuvhHJleh7kuHslVXr6pi6Tu9rtrTxcFZKX2
	hxvmWSOWbWJGmfcj1PvXfv9B5grOY7Q==
X-Gm-Gg: ASbGncvlWqoOehSahsAX85ncJuYcmQ2PtOoR+/xPZSHHjGNlOV2A+9/vbAjigW5g60g
	LuMjhyd+13Jul+DB/4CPrZKKwEUecbDvnjYI65BUuEsggP25y/IFaahHMCavknBnxE0z0mXmJQ3
	5xC/nRmePJ5KcgAx+YzrN0mMoHUuoYtI1461TPsUCR5MVzYZL2
X-Google-Smtp-Source: AGHT+IFkc/aIZ2q/0s+4L4pak5tppDUo/woDhLrECOn4+i/21XZMlSZjtFxYsmzTCXfu9DdbzyRyhplL3l5XQdod4UE=
X-Received: by 2002:a17:902:b605:b0:224:3d:2ffd with SMTP id
 d9443c01a7336-22da332d550mr8676455ad.17.1745365704152; Tue, 22 Apr 2025
 16:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-4-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 16:48:11 -0700
X-Gm-Features: ATxdqUGYb_KD_UaJPg-6rl_fwT9UZnaWse4KgUun2cNK04zmn3-Lp8GiN7OZvuc
Message-ID: <CAEf4BzZS95Co=XveaJWA7oNytLpwFxJ+9a_-daoAyagTyntJmQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out
 of uprobe_write_opcode
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:45=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The uprobe_write_opcode function currently updates also refctr offset
> if there's one defined for uprobe.
>
> This is not handy for following changes which needs to make several
> updates (writes) to install or remove uprobe, but update refctr offset
> just once.
>
> Adding set_swbp_refctr/set_orig_refctr which makes sure refctr offset
> is updated.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  2 +-
>  kernel/events/uprobes.c | 62 ++++++++++++++++++++++++-----------------
>  2 files changed, 38 insertions(+), 26 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

