Return-Path: <bpf+bounces-34279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700D092C3AB
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008D5B21214
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B255180059;
	Tue,  9 Jul 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fh1eDlZV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF881B86E9
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551944; cv=none; b=KTpgnB2i6Y71irbBfFfwaZDVtOGskqbXok9Z0EikrVTxi3sLRHlCLYEqr/1P62Ko9Y6gf7mdmURIiHu85p9j1JzXusgmMy/TIHFjmJ2WPfIhcJIdGV24MI7+p8W5HF8FrZw7z1TOvSElrffkRj39FGNICxtBm0JFZtMma30EifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551944; c=relaxed/simple;
	bh=0lSY8sS7FSdXqlC2bQMt25iLlSxIwfhjNcgv1ErZNuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StqbgVl2NJ+qnsGK+hBqn7fKYh7vG4jV0118M304raurCpvd+eoZPZsw5Oi3KF7ALo81ehdukE950a41RSGV8bDn00uovaTkOrfPfaIwWw0CCMkq9re0L4Et7Dj5vRwowpnOpLMEmh0g7CjQfMHaXzM6QnQLiX6HPM7m6fmOWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fh1eDlZV; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03a9f7c6a6so5922048276.3
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720551942; x=1721156742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22oPYIkXUegZik//iuLkIA/RKQ6ygZrjslJR51pDVSw=;
        b=fh1eDlZVqj8ZgsocOT4BMf0SWTuotH+L3YyPVSYmyWGE9QvFfqrEge88/7K6aV9H3w
         XkSvP5LJ5h6GdwcWuVvEukzA/9mIZNc4SSXhhWADuA0ug2eQ3n9cCFw3FaOtG3LV7ELk
         q8gZ2d3l3gWk8bV4js1vCxrYfWSZSwQ7IxK3JhnQ96qcvvlDvoiqeADfzM6ECj1pU38/
         ZoqbaCW0E1Ek+dOzoy5vsFhIkMtVpvXDv+oPIKglFCrtoSE0h7Qc/WpbrhM3CeLCgrsQ
         7s4JjJboGqZQ+xt5VTSpfdnPvXsHPSxGfoHF2fa0QAhuOJFbgeieV5KdwVJTCdZv9Zot
         RPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551942; x=1721156742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22oPYIkXUegZik//iuLkIA/RKQ6ygZrjslJR51pDVSw=;
        b=LmsmiYMPZzzsTiS9S8iUYr6mhxoIhbb18jPsH9ZFcYRWVQt35+FEosbDIq/vHaW1Rq
         wYIH7aZX+6YXBqyP22sAXC8YjV6mylHkOFZXn2j+cMKh+xSRwJmS5WBzbZC3NNtX0EUF
         3If2DwT8Rqwoo6KeYtYObPvoW+BmqOmmnwTbQp1AhnAACVS3LA+p8R4U9NyIbe5+H4AP
         b4yB+5aoel7LDEm3fx9zl11f7WKYLXna3wvcv1xTnlo60i2Sl0y8f+VtNZmAsk+TfPt+
         u9eQCLl439hfotDLTlDDNIyzaNpvV8inP2VEkZVkdFSJoMWNsEQf/hi6q+JxM3gm2Tb+
         FQlg==
X-Forwarded-Encrypted: i=1; AJvYcCV6lYrFnJxtlT4t4t19dvdBA8Dpn7hPHMpn25+5saJHqeAkI4sz6DwmMzJohIXlWp5t7515X0A+dQ0+E2UcWv1s0VV0
X-Gm-Message-State: AOJu0Yzoi55saTeQymkn1pZqzdpSR2YbrTEi8m4M/j5k0R5idoaf7ozK
	sLuzQPdP7iR+m/PBr/csKj4ZyxxIG8XGT6Fe4vaOdThiUVptRvUtYuV+YRZP/dxnwneKcNZNf5P
	UawyGY0YOLJdeHxMW4L01r9wMDifN7jI0FxBr
X-Google-Smtp-Source: AGHT+IGhklg038a5HzgbiWQLqn94HkdHCX43xrbJmCQsjITh8ARHePNHXKlvflNW6mFrvEOict7TZp2ZMTMAFhLGEN8=
X-Received: by 2002:a0d:ea50:0:b0:653:ffe7:d648 with SMTP id
 00721157ae682-658f0bc622fmr35885457b3.34.1720551942224; Tue, 09 Jul 2024
 12:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-5-kpsingh@kernel.org> <f40a3d1bc1cd69442f4524118c3e2956@paul-moore.com>
 <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com> <e170a720-c6e7-480c-a54d-c6ae7cf9a77a@schaufler-ca.com>
In-Reply-To: <e170a720-c6e7-480c-a54d-c6ae7cf9a77a@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 15:05:31 -0400
Message-ID: <CAHC9VhS64J+0PhK6YJVvRe0rRGK935+KPbGMZBO4PxVH22ug0Q@mail.gmail.com>
Subject: Re: [PATCH v13 4/5] security: Update non standard hooks to use static calls
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 12:53=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 7/9/2024 5:36 AM, KP Singh wrote:
> > [...]
> >
> >>> --- a/security/security.c
> >>> +++ b/security/security.c
> >>> @@ -948,10 +948,48 @@ out:                                           =
                         \
> >>>       RC;                                                            =
 \
> >>>  })
> >>>
> >>> -#define lsm_for_each_hook(scall, NAME)                              =
         \
> >>> -     for (scall =3D static_calls_table.NAME;                        =
   \
> >>> -          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++) =
 \
> >>> -             if (static_key_enabled(&scall->active->key))
> >>> +/*
> >>> + * Can be used in the context passed to lsm_for_each_hook to get the=
 lsmid of the
> >>> + * current hook
> >>> + */
> >>> +#define current_lsmid() _hook_lsmid
> >> See my comments below about security_getselfattr(), I think we can dro=
p
> >> the current_lsmid() macro.  If we really must keep it, we need to rena=
me
> >> it to something else as it clashes too much with the other current_XXX=
()
> >> macros/functions which are useful outside of our wacky macros.
> > call_hook_with_lsmid is a pattern used by quite a few hooks, happy to
> > update the name.
> >
> > What do you think about __security_hook_lsm_id().
>
> I really dislike it. The security prefix (even with __) tells the
> developer in security.c that the code is used elsewhere. How about
> lsm_hook_current_id()?

See my reply.  There is enough ugliness in converting the hooks in
this particular patch that I think we need to shelve this patch too.

--=20
paul-moore.com

