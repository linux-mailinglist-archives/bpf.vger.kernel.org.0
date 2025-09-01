Return-Path: <bpf+bounces-67071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2ACB3D63D
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 03:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D524E1732B7
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 01:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71B1E3DE5;
	Mon,  1 Sep 2025 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC6FKR9i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60634CDD
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756689220; cv=none; b=EtoQmK66QgAj1PQyjlZ8aDCR8zgHocV2pjIG4JH5bnRCFMC10EI6nBXLt+sUq3joe0e022jrzNScAJXKjkx3WtQgemiuS2ku0B9Y8I9Hcp5b9N/RUU4lrFHfN+L54LvGhjpR7JlMQmeCKbTVdNPBc5kfHZX8j2DysCKKIDguN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756689220; c=relaxed/simple;
	bh=hA96A36jSNt4jwW9zom5I9xRaA5a4Qw0+YBArA4MZ2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVZXYCqH3nFPl9+vXqqGrjIHzX6aJjs8D1PPiD47iLwNATjN09BUaCq5nyavcRrALWmHaxqc1lC4C5WszfNbADZ4G+ic4HtBvUevy2Zcr+7rZR4R2Rinid/wmxcdVbGE7vV8rWIPxjjf9eW0az2Ejmzqc5u0bWaW5fBxCRink10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC6FKR9i; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ceb830dd58so1877345f8f.0
        for <bpf@vger.kernel.org>; Sun, 31 Aug 2025 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756689217; x=1757294017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA96A36jSNt4jwW9zom5I9xRaA5a4Qw0+YBArA4MZ2Y=;
        b=lC6FKR9i6PiZo9lwq2FEJ6PqySRz6Sn0YbbhUQy//dAAqd3R0LEWxMaxW+FSjGqSfg
         Oih7v0NDOTI+Y1e1TU5fLPbaSmAINLfFaPdVYwXlBh+jx/sDweP2Ok4PAExmQXUyTkMB
         GPQgrSgJ904KeMfXV+55zFUtrNKZXSas0afk2dH+rLrYu76eDVQ6e7wRpdofUOp/A1PM
         gZ0jDSdclDred6U7r9psuHRASQNgRwmo54ZHkKtS8Msd01QzWhm1FJTAO4raImX77nd7
         /Vofz1BYJ0nJ93hYUoPfGYFrK4orWWCyySn/Nd6TecKtD/iBrUlKqUxFwss8inCIu/K7
         UQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756689217; x=1757294017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA96A36jSNt4jwW9zom5I9xRaA5a4Qw0+YBArA4MZ2Y=;
        b=H9vS+TC/ihziDririShwiq4O8i8TjQHP4BIOaCjLTJvs3kwhLaVaxz++pCdw4gpThK
         6YMigTTVl3h9aOCtI2ZKNgtP6/gj/WpB5Mz5jHTR+Ttc+wmhmCfnzniVvNmFjOvYz69Y
         8VUKsos3GvwLhCD97QDod0VssFVt/DfETCqZszLXiXnNyb502vcZAPEH3dReBjpSHKYh
         T7klS4sVQBvURFRX9aOLtsYEqYePEpaubC8Gho5AT2Ptwbm2V2K+L+7rpw7QqEq9t2Mt
         44Gd/OyYYkczRgakqS1xzqRgJPmVvaZP0Cc9Fdc1hiyHbo+f70gp16ZdVVUChdLy6TJI
         rr6w==
X-Gm-Message-State: AOJu0Yxv/eTx91B2sJD7wfc6rgJQ35ZkdfJatE/jrZn9a7bZjr2i3Qar
	mK2q7eugg5SFVsNrPzFQvUwQjatPLbGTKYB3Z2C+d5v10pU0Jsf9LerezRe7b04MqHW3RnHaU1X
	Brc6jZifpIJiLFxgiRDBpkYvROT1zHhI=
X-Gm-Gg: ASbGnctVjAX9O5E9D+VXJsqAcpW+N5OaFwF1Qz+pstdsz7/FY0cm1BT09X/XPWaqZbI
	t/2wTN4EifqrcKq5ejEu9WEz8gCt1EDxk6d5YBOgPguOo6dCVHCwVobU1e13ovbZIgtZ0Eupyg3
	Intm+W28K3tuLgDaT29qmaAlxKhUnzuPJZILFvd4/0EKA373gsBZ4KsWXw1PIQGPrcjvZgMsiIh
	h7bF/t/ZlAH8gMjUkS1vHqLj8sH9h3/JSd0
X-Google-Smtp-Source: AGHT+IH/b6wZrjKJjXniqgkLVu5pVjhc3OMEWnsL1vCXNqGWLYnmzO/RBz6eL+xirKtjG3zllIOpz4FJT5O1u3Y0u98=
X-Received: by 2002:a05:6000:250a:b0:3ce:7673:bb30 with SMTP id
 ffacd0b85a97d-3d1b16f01e5mr6062162f8f.14.1756689216552; Sun, 31 Aug 2025
 18:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829074544.104182-1-shung-hsi.yu@suse.com>
In-Reply-To: <20250829074544.104182-1-shung-hsi.yu@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 Aug 2025 18:13:25 -0700
X-Gm-Features: Ac12FXyiWWW19k0PPBcbt0poe9kgj3rE-z6DcOR4yOSEbBfHg2BMq3WNO4T9TLw
Message-ID: <CAADnVQ+BKx6EjQ=ezqQZGVP3HBkzp53kSspo1dVZKc0NL9Or1w@mail.gmail.com>
Subject: Re: [PATCH bpf] MAINTAINERS: add Shung-Hsi as reviewer for BPF CORE
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:45=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> Add myself as a reviewer for BPF CORE, focusing mainly on verifier and
> tnum.
>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> Hope getting myself involved in mail loop would be the nudge I need that
> gets me to do reviews more consistently.

I'm afraid that will be an abuse of the checkpatch.pl mechanism
for reminders like this. Your reviews are very much appreciated,
but please figure out a different way to highlight patches
in your inbox. For example, gmail can send patches with "tnum"
content to a different folder, and so on.

