Return-Path: <bpf+bounces-15479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE297F2308
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E89282229
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1F63D3;
	Tue, 21 Nov 2023 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiEbqUUo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC4F99
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:26:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332c0c32d19so1740372f8f.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700529972; x=1701134772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI/AmTjG7v3kod9zNlOAgyQkNU9nq/EwZC85RPjIndg=;
        b=hiEbqUUohJOGeqO3Mb0sXH/Le8id1KbJyDadERGpR9r/eD+oXrxuhrxDcZIlMsUdmT
         CoGiSYNt0jlvjrp0KRiEgvN/r3NFZzJltdqMKelk8nW6CTB7NQlQQKgUpc0TpfCmwnfW
         XtMcrCq+Gm1gJ0DP8JQ+gKvfEtF9VStJ1uRxeyOTib+ZbZ/MpKQJu+3EWNuHqOY03Lh+
         oM9PV/EAjZo3T2VZZORCbPLG1i7hlFHXqB3mQQ4VLQAOqNiaCwspaoClC365w4yJ7vPk
         8paQiqqtiBCfL5tNtEZ9dEBNY4mU81IcFcXCOqZE4Mx7lEYJKkK4v2ko4aD/f+h/EIN6
         IslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700529972; x=1701134772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI/AmTjG7v3kod9zNlOAgyQkNU9nq/EwZC85RPjIndg=;
        b=ioXISazo4vfODykPXJEWG0gVRH71ojJ5+0gSRspxwTHBfMZsKStDEgle1XrmMHmb+s
         pvB3i+OO+V1RRHz/4+rH3SdskEjIPXjFYpm2eM8lCIZ8wkUuko1xgsBP9bcQRalcskUR
         3Pm1x8zY73ieCYqp5ohdc/VP5/C2/iTlCYyKX/o4Fq0Jq/HOVhVBPJD0HYcCWVMlzpNE
         6Rdcm+BFlq44c6+k2XGUh/Poy/sIsY+Ch12lUbZFh8lQWi0A9AFHpH5ozcJbsOwLOxCI
         d81zdXY0cTeQD/LmDb8nWQL7MW3l65q/aE2EkyfxvZNHObBR1VHkS1jcILsAPj2/PAcN
         GKrg==
X-Gm-Message-State: AOJu0Yx3eUnY3+zClctwLIgztUFgDi6YdIygNEKdqrSZdc0034xhgUBK
	CDMN7qgsmxcdbS2MRHYkzV2JJMBgMXe9H1caZ0fTsXIl
X-Google-Smtp-Source: AGHT+IHgpi3EsATIc7LDgcTxIdvztbcuhtuNYXcIH+wtz/fwFr/4RzVZVhtTN8itt2d2wmTzKDA4Cvy5XM7pnQ83qV0=
X-Received: by 2002:a5d:4aca:0:b0:331:3469:d58c with SMTP id
 y10-20020a5d4aca000000b003313469d58cmr5108375wrs.33.1700529971634; Mon, 20
 Nov 2023 17:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120225945.11741-1-eddyz87@gmail.com> <20231120225945.11741-11-eddyz87@gmail.com>
 <CAEf4BzZc8eCQ=2qCqWD9+LHobrSA3cxQ-yHpVFm4zRQ0Phn1bg@mail.gmail.com>
 <b0d346784ff3aac63927f1798cf1fcd14ebfde1e.camel@gmail.com> <CAEf4BzYghTaNgn+0E66N4X2hZ0wG8KOpza=O9BonKwhdviq2kw@mail.gmail.com>
In-Reply-To: <CAEf4BzYghTaNgn+0E66N4X2hZ0wG8KOpza=O9BonKwhdviq2kw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Nov 2023 17:26:00 -0800
Message-ID: <CAADnVQLRcOShH+kCswOZ1KMzqFLzMJ3ZoXLrGFwtmF2N2Vt2mg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 10/11] bpf: keep track of max number of bpf_loop
 callback iterations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 5:14=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > My bad.
> > Should I fix and re-send as V4 immediately or wait till tomorrow?
>
> Other than this issue everything looks good to me, but perhaps give
> Alexei a bit of time to take a look over latest version, just in case?

yes. Pls resend. Everything else looks good.
imo patches 6 and 11 look much cleaner now.

