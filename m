Return-Path: <bpf+bounces-34249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADC092BD78
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7F5B2216F
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58D15B57D;
	Tue,  9 Jul 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bE80LEc0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08831E864
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536695; cv=none; b=JR94Fjt4JzJU5E2S9x9hHrxxaVYpPRqwMlQ0BEsp+hdPa1ZsrNeDfjvAhBqG2YdfQVy6xwFpn4omlMAQCKY9qVrFk5jSDi4ZLq7tvX3DdSQQ24eKUKrOfzhHjNLT5oWnt3KKZPdg+CRtMJmf42i6qoVsRPxUAMkbvD00erdibBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536695; c=relaxed/simple;
	bh=UVpvvv5hcYG8IH0FzAYJgDALiwcVm6EMz7HdnduQllU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sad+nDKEE3f8cIz6167sOxQKfF2jaiZO6gC9baKUflB7wGlXPRksOmtBbJNI6jy8lLNIpjl2FTFQD0V34LHlqC/O3jUROsElbJKxYfiIrRbuCZVj9jD68JpYpKUJKTDY/gF/pWYlP0TGh5rh5qAJpXmZNG3h98OJem0ze1/3fRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bE80LEc0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-650cef35de3so46952747b3.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720536693; x=1721141493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2cIr3JLhxqqtsJCxEtam/aozkG3wv5prUSPsfUfDOk=;
        b=bE80LEc0qkt4DIuq0C0YoqXTkc4K0kk9sm/dxaOTKaR8d/j78WLTyP6QAOPT6YS8pd
         GFjU6NSit7ZHKRRrr1lX/nSDNjEqnjy3RiOvmSxEIaIFtZLSJ+mcUNbt2EHby6LTVaEq
         43hIEToLjAgAMV/qFdDDZ3SpQ2K2I6W3+pgwYAc3vSPKFbjVrSF4AMtCM6fEaUuQyjM/
         p5hu/5hFsgJmTlHrfco3EFSjCGodC87gkZ2d7NTzECynCw4SvpO7Kf175a6jnTBikAep
         nFp4ux1TI3NQLau0cSK0usx0r+stLh5Wp7YedO6hZ1M3XM5veRCOWcfHRham1uiB0+yu
         n+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536693; x=1721141493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2cIr3JLhxqqtsJCxEtam/aozkG3wv5prUSPsfUfDOk=;
        b=S9E9lpMczKrTDXImreu18CJI2PpbQqV4xhbafi9Sf/x35whhZv/Afnp8642fwP2BbZ
         a8/egJXN6VCWK7MgziY/QaN579BTDzf1LZn1HHQBNMVuDCzyrhlrXBcIdshF2tE0hDn0
         ZWYpsrh8JmS+wL3VhCVyH0kYluXYwC4rOi7pjwqCSvKqpMgSf0jX4cZ0xfdqQhuCa72W
         cRxMT0x5GbGh+0EZqObQ4WWiEwMDGTzXVNEnpPP+aiQx+dkHQFRMd4GFTPyKTT88QITr
         CSyV7RbEs1S9Bcco2WbcNtObJEK1uiNPwPnpVFg5aOi8AZPnppdFe3nv6vOAiEy3lJ0I
         +3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVtubnSBF/6adNHv10I6h1h7qU1jeAObf93NSMzwq85S3sjIplY3XXNWMP7ILslFcvn2lQrJBZecL0kLGmKbu/j5h3A
X-Gm-Message-State: AOJu0Yyy+5s4aNCEjALVyRE4/Oonnlmy6MAVLx2Trfq6yRqxjfJH3SGz
	axcxZHQ35IK/4jgQsxvDTppGsUSsOkXQH655v58Fc3qdVg9tiTaqQ3iqBJWp5qSOrETkm7Pq4VM
	1LUCdOcBRaEu4EnxJSsdxwBy0dONL7qkqTxrg
X-Google-Smtp-Source: AGHT+IG2FdoxZPzV+YqmBDtPFwV2kV8zsMsNY2H/39Lmek9L5lLQSS6rMDUZt6mnCu3uhTMZi25NRsoJXHcx1P6zDPQ=
X-Received: by 2002:a81:b663:0:b0:61d:fcf7:b79a with SMTP id
 00721157ae682-658ee79043emr30907067b3.11.1720536692759; Tue, 09 Jul 2024
 07:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-5-kpsingh@kernel.org> <f40a3d1bc1cd69442f4524118c3e2956@paul-moore.com>
 <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com>
In-Reply-To: <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 10:51:21 -0400
Message-ID: <CAHC9VhSH+JkgxHccKBb-11o0QRjOHjB2T0q8tSGw7M7CxQyWhQ@mail.gmail.com>
Subject: Re: [PATCH v13 4/5] security: Update non standard hooks to use static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:36=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> > > --- a/security/security.c
> > > +++ b/security/security.c

...

> > > -#define lsm_for_each_hook(scall, NAME)                              =
         \
> > > -     for (scall =3D static_calls_table.NAME;                        =
   \
> > > -          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++) =
 \
> > > -             if (static_key_enabled(&scall->active->key))
> > > +/*
> > > + * Can be used in the context passed to lsm_for_each_hook to get the=
 lsmid of the
> > > + * current hook
> > > + */
> > > +#define current_lsmid() _hook_lsmid
> >
> > See my comments below about security_getselfattr(), I think we can drop
> > the current_lsmid() macro.  If we really must keep it, we need to renam=
e
> > it to something else as it clashes too much with the other current_XXX(=
)
> > macros/functions which are useful outside of our wacky macros.
>
> call_hook_with_lsmid is a pattern used by quite a few hooks, happy to
> update the name.
>
> What do you think about __security_hook_lsm_id().

I guess we can't get rid of it due to the crazy macro stuff with loop
unrolling, BEFORE/AFTER blocks, etc.  Ooof.  If you were looking for
another example of why I don't really like these patches, this would
be a good candidate.

More below ...

> > I know I was the one who asked to implement the static_calls for *all*
> > of the LSM functions - thank you for doing that - but I think we can
> > all agree that some of the resulting code is pretty awful.  I'm probabl=
y
> > missing something important, but would an apporach similar to the pseud=
o
> > code below work?
>
> This does not work.
>
> The special macro you are defining does not have the static_call
> invocation and if you add that bit it's basically the __CALL_HOOK
> macro or __CALL_STATIC_INT, __CALL_STATIC_VOID macro inlined
> everywhere, I tried implementing it but it gets very dirty.

Thanks for testing it out.  Perhaps trying to move all of these hooks
to use the static_call approach was a mistake.  I realize you're doing
your best adapting the static_call API to support multiple LSMs, but
it just doesn't look like a good fit to me for the "unconventional"
hooks here in this patch.

> > I think we may need to admit defeat with security_getselfattr() and
> > leave it as-is, the above is just too ugly to live.  I'd suggest
> > adding a comment explaining that it wasn't converted due to complexity
> > and the resulting awfulness.
>
> I think your position on fixing everything is actually a valid one for
> security, which is why I did not contest it.
>
> The security_getselfattr is called very close to the syscall boundary
> and the closer to the boundary the call is, the greater control the
> attacker has over arguments and the easier it is to mount the attack.
> This is why LSM indirect calls are a lucrative target because they
> happen fairly early in the transition from user to kernel.
> security_getselfattr is literally just in a SYSCALL_DEFINE

I recognize that your comments are in reference to that last flaw
rooted in the hardware that used indirect calls at an attack vector,
but wasn't that resolved through other means?  I never saw the PoC or
had time to follow up on whatever mitigation was ultimately merged (if
any).  However, my understanding is that the move to static_calls is
not strictly necessary to patch over that particular hardware flaw, it
is just a we-really-want-this for either a performance or a
non-specific security reason; pick your favorite  of the two based on
your audience.

Regardless, since none of the previous suggestions/options proved to
be workable, I'm going to suggest we just kill this patch too and move
forward with the others.  I had hoped we could get the changes in this
patch cleaned up, but it doesn't look like that is going to be the
case, or at least not within a week or two, so let's drop it and we
can always reconsider this in the future if a cleaner implementation
is presented.

--=20
paul-moore.com

