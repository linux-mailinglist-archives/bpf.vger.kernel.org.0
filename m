Return-Path: <bpf+bounces-13366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381C7D8B63
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AA428211F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9013E486;
	Thu, 26 Oct 2023 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA8g+KRF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353682F502
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 22:06:30 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733D3AB
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:06:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507d1cc0538so1987393e87.2
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698357987; x=1698962787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cd3u0Gy91SPnDpn/gAmRKb0Xb0xV9Go4oPI+zyKWB0=;
        b=dA8g+KRFxsWddS4tCsXDTqf6t4KfJoPH8HsSnTqBaTfRsI9roxsjqU6CooPVW5lwo3
         6sCGSi/gkRcExwcVbboR+KgRBDnexoLeovoR0Mi48IAKh31tIMSXSOvqDvclAJRU1FBv
         NP1FbTXz1rAt3BOlsVwK2a3cLoT0A8OeABPjhwTdUJwK2xfEpbVqW4+VfS+0ICPDElbK
         3KqngKhooSCwFxlNwmTLTSUugvjDj+gQ5y6Wkmb7dmhdMWs918TlOldh8nom49dpmn6P
         5ard8DUmbMOMRg8fmYBpeXbVUTYIW2PlRVBz9EBii8b8+Vn8Ou4wmusL0AzFbCbvC6W1
         FCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357987; x=1698962787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cd3u0Gy91SPnDpn/gAmRKb0Xb0xV9Go4oPI+zyKWB0=;
        b=Qu9vjBA4VSrVa5R686iBrbAk/qygdTYSB40lpqUIAdpP4qTo5lYlrnEpC6/8cPBgau
         4H/uhxUF73jbM/DHc1SqM7PSWh06Jke5xIIPDLrDxjNjenJkToQAGwmNyvKNmMX1OHI5
         fdmDi2SkwjZqtuFgbtwF0IjB5lf8B+0cb+VMdO6Kc1lqr0MIloY9OtH0D9ng1j21PODK
         /k+3v4uXpVMbomZGFds+MuQ6ViLun6XGVTI5SQYacutJ+C+RGifpPFSSZ5R7DTGZTWMy
         zu1yeFX+tk3WIcA6Efmbc03p8agLeWAEscziakygSl+LS9a0VY9nO3ut50TtLY941tCq
         soXw==
X-Gm-Message-State: AOJu0YzaCINPjtzJALqu/gATnKLcBgTskhgnPKBJlw0/HLY+nTpr4V78
	FPdxKBs7RUMUsRWSusOaVUCqrCjmKfnDDIlufQ4=
X-Google-Smtp-Source: AGHT+IEsVYqAM1niFvyBze7SETmC2o0eSVtO/X5ewOO1m4VASbd4M1HKL9CSMlbhS6gTxlYnc5+/DhwWq0qH36Wu1WE=
X-Received: by 2002:ac2:47f4:0:b0:507:9784:644d with SMTP id
 b20-20020ac247f4000000b005079784644dmr450201lfp.15.1698357986607; Thu, 26 Oct
 2023 15:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
 <ZTlTpYYVoYL0fls7@kernel.org> <ZTlVAtFw7oKaFrvl@kernel.org>
 <ZTlaoGDkALO2h95p@kernel.org> <ZTlerFwlAn3AP+o4@kernel.org> <f65dd024a49323f4b0e282c1f71384b96f170d16.camel@gmail.com>
In-Reply-To: <f65dd024a49323f4b0e282c1f71384b96f170d16.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Oct 2023 15:06:15 -0700
Message-ID: <CAEf4BzbM20uErJ8-UiRb3WCxXJUXtvSRCKSfuAURXpsHU4ud-w@mail.gmail.com>
Subject: Re: [PATCH v4 dwarves 0/5] pahole, btf_encoder: support --btf_features
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Jiri Olsa <jolsa@kernel.org>, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 3:28=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-10-25 at 15:30 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Oct 25, 2023 at 03:12:49PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > But I guess the acks/reviews + my tests are enough to merge this as-i=
s,
> > > thanks for your work on this!
> >
> > Ok, its in the 'next' branch so that it can go thru:
> >
> > https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> >
> > But the previous days are all failures, probably something else is
> > preventing this test from succeeding? Andrii?
>
> It looks like the latest run succeeded, while a number of previous
> runs got locked up for some reason. All using the same kernel
> checkpoint commit. I know how to setup local github runner,
> so I can try to replicate this by forking the repo,
> redirecting CI to my machine and executing it several times.
> Will do this over the weekend, need to work on some verifier
> bugs first.
>

BPF selftests are extremely unreliable under slow Github runners,
unfortunately. Kernel either crashes or locks up very frequently. It
has nothing to do with libbpf and we don't seem to see this in BPF CI
due to having much faster runners there.

I'm not sure what to do about this apart from trying to identify a
selftest that causes lock up (extremely time consuming endeavor) or
just wait till libbpf CI will be privileged enough to gain its own
fast AWS-based worker :)

But it seems like the last scheduled run succeeded, I think you are good.

> Thanks,
> Eduard.

