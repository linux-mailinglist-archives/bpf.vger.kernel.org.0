Return-Path: <bpf+bounces-3866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32506745A14
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 12:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE77280CB5
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972B46BC;
	Mon,  3 Jul 2023 10:22:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7703D9E
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 10:22:22 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093AABE
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 03:22:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991fe70f21bso497400666b.3
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688379739; x=1690971739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unqcElCbSbz/KEz3tHCnOGA+1HlEI/erWDnqqETONqQ=;
        b=Jhnz677l0fZ4iq/NsN3FykPeJVv/5KTyQQc4oU8H1FPdCgz0Q3pTBFlXZ3z7HPGihv
         QLM/4vPPlsmpJNXHYfo7z2fQFW/Wq+SjPKKuTysqEzBWXivZX2PifUllYW5zztB1CV6+
         1xrigfRKd0D0qlQ9Wm7z6ADq6ZUjPHGB3ThaE7mHThbJvtBjRy1rc9T9+Dmv20HDxl73
         0qwzc+Qyq+s160Kd+GSpAoabCrO5wbOJUxe9EGFrWZuV16zETMp0bh5iJ2ohLlO4riMX
         aBcLUNbQJojnp745+ZuSi2cea9OeMOtYB09v5SIdwKJrA2DRIjpyH8vFSnpajcGeYMda
         uSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688379739; x=1690971739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unqcElCbSbz/KEz3tHCnOGA+1HlEI/erWDnqqETONqQ=;
        b=hOglM/8dPAkmk4g8tAeLXRlNyzH/yvMQGH9tG0QwsbO15tGA/C4y+qgveQjhfjeYK9
         xI4IlnWp9CGqhgsm/rbJgIAPc9ffqlVxCHiAlgfaKvDGqXloe817Y6RXg0rYo1J5aPHj
         yyHNnReHbWNGYioW3krhu7po9eELB4ChbYzd5IqxAgmNhFfWUW+8kuZuKoFPSUVZ4fbc
         P90moNKlZl1ISRkR3qFkVI7IxdXbT5Edgh6YsTIcRgf4oFnGlgHMuAmbxlzHbpHxTaRa
         /S7WFGBQr5fybRSBnreWApFCt8IvwrztSifWquvW2rsIcCF4U6CSKDu0B/K8lmcKPZRG
         kgLA==
X-Gm-Message-State: AC+VfDzpbbqHYWQNkak69QicfBBYHJCtR3E49DMr4o5KSCHwKlk3srWv
	UUqafFK5RORxZQF1GZLbJdZiEuftVy1QWE4GdqReYjzL/9BrPWrlse0=
X-Google-Smtp-Source: ACHHUZ47dr4fst2/lpHmqBiNeSYZl6uU6lPdH+cI1OOKc8eSLR9/3/ddokI5Mo+6nikJ7zZBtaiuo6D+qD6raJVaXyI=
X-Received: by 2002:a17:906:f9d5:b0:96f:f19b:887a with SMTP id
 lj21-20020a170906f9d500b0096ff19b887amr6216107ejb.56.1688379739559; Mon, 03
 Jul 2023 03:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8junMrqMTQJ1cy-5fhd9FFsASWOndRPaprspKXMXShJYQ@mail.gmail.com>
 <aaf6220c-dddf-ee5f-37a2-e16bd580c0a7@iogearbox.net> <CADWks+YaTqLbmADDzeJC4WvfMtLCEzYw_+qibEMbM-Q6JGJHMg@mail.gmail.com>
In-Reply-To: <CADWks+YaTqLbmADDzeJC4WvfMtLCEzYw_+qibEMbM-Q6JGJHMg@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 3 Jul 2023 11:22:08 +0100
Message-ID: <CAN+4W8gotgUJ5hHz5oc+smQcL8A2FG=M5AxWCEef+9Ze4eR-Mg@mail.gmail.com>
Subject: Re: PSA: Ubuntu pahole creates buggy BTF
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Domenico Andreoli <cavok@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 4:17=E2=80=AFPM Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:
>
> Hi,
>
> Yes it is. This was fixed in Mantic already, and it is due to be SRUed to=
 jammy soon. Apologies for the delays.

Thanks for the quick follow up. Do you have a link where the update
can be tracked? What should I look out for?

Thanks
Lorenz

