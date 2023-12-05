Return-Path: <bpf+bounces-16697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D380484E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E9B2817B7
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A388F6B;
	Tue,  5 Dec 2023 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObYY/GQj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DEC6
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 19:50:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3316d09c645so4906527f8f.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 19:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701748225; x=1702353025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa//ofvpfivjSAdbEkchAO8fzjOT2KolH3hzyjqoW3g=;
        b=ObYY/GQjVddJacnRHWsGIOby37X5Sj1twVc50EexJZgqyILFfORdSvjRtSNAiFWtZl
         ejQ/RVAtIhxmaPcd2LUtSRN05Vl5CwpS+tlTGyl8V1exmkIrRs/BalaohTBGY4f64afe
         xAclrFw/HJQef6KFED+pzpL8tR6TbScVfnIRY806/gElIy0Rvfai/SOaMFa2BJJrVmGu
         AjjzgdsIENnh9ov8qOizKZIWqTM6kx2etCwGhmb1gXiV5ygQqwKcmn+T19up248V5G+d
         9d3EgDBW2XIEXmKjYp3et7rRvZ+ewf3qAeKhfKZWprr+g+nd1VO9QoFi7Xa+Uz8tQ55f
         i46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701748225; x=1702353025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sa//ofvpfivjSAdbEkchAO8fzjOT2KolH3hzyjqoW3g=;
        b=TiWPSZJv9vqMarfP2bpPX/OPi9NqEjUldwjgv571egHR33Q0Ahassd0jK1boH907Zw
         cNtZ0eaYMiV7LLqSblo/1io32dNGXVnbCoLta3OKRrCZ+8KGWN9tW5fvusSjSifaaocD
         EJ4mBIa27+gQCI7Nixz/5YjrMkzBENooukEv9GUUOT5weWjHwoLLIyqujEAmTphvC3Cr
         XR0LzfCu8fBQ9C4rIFMAJaT/k+6M0kCgAX6/JRCk2Zbg+lrJ2t6Jbw8NY1YHWY8PuYds
         zlOgLvYS+ctcSeJVzCkGQATAHk5qzKqGrwl/+ebeF9TsfFQ3D15xe2/E+/pTA5HN+ETk
         BD7g==
X-Gm-Message-State: AOJu0YwpFFdDAEwSMBpqY3CVxsmk4iRZHi/SDxyKpRpPpCbXF6ctcc01
	rmJ5TE8BQkWazTF4g/WE91a2nGyszqo3pXLL1yA=
X-Google-Smtp-Source: AGHT+IH/CBrsJwAYI3BdmC2mTPX8Z6Xpl1BUpfAqavZZqrhmzGhJEcloEqVdR0SeokDEFP0xGhNiE9n4R1kjWr1D/MU=
X-Received: by 2002:a5d:66ca:0:b0:333:83e:c179 with SMTP id
 k10-20020a5d66ca000000b00333083ec179mr3249190wrw.55.1701748224641; Mon, 04
 Dec 2023 19:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204192601.2672497-1-andrii@kernel.org> <20231204192601.2672497-4-andrii@kernel.org>
 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
 <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com> <CAADnVQJRdu69g4nXRXNopDLBPxw=aA7p1NakOwhvsgF8PKYqqw@mail.gmail.com>
In-Reply-To: <CAADnVQJRdu69g4nXRXNopDLBPxw=aA7p1NakOwhvsgF8PKYqqw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 19:50:12 -0800
Message-ID: <CAEf4Bzb0Xrr5ecG9e1PX6KhO14BrB-iWuc+AeLN7iK55BkrjKw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 5:45=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 4, 2023 at 4:23=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Alexei, do you remember what was the original intent?
>
> Commit 27113c59b6d0 ("bpf: Check the other end of slot_type for STACK_SPI=
LL")
> introduced is_spilled_reg() and at that time it tried to convert
> all slot_type[0] to slot_type[7] checks.
>
> Looks like this one was simply missed.

ok, so this seems like a correct fix, at least according to original
intent, great

>
> The fixes tag you have:
> Fixes: 638f5b90d460 ("bpf: reduce verifier memory consumption")
> is much older than the introduction of is_spilled_reg.
> At that time everything was checking slot_type[0].
> So this fixes tag is somewhat wrong.
> Probably Fixes: 27113c59b6d0 would be more correct.

yep, will use that, thanks.

