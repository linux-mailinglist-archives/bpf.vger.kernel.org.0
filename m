Return-Path: <bpf+bounces-59454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F3ACBC46
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DAA1740AC
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB4221FD0;
	Mon,  2 Jun 2025 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIzoSI9a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9A23CE
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896001; cv=none; b=NzXNPERSxv2/xOisyjGV72oMI1YzW1a+lXVW88mCVwqvg7SCWV8XrXPutHtNksW4UQ8Q+0OhVsrRXlNEMm7fcgAzahErXs2Lf4SFTK5VxGZMBawCAx5EqWoYBDeI1RYM05Lk3V9S3oMd5QJkM/zzrt4q/Ymof5SBdvfVWz3OxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896001; c=relaxed/simple;
	bh=yy6FlNOUYO7QcVohlDl63YNljgD7fgJqb1/vYLpHNbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASeLdkN/kl6CKB46pCBa8ICacIf+Z9NLYyApbvU0keoPt3blU4Ho0Nll5w/VjINQGmIK3u2yYtFTjWW76j52guOJv47C1v+hJcSbTLm6f3s6YIgIDem6fuecKhmz2EMFzE7ZSqtKVX/lXqxXEjQlLGvYEGh64UfIIOJlaWSt8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIzoSI9a; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e5aa697e7eso2905354137.1
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748895999; x=1749500799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy6FlNOUYO7QcVohlDl63YNljgD7fgJqb1/vYLpHNbc=;
        b=SIzoSI9arx77Bd5NUipcjN+TBznDBDve/hCpg/rxAQnhlnxXpx/v6apG8NA30CWk5a
         UiIwg2pDXu1dn7n/hKB038zMr2J0vFBsn8ZhvlYc2RBZcsOIXfhWMsLGjtTLqBGu5qgZ
         DkHjOITZOpFnXgFGk2C8QrSIt7XgNTHqQVfyP8dbyxnF8ujDQvN4dJMLKXyHMd2p59Xx
         5p+tPNYNPABIvS6BaiJnsHWP35mGY1kChB9Rp0vhUBLjZt+RhlaJ3gXBuBnyVY4DYtaj
         wNp4Sv3Zh/OWSxvpyj+3tgtSHqFESc6imAUtkyz51vfSOhcMhiQuMnhXSQQeASYLQctK
         KDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748895999; x=1749500799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy6FlNOUYO7QcVohlDl63YNljgD7fgJqb1/vYLpHNbc=;
        b=qMtIN1XFKcfxYUzV4E1ebaTSbF9HcbJ1MgybKRDxIpMQaPruQ2/g8PyEmMA2yZC756
         6PFUWOttT+pV+jtDQ9qRjEy7+c3s2UeoSM4S8UlV/SiG86NrRvrgV06ux6XtiCeXeUkj
         eiP+Sn6Wh521+9Ava799GOS9GbAR3ZfiEUQR6lv8cOpatVxNtOrlnSDOnqby/0o4DErF
         dJ/ZU1KsSrTmB/hexJOHmQZEscjFCU0TlPscGcROnZBeZR5TGxOTgu3l6gOIGFDZ25DS
         XnHgS+OyLZHPhc3nMwXVYOxq23HZtsYtGzXh1m/fikdo0289RP7+n+BGwFMlu58Oo75Y
         bAFA==
X-Forwarded-Encrypted: i=1; AJvYcCXKNFsQMHAHgUDpmf+6yuA2RsNz4Qsunr7BNd73hFOrEvc8LCX5cRzz7RClxqEubplf9cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDYeRthqwTsaAostE4gWHtWMpNFPQeZ9c5y9lgC0hW7TbahLn
	1CSQmYqSkgXiYnurD+Wx4QhyZLCCUHNpD1xfFDj18M2DRAxmSjitr/TfR5NDaC0XZLtpLttLR+H
	eNtin2GqJBiOXEmYUnZWKOjX4h3f7UpqMbH4NCXk/
X-Gm-Gg: ASbGnctjUsQElevsVOH3TR5nBElgRRZuItaMgdz8xR8ORvzHJVwweFfCYtmRDzmXubK
	Dj0udHxjylJcYLbeMaINVCUdHTFj73x05f4kuN0p/+z0l7nXqivfDgpHB2rM7B/a/OHsqCDwQ5Z
	1P6xK9mSRAHzgKzBrG7pqI+B51EG8T+N4Rz0wN+6HQg/0=
X-Google-Smtp-Source: AGHT+IGWzCL964d3NZSve0TxcZHhGFSpPRKvBMtmB7owRY1nMGw6YLoDv2x/qshMKaW9Ilmep03btfWt0apKbdl0NnU=
X-Received: by 2002:a67:c996:0:b0:4e5:8d83:c50e with SMTP id
 ada2fe7eead31-4e7323d69camr1055701137.10.1748895998531; Mon, 02 Jun 2025
 13:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com>
 <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
 <CAP-5=fWADfh9WNXgUOhXYW5hZWk-FZL1oJTdaDgq8Hqr8_Fd0g@mail.gmail.com> <CAADnVQKeJUdvJ7tKhpdatL-A5zDi9DXKFun8fwM2e7Bynd5FDg@mail.gmail.com>
In-Reply-To: <CAADnVQKeJUdvJ7tKhpdatL-A5zDi9DXKFun8fwM2e7Bynd5FDg@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Mon, 2 Jun 2025 13:26:27 -0700
X-Gm-Features: AX0GCFsv3gLe9smTQKIVsHtNCsx9xZ7FvMOlC239kYUGSq4OKs22Zv_ih_8j8Os
Message-ID: <CAP_z_CheNtGsrC0Rfuj=uPZUBjjNU2+3Hp4uXHmeMnfPhyMk7g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 11:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > If no suitable libbpf is detected then the build will error out. I
> > guess if feature-libbpf is present but not feature-libbpf-strings then
> > we'll need a perf #define so that the string feature won't cause
> > perf's build to fail.
>
> Yes. Something like this.
> It will also allow libbpf and perf patches to land in parallel.

Ah, so I could test the perf changes using this libbpf, even though
it wouldn't be present in the same source tree until they're merged?
That's great - if I have to do a bit more work to reduce the overall
merge latency I'm happy to do that.

Blake

