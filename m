Return-Path: <bpf+bounces-28897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A88BE9C7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7544AB2F70D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8CB1509AC;
	Tue,  7 May 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjyGiA7r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8001170D;
	Tue,  7 May 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100213; cv=none; b=jmotOraGYkB+AOAoYhlsXh2Zepc5m+JK4hbcygLxOMzRMhJOs+C5+XM2fB1MJ0eDYyotYc4F53TJY67ei6QZ3GrXWnBzVB+lsKd06/rxTgOIXz2ptOKUJlcskeNZl8DdTLH6Qx6Jyq6LnHk+TggGJFMr/6CKrrzYSu45zezp9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100213; c=relaxed/simple;
	bh=Y7kvUe7PWA91hGpbQvQz1NQycujZOyxpl3+EQ8UjYU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlitzZRc1sqBKiZorfskkFPwwY9U92/n2h0w6kVqLah8LDd6FLfZ8yUMyFSWWscjQxH1hJLGZsh6QippHix2uHPLtdIqYlDTBsDQw5aeQDSAQJXw8asrfxPufsF0Qqbkos5FKhg4b+7GMm7YgZxLvelxlInwS+HtY+0XsPw7Zmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjyGiA7r; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b4aa87e01aso2403033a91.3;
        Tue, 07 May 2024 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715100210; x=1715705010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7kvUe7PWA91hGpbQvQz1NQycujZOyxpl3+EQ8UjYU0=;
        b=ZjyGiA7rjwX+1Z9GmQke9oKsybjswn5rPyOjIGkVb5M4G904lCjEc+iOep63JIlmWZ
         cQrRn8fHhhOQAPMzpWaVoyY6Cr5Wu2Bsv4tCtlWVrWPNC10AmkHJdhuswLAUrCL8pwP5
         2KRslaUuycQz3PZKou7e/CVcy8zJamU3jUbX1smC+bZFt2ZGknFtZEzWS3X1iE6rhv24
         rVT1EhmNr9sM1yuXC7Xw/s5ZuwmtdRaxGo44VhLhfQ/JlETbzHRpvvmRWo4w2XvGOOKG
         PL+nsz4CQ9E5lz/1uuCcphCyrRd24mmQca0QGid4jQs7qIMHKuPNdNyoRFmxzKc05iUm
         ijZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100210; x=1715705010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7kvUe7PWA91hGpbQvQz1NQycujZOyxpl3+EQ8UjYU0=;
        b=XDeJRLVoTSmmT1soUqWd1bnvgLOjSqqV8ANDqVp/h7ciYpMp9UlKDFQdwMrWltiZw1
         +mfZp+pvkwKdD08kAUAo+Out0d9EaWDVF1hUnfNIqP/kxqUYakza1qecph2LfHeF3QUk
         EMvpK5dVVYVoLkCa3pdch46yIqby8zXASeXYgfktNrBAkgbIU9VN9a0xystCQauOF4ii
         GgTfI56POT/vFGAem6kPa54QlvlXnBD+JOXd6BQIng0IdE3btr8Iis2tTTKeQnKEKvHC
         5xUtCmrurhofF8dndC+D7MFMySKPAx2eiYAQBY72Mc/k+dotuBWlCf5YUjgLmT0/sMHg
         dJxw==
X-Forwarded-Encrypted: i=1; AJvYcCW0HZz0t+wvIhkM2gPyaWrbjf4oqCPGrzPX3g02jQkiWaujlhIebtv07kPn2rbhHpDKVEQNR7B4hCCiDuAU+JoYDdN1tiSvrfjkvgKFkchu+WGDKYQ1mjS5VjVSnS2XevXd
X-Gm-Message-State: AOJu0YzB84eN6kiG24zoWn79GDqIeUCVWF+PJzMAaxftSlK6ZMHFRukp
	Q8m7nY5pqTYqZm7rLxROVYOYgHfPAqcE3kv/vI5mSDz+ZNlyFenw9nRtGogETtHPW1pPIfgz/cW
	khFJZj23pQzDanl0iceD5+QmOJig=
X-Google-Smtp-Source: AGHT+IEYuAfJMywxZpV3O5OsKNSTiLDeh3g8q0vDaOBApSsy19SVvUkbV7gY44A/c+tGNVmZJZetSZM4W0CXsT3JDXo=
X-Received: by 2002:a17:90a:e384:b0:2b1:74be:1704 with SMTP id
 98e67ed59e1d1-2b6165a14e9mr109316a91.15.1715100210592; Tue, 07 May 2024
 09:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507024952.1590681-1-haiyue.wang@intel.com> <CAADnVQK7zD312WRJboMib8HJnNzN=i2FKH2QxkVVy736b7sNTQ@mail.gmail.com>
In-Reply-To: <CAADnVQK7zD312WRJboMib8HJnNzN=i2FKH2QxkVVy736b7sNTQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 09:43:18 -0700
Message-ID: <CAEf4Bzbze5D0M2V9d9q90E_XHCMEUa7oXum=wOCVQ_BAugox7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf,arena: Rename the kfunc set variable
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Haiyue Wang <haiyue.wang@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 7:36=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 6, 2024 at 7:46=E2=80=AFPM Haiyue Wang <haiyue.wang@intel.com=
> wrote:
> >
> > Rename the kfunc set variable to specify the 'arena' function scope,
> > although the 'UNSPEC' type BPF program is mapped to 'COMMON' hook.
> >
> > And there is 'common_kfunc_set' defined for real 'common' function in
> > file 'kernel/bpf/helpers.c'.
>
> I think common_kfunc_set is a better name to describe that these
> two kfuncs are in a common category.
> BPF_PROG_TYPE_UNSPEC is a lot less obvious.
>
> There are two static common_kfunc_set in helpers.c and arena.c
> and that's fine.

it is actually confusing when reading/grepping code, though, so why
not have arena_common_kfunc_set and whatever the meaningful
"qualifier" name for the other one?

>
> pw-bot: cr

