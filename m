Return-Path: <bpf+bounces-53296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A2A4F966
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 10:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE66316B16E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0031FFC63;
	Wed,  5 Mar 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBWiyvnE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC91547E2
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165238; cv=none; b=KsfE0PLSMkUogpIaiislUp/Pket+UaC0njMVW5rL4U8jkzt1P6XUHmaRWaCHxhQrGOECMJxRFDdXLhJlox10vuSV4RYU5mfbeVfGOljvFSyVOkJ3tZH2PXEL31q37EhLQf8cUkCbFKYAyGP5j8GjWp++RX6XxU5RXx1vsKwL1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165238; c=relaxed/simple;
	bh=pvfmZOExJ5fH0jGmj/1x6ldBY7zOGS95uBdKTTqSfes=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxZth7Y9QKz6WMWcL/fvQUr9XdI7HgfPDhzk71N4zOUW44lOyP3z/QhHEKNGH6jCxWEy5VW0oo6teXbyMGmP+CA39OC+bXW4acusUlGTzwv84Td75cfsRVMNaFdg5L+7Lhz7y5Ow/iNHgeD2N6i4Ug1ESZL0MhUVhw4eneoiKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBWiyvnE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22355618fd9so113189185ad.3
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 01:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741165236; x=1741770036; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pVaGKIQNbOYYZpE09s60M6+RKlVauLfDYxHnhE49/Dw=;
        b=RBWiyvnEPTuQRsv4d1yUcSJ9AXyQzeLB1Nb/77+ozxL3H9PCoSjsVxKq3dJyWalqqr
         9KzW91InCsN31gOAzfXoMwt7LakewAvC/B0W352TM5GJ+lIu7QAb9iR7CMlJ6l44az6x
         t4mYKDOpHgS3wT+isrLXCRdMyIGRI38xTVnApz7kN9GE0O8KgNNffNuNeemfLERUfWrp
         vXi12b/1F6t+xRI8K6Me5ialT20M0ornzBVpH9mrywDG1dwtXTerUudoRam2SLCEI1Km
         pwNtwn1ED62sVETRFQgLH/d5lWD8PW7DF4pe0ikUwxyuBxn9s+jru6X3vooT+RZ4Zlht
         B+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741165236; x=1741770036;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVaGKIQNbOYYZpE09s60M6+RKlVauLfDYxHnhE49/Dw=;
        b=ccreRUbN+NeLHO51l/DF7++QJ70cB/ahfjL5CyaC176nlkDRiMkigiyq7HpzZd/zfU
         91T3kofd7MPjd1HFUY5DQ7WrjRvcl61InkkrFLpQP0jWR6/qpOX+rZbSeQsDtQzLoShg
         nmxc3Qz3l++C1nLg0ngIYvn2QzO40pDO4Ua3oJHPcu5gA4SH2LcwPU4LUSVV3557ixqa
         Hr5Ul1uTWcurA3QuOp5RnJsaiqn1JY8+zoA52cMNUx618UIOJike34op4+yMLTdH6ehX
         oKarEH4eYStZCBuICW6qhI9/sucq6RTOljVrMuNmeduxoGFuIaLDP42H8rxW3ZIlIr8Q
         Wk6w==
X-Gm-Message-State: AOJu0YwXoQe63eQM1A0NpUYyRuZjcxLL5UvnIHLQD3kU51b5HrEiRAjQ
	RcM/Pg8Kv4OSb7Y8u5wKJtNlKGLq0dH1gXpTn01LS9jytUttTIgv
X-Gm-Gg: ASbGncsHLdhKaCA+pn07bxA6Zr7riAxfO2Fb7rmjxomzyu44vzu6Lsjk8Rqhegehjja
	cOcutLYNvwKwUPFdR6HJof3v37NkYvykmcgFtTLAzKT7xpRbikwgsKJ8+OrOVWOqWV9IOEZZw7g
	2ms08dfOo05ThJ2If/BIr09ehoolLFYAk12fhUFUjwFpG9LmhbgKpriY9b1X+w6+vSV7PJbjGdZ
	Sz8oCnPn7FnUj0P1p4lbjAn6f97Jdk/Beyxy1gFepy2dnmxKgiobFQhEThsxmllWR22pvWLp0jH
	hgOVAAzIstGF9yaPNodMHCFr6Ymj0caaLlY8eIg41A==
X-Google-Smtp-Source: AGHT+IFrnJO5dwMtkkUUGhVIksnuk9u/B6FRN9xLA8Zz8YlJ+HMihJLXlriM+rjZTqyFj9wVrxy7DQ==
X-Received: by 2002:a05:6300:6f9a:b0:1ee:e439:1929 with SMTP id adf61e73a8af0-1f34959721amr3316921637.30.1741165236159;
        Wed, 05 Mar 2025 01:00:36 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736427c7290sm7108471b3a.177.2025.03.05.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:00:35 -0800 (PST)
Message-ID: <3e84b097a284963df4ac26213b10b30ef9efaf59.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf: simple DFA-based live registers
 analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Date: Wed, 05 Mar 2025 01:00:32 -0800
In-Reply-To: <CAADnVQKcOLDqwhhQpy6YU13ZbY3edGgx1XpXF5VsmXt9Byxokg@mail.gmail.com>
References: <20250228060032.1425870-1-eddyz87@gmail.com>
	 <CAADnVQ+BEW_yTsm-pMYcCsHhpZ4=FhAMmGvY7AhwyiUOZ+X1Gg@mail.gmail.com>
	 <cc29975fbaf163d0c2ed904a9a4d6d9452177542.camel@gmail.com>
	 <CAADnVQKcOLDqwhhQpy6YU13ZbY3edGgx1XpXF5VsmXt9Byxokg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-03-01 at 16:09 -0800, Alexei Starovoitov wrote:
> On Fri, Feb 28, 2025 at 8:40=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:

[...]

> > Two comparisons are made:
> > - dfa-opts vs dfa-opts-no-rm (small negative impact, except two
> >   sched_ext programs that hit 1M instructions limit; positive impact
> >   would have indicated a bug);
>=20
> Let's figure out what is causing rusty_init[_task]
> to explode.
> And proceed with this set in parallel.

The regression for rusty_init was caused by incorrect mark of "r0" as
used because of "may_goto" instruction. This is fixed by:
https://lore.kernel.org/bpf/20250305085436.2731464-1-eddyz87@gmail.com/

> > - dfa-opts vs dfa-opts-no-rm-sl (big negative impact).
>=20
> I don't read it as a big negative.
> cls_redirect and balancer_ingress need to be understood,
> but nothing exploded to hit 1M insns,
> so hopefully bare minimum stack tracking would do the trick.
>=20
> So in terms of priorities, let's land this set, then
> figure out rusty_init,
> figure out read32 vs 64 for zext,
> at that time we may land -no-rm.
> Then stack tracking.



