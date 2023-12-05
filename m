Return-Path: <bpf+bounces-16809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2680607B
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C061F21701
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AA96E591;
	Tue,  5 Dec 2023 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOGKuxpc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1821A4
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 13:13:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c09dfa03cso31865195e9.2
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701810824; x=1702415624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9L3RVugjgAL99sYPgnC57uxin41KuGE2l8+V1gUqGg=;
        b=IOGKuxpcI0o0+6TBCbTJCZTMsoEfCT0s0KYnqe/N1zIXTLe+un3nKNoIeT/L3NbG/5
         HnpOqwfoOu/zxjJM/9U2kABXDK2ey8D7RyskyqNPw8etiZT6HjX7KZZI49qKofVZN1cm
         O+0MHrJuBhLqhALEt/vmGx9+bQ/5IxYMi9BW6oOMlKLGhoUFpgeMoNB11GpG8WeHtZEY
         jmQ1VaxZObMx0abkAAHo2wUYZ5By2cznMJrHvEWkebFKdPx05GH20b98G3+h/UVFPdxb
         bpmhUEOBmZ+pkX0vZLScoT51KLioj5DVNVfCVeOBVvLGir4Ea8qdX4jM9roze/h0gSZI
         lOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701810824; x=1702415624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9L3RVugjgAL99sYPgnC57uxin41KuGE2l8+V1gUqGg=;
        b=eKSbdlkEiiH+wv45xfmKA9yJlOgcp3eRjlJBmCmxz6rxglhqUAqTgCq7L+75fRe/1I
         7LxO0xdUSU2y0RmVhIc7JXtRKYIrh09iCOyCgDbyMbORyawrHJk7IvvXWBS7Z6+PZt5D
         bEZGqwewEfwjzB0sDuZv9gyKjnEIcy/31pPXdH794PC8r62nyH5pkuPBAZ4gVl8kmx18
         p9aGzj0RBLySEMz87VILoQjDAKbhowzAccyz2nmcLB7r7e5teqzHrCVajy0T5VBzhQnm
         W/HV8YbnWsmwV183o8FTg4eBIk8diXOVXpToTvyBOLMNLW8PhxYRWFhJKdC2PwjB6FiE
         b84Q==
X-Gm-Message-State: AOJu0Yw73lnP2zcsPoBTZ/ieuR4Oeym7GfknBfJaLGK6Uxu+Z8euyTa/
	ZYWpdbAYpIt3MaUqCJXA1v3WTk7xjPGPz3JhLVfgmcyTbr0=
X-Google-Smtp-Source: AGHT+IFVuJ+dyyBT3TJMcc+Bbl4odc11hnoJIYSlz1vRFzDnhh026IkpWS4mnJcfyPlU3/tryAsHhdBVn1ny/xk+hyM=
X-Received: by 2002:a05:600c:3154:b0:40b:578d:2487 with SMTP id
 h20-20020a05600c315400b0040b578d2487mr902105wmo.38.1701810823947; Tue, 05 Dec
 2023 13:13:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204173946.3066377-1-yonghong.song@linux.dev>
 <CAEf4BzbPtSZxJ16E+gQnw7sgfqwJVYsnkUZaxdk=c+65KWgnTg@mail.gmail.com>
 <81d00866-7824-18e5-af71-e0a15a03e84f@huaweicloud.com> <513bafac-03fa-4c2f-ba7f-67de96f79a10@linux.dev>
 <6e6feeef-9d81-38c3-4426-42ab12dc9ad3@huaweicloud.com> <9a308dc5-6765-4dcb-ba2b-43d257534ca0@linux.dev>
In-Reply-To: <9a308dc5-6765-4dcb-ba2b-43d257534ca0@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Dec 2023 13:13:31 -0800
Message-ID: <CAADnVQL+uc6VV65_Ezgzw3WH=ME9z1Fdy8Pd6xd0oOq8rgwh7g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix a race condition between btf_put() and map_free()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Hou Tao <houtao@huaweicloud.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:01=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> > Er, it is not what I want, although I have written a similar patch in
> > which bpf_map_put() will call btf_put() and set map->btf as NULL if
> > there is no BPF_LIST_HEAD and BPF_RB_ROOT fields in map->record,
> > otherwise calling bpf_put() in bpf_put_free_deferred(). What I have
> > suggested is to optionally pin btf in graph_root.btf just like
> > btf_field_kptr does.
>
> Okay, I see what you mean. This is actually what I kind of think
> as well in below to identify *all* cases btf data might be accessed.
> I didn't explicitly mention this approach in detail but the idea is
> to get a reference count for btf and later release it during btf_record_f=
ree.
> I think this should work. I need to do an audit then to find other potent=
ial
> places, if exists, to do similar things. The current approach
> is simpler but looks like we can do better with existing
> btf_field_kptr approach.

imo that would be the only correct way to fix it.
we btf_get(kptr_btf) before saving it kptr.btf in btf_parse_kptr() and
btf_put() it eventually in btf_record_free().
graph_root looks buggy.
It saved the btf pointer in btf_parse_graph_root() without taking refcnt.

