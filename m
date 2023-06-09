Return-Path: <bpf+bounces-2203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09CA728EFD
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 06:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186AD1C20E52
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 04:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECBB1377;
	Fri,  9 Jun 2023 04:36:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A47E2
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 04:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D72C433A0
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 04:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686285413;
	bh=lezblvI3C52s4pFqKwoZf5GwUOSxLDGBsg2MladJgxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rmRWjas15oy6rTWV57aBHB+ujw/DFs+NMpZE4cgZcxiGKhSAkAAqGJV0CbSIf/PtI
	 lg+C7vpDAzs0z7wz/v+2f6QxOHFC5jAhJjr0FsglGQdBzebVvnZ+RapXhFVQj88OCh
	 ezFjfTuqW3OpcyhlXK32/xALqRX/ihO85TPJeNLo0Oz98sQkQjMvTmLj4Y/oBweVHP
	 c66PFjEUAuhi1wpSKd7vDus58/dzHrGW6ZD0lLBsDe1HYjZ7fUH0Qj++fg9Gm0MMS2
	 39MDqO9M9kqH8H6eUBbflOvbztp8ZFNNL47k5aqL7hm5pgfpwGzG7O2Pu9bLsckm2W
	 jEXMBHuKoX0PA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so1710051e87.3
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 21:36:53 -0700 (PDT)
X-Gm-Message-State: AC+VfDyGS81Z3N7fm5+v9L2ydrtwxnAUDwQwEFs3ruCnktkjhp6BKWxS
	3547I8l39wnl+baNBVUWGSdJQtHGl/MIfPB8KLk=
X-Google-Smtp-Source: ACHHUZ4sL8hLgzq1dgaMWaXb7Va8uvBzNOZPHPB+bee+BAOartxI2e17kh6UmHH1D6SGNTgX5KbyRFJVmUagxE08UqY=
X-Received: by 2002:a19:8c52:0:b0:4f3:baf9:8f8e with SMTP id
 i18-20020a198c52000000b004f3baf98f8emr148036lfj.4.1686285411186; Thu, 08 Jun
 2023 21:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-10-laoar.shao@gmail.com>
 <CAEf4BzZtc+yfg7NgK5KG_sSLGSmBMW-ZBF2=qh32D_AW++FzOw@mail.gmail.com>
In-Reply-To: <CAEf4BzZtc+yfg7NgK5KG_sSLGSmBMW-ZBF2=qh32D_AW++FzOw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 8 Jun 2023 21:36:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6j=ebCqRhQ7KQ-1qLze1nkFFPOt9JnOB=yXfjPctd+qg@mail.gmail.com>
Message-ID: <CAPhsuW6j=ebCqRhQ7KQ-1qLze1nkFFPOt9JnOB=yXfjPctd+qg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 8, 2023 at 4:14=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Add libbpf API to get generic perf event name.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
>
> I don't think this belongs in libbpf and shouldn't be exposed as
> public API. Please move it into bpftool and make it internal (if
> Quentin is fine with this in the first place).

Or maybe it belongs to libperf?

Thanks,
Song

