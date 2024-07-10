Return-Path: <bpf+bounces-34482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6F92DBFB
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 00:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FAE2843C4
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920814A633;
	Wed, 10 Jul 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DefYFfHb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E4848E;
	Wed, 10 Jul 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651025; cv=none; b=KioEHwg/4nhq3nAFXk9AacXhEMT+/0fBkpqauNKqdxwCtdtkwFcPZ7z30QKi4O7fV4wf69KrAHfXr7Duv/tUo19jsZTR0yrAluweg5U2ipKXdfDAQ6n771KKvnnrRCX8aFMcYqUl5IrkbAC+AsQd/c8lsoNTRfSKjRrKgf1uWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651025; c=relaxed/simple;
	bh=Mh4agDdeooCAoHATqh3qSK0sN6arK1o+ThR7veVesGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBvKOAHe1I7ODzTYqFvR4RJgbLteYXiIp2COoJCcppGFzvsApwDc3eaROx66DMphAMta7keR5D5Rh1EW5pSf2ysoKDNiUeCG/E3o3GEhvaGV4iU/bJN2ZiNKtGx8rDett0uCzu7A23EEPeVLfQpTU0md56ycYisIr6nAaRI1xwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DefYFfHb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4265c2b602aso1631525e9.3;
        Wed, 10 Jul 2024 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720651022; x=1721255822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh4agDdeooCAoHATqh3qSK0sN6arK1o+ThR7veVesGk=;
        b=DefYFfHbeodAWxPQMeitNWFHmNell8trX8yaIGE0abSE+DOWh69v2wf+iF7Opoc42d
         c4P/NFShi4RWQV/oh58SdcquKbwN47e3UtR49jvzCKfOOhU8HAClZ4665qAN4YFuHQ5F
         x0x7XrfgDIlNbQTOodjVEdLQoA55PzIV6oe3esTVnuMyLZw51FJkIXJ6BwS20g/7BGRj
         ruOmd+Qm07b6C0rKdNCLmJgHxcGUlBum4j0Rv2ge4fpA+I7v9UDxkJtowS9PUwdo3mFZ
         GR+MaHodIBVdRm1kwXql9j0eK/vigDvcJO2o6WEbjPBNrXjvVGCyqsAxwjJLa2kxojeB
         nbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720651022; x=1721255822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh4agDdeooCAoHATqh3qSK0sN6arK1o+ThR7veVesGk=;
        b=jIS/PYpWJEnSWJFOH8Da8dOz7BkaYRgYUaBSMepLEtLxr4FAQYtWe6wF20lhNVhqhB
         DptpicnhkQcNchZtnSJ2vvKZp09Bj65V76DCz1ZA6waLfIfRvNPKnZjY+p6yMsgKYrVa
         PHBukYQpTkYIxfwfZX/BY6yUcPQgwSTjTwVjZ5pwz4JT+uV8BCljlDTI1XR9PYMBfNMz
         YAHBAwInKi7Bc2SA04N/m9lExuisMGZKYMTmnUR377uQvrbvEAvBSG2Ae+zdELD0Xv8f
         rpc5txjGNamXyFfpVJG+iKHLWPnIMEQpc1W5NCjGfh3AICyKrLJCbVr/vcBOkP++NyR7
         vaDg==
X-Forwarded-Encrypted: i=1; AJvYcCUEDQBW9gY/0NLAZKVTVxv1Y7oZJWfipQlqPA+2LxEFkti1zGxWZC9ODVdrsTSSyEUXa7xf9HfYDyMJTXRC3MQ4Bmh3dUHFz0UuXeXPTxmZAdAgl9qKKoWda7DgS1wa7aJB
X-Gm-Message-State: AOJu0YyDCt1xE4CoK9razhTcpHvutOCmUrkKqkr3o/wCEdSM8kOf0yTh
	LAinc17NRA4iaWeDexsSHjiBT6MsVFLgtCgNxpjis+CFS7/Mkh6z8bJchhCrwBDaVcemFtGrlxI
	T0fOI/kDP/skE/NR5BvzdUyWLJJI=
X-Google-Smtp-Source: AGHT+IHbJuGUuNrZDPlW5QYnChWirnIGrxjLC+wxO5RXDs67oAqLtD9SPYa2NXgI4RPSLPdrl9DBfGLKm1t2O/aWdi4=
X-Received: by 2002:adf:e40b:0:b0:366:e31a:500e with SMTP id
 ffacd0b85a97d-367ceadb1a4mr3745646f8f.63.1720651022216; Wed, 10 Jul 2024
 15:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQK_ftwe5Dxtc0bopeDg2ku=GrFYrMOUWHLnXaK1bqoXXA@mail.gmail.com>
 <20240710100521.15061-2-vbabka@suse.cz> <d4e5caad-7a5d-863d-bf65-63978ff9a865@nerdbynature.de>
In-Reply-To: <d4e5caad-7a5d-863d-bf65-63978ff9a865@nerdbynature.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 15:36:50 -0700
Message-ID: <CAADnVQKbpxFcfYcEgmeuUsHwsBLdiLcZAjYA+=H3+D7bohG1Bw@mail.gmail.com>
Subject: Re: [PATCH for 6.10] bpf: fix order of args in call to bpf_map_kvcalloc
To: Christian Kujau <lists@nerdbynature.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@intel.com>, 
	Linux Regressions <regressions@lists.linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>, Song Liu <song@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 3:27=E2=80=AFAM Christian Kujau <lists@nerdbynature=
.de> wrote:
>
> On Wed, 10 Jul 2024, Vlastimil Babka wrote:
> > Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
>
> Thanks for not forgetting about this! If this matters, just tested this
> against today's mainline:
>
> Tested-by: Christian Kujau <lists@nerdbynature.de>

Thanks everyone. Applied to bpf tree.

