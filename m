Return-Path: <bpf+bounces-17252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE25480AEEB
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880D6281A1C
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F37584EA;
	Fri,  8 Dec 2023 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K1Erv+0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10E9F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 13:44:09 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db632fef2dcso2699235276.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702071848; x=1702676648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+K+9PWObK3AB4WVpJbf7LX17OFUUv6uzQb9uZjuMrI=;
        b=K1Erv+0XiW067a9Tx0hulEtAYebmbTJbRk4yZx+NlSj43AYqVKeoFJvwwbqd6CYN9m
         MJ3lS417KPz/1Bc01qXsFP+tiNhWdmn7n+W5chiJCRJAVW+J3RLfMLnud3KpyopwPj+i
         AcpAA6mvWrSeDJqOJWj3XaGe5FBO1WdtWFbphSVjL2PleyX5RGyf7FHHAwMb7qv7yPaL
         H51JzR0or+JrjJnYVHv4AjWd+8/06z4pEDkKCaatiBHuowLoVm/2pu0+mwv/Wacq9l88
         HTcIMKo6yUQtQGBYjM6K0JIt2qJP+tts+fnQltAKFH3NHfvGphwCE5l1wUJYFb280jjZ
         KNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702071848; x=1702676648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+K+9PWObK3AB4WVpJbf7LX17OFUUv6uzQb9uZjuMrI=;
        b=AqP3ISYhoPL0TfZrxXgNn74nxOeVZutoAVghJxpoYrjiB8gPiSY3sCLmiDMBOFjuLx
         qh7BLmYdbxTv4K2I4NiYl3wgt0yEOmZDxHuXrFJeuR4gOU3NeoB9wrM44kiGdH0F/ye3
         49BjNohJqth+7uyswHacrNzbufzgU3UFN5Pm9cghHUiH+MhjXzwELk7Aelg8LJ5mbDiP
         S63BU4nhEzLcsY7z/qo79Dd1Xcp2myaUjcYtsRGOMOBgUW/V+SAxKJBfWtAXNE9Fnbn5
         O3ssToIqv8HkA0ZCWlW/3uZtmtaAbeTRU5Wm+DXPJD/TqnnUFH1xoMtkmE+QJbRoEZ4n
         CHIA==
X-Gm-Message-State: AOJu0YywRU0X0Y7HjGejdYWXixvLvMcfY9hnyF6a6euFZFgCMs79Sk7i
	bBvoxtlapQoovsglMQnB5zfWZmbEa/MMFau/MMFF
X-Google-Smtp-Source: AGHT+IEkscpRUhjbdoub0t2Ee2q4GKbGdFEWTCCE3QwBuljw3SIOhfShAUVFdCGtYGXq6QkNVzEQONH+to80tmBOpRI=
X-Received: by 2002:a25:ab11:0:b0:dbc:3600:d80e with SMTP id
 u17-20020a25ab11000000b00dbc3600d80emr658263ybi.96.1702071848637; Fri, 08 Dec
 2023 13:44:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org> <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook> <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
 <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
 <202312081019.C174F3DDE5@keescook> <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>
 <202312081302.323CBB189@keescook>
In-Reply-To: <202312081302.323CBB189@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 16:43:57 -0500
Message-ID: <CAHC9VhQ2VxM=WWL_jpoELu=dHuiF3Pk=bxNrpfctc7Q0K2DUfA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:13=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> > Hopefully by repeating the important bits of the conversation you now
> > understand that there is nothing you can do at this moment to speed my
> > review of this patchset, but there are things you, and KP, can do in
> > the future if additional respins are needed.  However, if you are
> > still confused, it may be best to go do something else for a bit and
> > then revisit this email because there is nothing more that I can say
> > on this topic at this point in time.
>
> I moved to the list because off-list discussions (that I got involuntaril=
y
> CCed into and never replied to at all) tend to be unhelpful as no one els=
e
> can share in any context they may provide. And I'm not trying to rush
> you; I'm trying to make review easier.

From my perspective whatever good intentions you had at the start were
completely lost when you asked "What's the right direction forward?"
after I had already explained things multiple times *today*.  That's
the sort of thing that drives really bothers me.

> While looking at the v8 again I
> saw an obvious problem with it, so I commented on it so that it's clear
> to you that it'll need work when you do get around to the review.

That's fair.  The Kconfig patch shouldn't have even been part of the
v8 patchset as far as I'm concerned, both because I explained I didn't
want to merge something like that (and was ignored) and because it
doesn't appear to do anything.  From where I sit this was, and
remains, equally parts comical and frustrating.

--=20
paul-moore.com

