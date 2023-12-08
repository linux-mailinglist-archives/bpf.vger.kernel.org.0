Return-Path: <bpf+bounces-17215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F9E80AB5A
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57825B20BD6
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055D34175C;
	Fri,  8 Dec 2023 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cQ6Zq6L5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EF81BE7
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 09:55:28 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-dafe04717baso2395323276.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 09:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702058127; x=1702662927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCroPR9ZSP2l8V1Q6/VGHsN/VoOs8Z300HzuyHm+39A=;
        b=cQ6Zq6L5gSnO1NLAqIyLI6mWxq33kqfysEs7JIDaaAEQI0o0r0j677TC0fFCwTMedh
         Pi/85w9K+uwLhjyKQ8+AESs4Fw2xDSkkkirLmB7Dw3jntBhyJiuhMp2cw4LOQSon0ttE
         PnrFC38DXVfCJ1ikcQkznGisfcGJzzNMHkOKSg6lpkj2oWCA3yMqAfS50HqhjecE2OGL
         T4tdIeZyyHCUormqPMZyW9H8O6RbRJSC0iMQF1skUN7oZFH/o3GLPpf3UK9c/ZpCfUra
         7rYek0OmY3gZ/gxxpShSj8nzN9uQbb6qckzORI9bqeCox6NsqjGLh9nB8yMq1QPV+oja
         xTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058127; x=1702662927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCroPR9ZSP2l8V1Q6/VGHsN/VoOs8Z300HzuyHm+39A=;
        b=llD+ah7YggC69vM3wDv3KbIVd1eJk6TenmxCQFus/hgH/gVBtbhsiXCNlZjM2wbO57
         KmtXCV+l2R32eLkbKekmBCGv6UuozRSsNcYDG4DAMwGDLvii29wtT91xJDMQpb5y5Vd+
         B0+QXCASBUPfonTj/gdpj1KAiADivLpeqVmtyLhzu7EeMlF/pwZw1W4s7m6NJLEjkuW+
         /v/5QLFUmhhMxJJy4AOYTPh/w9TL/V4Q9cRBf4CUuEcVIoJSr4R/M5WeWPotXE/jpEnR
         hILWBanW6vy6MiY11IKhmQ4Uvi0zhzhrxFJ5M3tBCpb1jSRfd8ihrnSjFqxS2A7r7j7d
         CLwQ==
X-Gm-Message-State: AOJu0YyhGG5uPYMoR7oiE6XV6KwTSakkQiWcztm65935PP52XRgGvflZ
	vT8fpojiHYgWN3gLCOzUvQdg/t0KzrhzlGOd57v/
X-Google-Smtp-Source: AGHT+IEzwsy0AZ74EL4/wTJn0JdgikevOqFD/o+di1wOmB2RJdQnLNT09F7tlAh0y6LFyfimUSDSndbsxLSTFXKTKHE=
X-Received: by 2002:a25:ae4f:0:b0:db7:dacf:6fdf with SMTP id
 g15-20020a25ae4f000000b00db7dacf6fdfmr390213ybe.103.1702058127436; Fri, 08
 Dec 2023 09:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org> <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook> <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
In-Reply-To: <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 12:55:16 -0500
Message-ID: <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 12:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Dec 8, 2023 at 12:36=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> > On Fri, Nov 10, 2023 at 11:20:37PM +0100, KP Singh wrote:
> > > [...]
> > > ---
> > >  security/Kconfig | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> >
> > Did something go missing from this patch? I don't see anything dependin=
g
> > on CONFIG_SECURITY_HOOK_LIKELY (I think this was working in v7, though?=
)

I guess while I'm at it, and for the sake of the mailing list, it is
worth mentioning that I voiced my dislike of the
CONFIG_SECURITY_HOOK_LIKELY Kconfig option earlier this year yet it
continues to appear in the patchset.  It's hard to give something
priority when I do provide some feedback and it is apparently ignored.

> > Regardless, Paul, please take patches 1-4, they bring us measurable
> > speed-ups across the board.
>
> As I mentioned when you were poking me off-list, this is in my review
> queue and I will get to it when it reaches the top.  I can promise you
> that continued nudging doesn't move the patchset further up in the
> queue, it actually has the opposite effect.

--=20
paul-moore.com

