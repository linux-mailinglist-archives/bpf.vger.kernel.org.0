Return-Path: <bpf+bounces-17208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A64B80AB0F
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE511F21243
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF53B78E;
	Fri,  8 Dec 2023 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aRwePcmV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91B199C
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 09:46:42 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db547d3631fso2710839276.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702057601; x=1702662401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNmsRcekZnRxXQ5gy0OoeOtUGR4cju8EsG3DYT+pGXY=;
        b=aRwePcmVFuOElIT1QeoaNrfMpBDa6VmcmkJ6HrlPxZTkAHcgqGE+i8qY0IeMG55cpt
         fgr8MRfowGJ+nYV197y2HIWZXuAjoORIBtQU/JzhF35fbYaVMlHKzrR7f2KYsrwa4vel
         +0bJTdqt2qtLIyETz8Ew6WmBhtRHb6WNPl4WsWTQBHFCGuA1JEHQvLWphkY6E+Xe9HCR
         TXtQc/zwsSpEyjysx8ftv8GRiGRc2tLQzO/KqLFT2P2usYEQxwHfYBc2Id9UWiHI27EG
         sCB5wUa2tyR4U0wSoOpOIOi5kLX7szc2P1MQa1hvtlMMWEN5U1uCKgh/BWOSZKabwu8m
         xdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057602; x=1702662402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNmsRcekZnRxXQ5gy0OoeOtUGR4cju8EsG3DYT+pGXY=;
        b=ojzVd+ivQFzL09etKkjaeKzCKH0eb/g4YXVM6SScR8iicWwJFdxb2GW6iDJ48GKKEx
         N+pL1F0rQVdLrMqW64kiQTMpray2j725GNlhBaVVo2Px2hm9VV9r5opN1CgurYWK1cBf
         b0K4Bkwzswwv+ydNdvzV8I2rLElkKVLgbS2FUxMje958bTswY1K8/xx52i/TpJ8sE+oy
         UcAF6vTbolmkxsemIccn0JwbKRTczCXPHkBRSURCTZTNs7NnAsKoxx2ukIGQPvREZLqS
         STF4T1s1hy9+h1CYM6YQowCHVSh4z6TckNiOjC8He4CiJNqkBhBqUBSDqIdbxcvd4vjX
         2i+Q==
X-Gm-Message-State: AOJu0YzEqldPShIw8+VLyhiHQSImsDuqKDLJtsivQvqJFAtPoJGpKBcH
	zPAQFoBkuTJoFiulPNO37OhLXzyMaOeZjg18j1xz
X-Google-Smtp-Source: AGHT+IGVz2uXoWS24Jy5RIDh4XGLvWvVwWltqnctCKFZl7+o06Fu4ZlQulisdeRIiHEcRAT1q5xdn+vhjGtgbDfA1/c=
X-Received: by 2002:a25:ad1b:0:b0:daf:b23c:8619 with SMTP id
 y27-20020a25ad1b000000b00dafb23c8619mr287890ybi.51.1702057601724; Fri, 08 Dec
 2023 09:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org> <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook>
In-Reply-To: <202312080934.6D172E5@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 12:46:30 -0500
Message-ID: <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 12:36=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Fri, Nov 10, 2023 at 11:20:37PM +0100, KP Singh wrote:
> > [...]
> > ---
> >  security/Kconfig | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
>
> Did something go missing from this patch? I don't see anything depending
> on CONFIG_SECURITY_HOOK_LIKELY (I think this was working in v7, though?)
>
> Regardless, Paul, please take patches 1-4, they bring us measurable
> speed-ups across the board.

As I mentioned when you were poking me off-list, this is in my review
queue and I will get to it when it reaches the top.  I can promise you
that continued nudging doesn't move the patchset further up in the
queue, it actually has the opposite effect.

--=20
paul-moore.com

