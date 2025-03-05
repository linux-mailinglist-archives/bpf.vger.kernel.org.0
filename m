Return-Path: <bpf+bounces-53370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE2FA505AF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DA2162264
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78D1991DB;
	Wed,  5 Mar 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQcwriLL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE517557C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193571; cv=none; b=WPweIERVQAjyDjt4beCGgjPkDD6jpzweto3MybcshjXNEzngGWjp7YbMf86IGamJgqrXrRQXUu8R5lhccgrNLfIwYU8mmGroH26LzbY/SebDW7IYdBva6Yb7TquW/b40vMKgG/8gi6LynrmsmniVm1N5KyApEsD8AsnKFmiK4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193571; c=relaxed/simple;
	bh=97Ex4VCV2J4OZEycPxRz7GYypqeHuDqp9hAEC8huqYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZM9Na3duzQ5rPMbWMGOj2hAARRNl/QlLjNyXakjWRgq5KuSY1sVDWh4neYl196jkdp1/ST18iSWJRpWlS5jPghxJVSEwU5dp0nQWgVHa+Dwqd57YWaRzllPy775US4i6Yf1hoed8OPAesdCI6fh+xhNCRK9+ZHQkkmiIQ7Ow/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQcwriLL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53c9035003so5493658276.2
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 08:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741193568; x=1741798368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcYT160Gy4SvxtvQQRp3pAXWWdgTx4b+b05Pa8gqDDI=;
        b=BQcwriLLTV/LZJS5kmeVjEdG0guZkxGNIztT9LRyJP3elW54EJfjWIQoY4sdsxVvg8
         BS0JOdC91BbdfbOajkmxJrTgPr95lgaWvofP2epT3LtaN4x4lIDFEj1Co/N/LcAWMdbv
         InJYV9tYusnRJgekdyCgRwkXIrqN1pH2t5ICcYNWH4V0IjM7t0MBcxL6kl0ccZjQTpvp
         OsLbmik9SYnpRTqeQ53HczEuPDAybGvlqE3Eh9pUKVUETcqQwBt+7VQfIuoy6n4s6xIz
         HQ3lT/Oq4qVAceZDYLy+FSX8jn0JHQH79QYjnLFy1DO54v378hYON1d1eBkW7/dOg4aM
         TQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193568; x=1741798368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcYT160Gy4SvxtvQQRp3pAXWWdgTx4b+b05Pa8gqDDI=;
        b=GE4an1Cr3qUPckZ89al4N9iviJpbUCCNQAT9Mp18qi7ZH7PYxdWZYidrLoeGC2ICvD
         moQ9ULVlGQwOCyt5r5NSAWDL+8QR7XRkOb6y5oSlsWLa+su4ft+jEMHd1TLWQCGtwgLS
         Hn+ILBJaLlXai0m114RY7NjwD2qTpJaqvl1eUswC50mWgY/1OiSE3lWo6nlZ9FEl0NGt
         otrI7/QT+Vr1evPZczlvMTVXLhjXigoo1kcbXCW2QhlBmUm2mDcRuMCgbxuAZ9GZj6X0
         vF9qhJj5PwvD5vls0VJEfCzC0LDv9bYWKdzn9RwgZu859ML7JNJRx2bcpUnCe1aIZAfD
         ybFg==
X-Gm-Message-State: AOJu0YyaWognTqCUM9ltlwsda5Q8vipwco80gguHopB/b983vaG9pk92
	HnBFnYQOtSUkC60EZjfo4+GlFlC59vsuoI4O2cmaHbglSYLSpPVFwk2HUsup+eXQqXx0JZMTg2/
	PzvVm3geLUpFStDyBRRF3dHUEt5c=
X-Gm-Gg: ASbGnctikfLCYo2vu4HmL+oNiDHglNRvn5cOCELRHvBGMt4U3VuvrrGPlbfNQsEmWQf
	cZ3nrHWv0TEoYa4tqnJRS0ucfEF5dacBrBTKk5V2OBjd7ecOo18dEjtJpjWePULrSA2KaMmukKI
	OHyRFo8V6Ks/3Tfyoig5tzfjFWNg==
X-Google-Smtp-Source: AGHT+IGot1D7eAdUrnMj9JTokYSdy9VR4d512J6Nxlr5OC3f6KNcAR0oKhQxQrzaVBtsq8WoZIC7eDrsGvLSfywUXwo=
X-Received: by 2002:a05:6902:1107:b0:e5d:afe5:8c21 with SMTP id
 3f1490d57ef6-e611e1bb056mr4640009276.19.1741193568378; Wed, 05 Mar 2025
 08:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304163626.1362031-1-ameryhung@gmail.com> <20250304163626.1362031-3-ameryhung@gmail.com>
 <eadb0123e2e576effbf1c7b0eac6b1da9b107fd4.camel@gmail.com>
In-Reply-To: <eadb0123e2e576effbf1c7b0eac6b1da9b107fd4.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 5 Mar 2025 08:52:36 -0800
X-Gm-Features: AQ5f1JpEc4z6nDjHbqfrj01Uusg5eIDxLnS2jFV3ri9zY46ha7KY1V8X480l4eg
Message-ID: <CAMB2axM_qcgv3Q5Ob2q2+OJwLGPaujnJQ10_TzFvkB2iYLbj2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Fix dangling stdout seen
 by traffic monitor thread
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:12=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-03-04 at 08:36 -0800, Amery Hung wrote:
> > Traffic monitor thread may see dangling stdout as the main thread close=
s
> > and reassigns stdout without protection. This happens when the main thr=
ead
> > finishes one subtest and moves to another one in the same netns_new()
> > scope.
> > The issue can be reproduced by running test_progs repeatedly with traff=
ic
> > monitor enabled:
> >
> > for ((i=3D1;i<=3D100;i++)); do
> >    ./test_progs -a flow_dissector_skb* -m '*'
> > done
> >
> > Fix it by first consolidating stdout assignment into stdio_restore().
> > stdout will be restored to env.stdout_saved when a test ends or running
> > in the crash handler and to test_state.stdout_saved otherwise.
> > Then, protect use/close/reassignment of stdout with a lock. The locking
> > in the main thread is always performed regradless of whether traffic
> > monitor is running or not for simplicity. It won't have any side-effect=
.
> > stdio_restore() is kept in the crash handler instead of making all prin=
t
> > functions in the crash handler use env.stdout_saved to make it less
> > error-prone.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> This patch fixes the error for me.
>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  tools/testing/selftests/bpf/test_progs.c | 59 ++++++++++++++++--------
> >  1 file changed, 39 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/s=
elftests/bpf/test_progs.c
> > index ab0f2fed3c58..5b89f6ca5a0a 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -88,7 +88,11 @@ static void stdio_hijack(char **log_buf, size_t *log=
_cnt)
> >  #endif
> >  }
> >
> > -static void stdio_restore_cleanup(void)
> > +static pthread_mutex_t stdout_lock =3D PTHREAD_MUTEX_INITIALIZER;
> > +
> > +static bool in_crash_handler(void);
> > +
> > +static void stdio_restore(void)
> >  {
> >  #ifdef __GLIBC__
> >       if (verbose() && env.worker_id =3D=3D -1) {
> > @@ -98,34 +102,34 @@ static void stdio_restore_cleanup(void)
> >
> >       fflush(stdout);
> >
> > -     if (env.subtest_state) {
> > +     pthread_mutex_lock(&stdout_lock);
> > +
> > +     if (!env.subtest_state || in_crash_handler()) {
> > +             if (stdout =3D=3D env.stdout_saved)
> > +                     goto out;
> > +
> > +             fclose(env.test_state->stdout_saved);
> > +             env.test_state->stdout_saved =3D NULL;
> > +             stdout =3D env.stdout_saved;
> > +             stderr =3D env.stderr_saved;
> > +     } else {
> >               fclose(env.subtest_state->stdout_saved);
> >               env.subtest_state->stdout_saved =3D NULL;
> >               stdout =3D env.test_state->stdout_saved;
> >               stderr =3D env.test_state->stdout_saved;
> > -     } else {
> > -             fclose(env.test_state->stdout_saved);
> > -             env.test_state->stdout_saved =3D NULL;
> >       }
> > +out:
> > +     pthread_mutex_unlock(&stdout_lock);
> >  #endif
> >  }
>
> stdio_restore_cleanup() did not reset stderr/stdout when
> env.subtest_state was NULL, but this difference does not seem to
> matter, stdio_restore_cleanup() was called from:
> - test__start_subtest(), where stdio_hijack_init() would override
>   stderr/stdout anyways.
> - run_one_test(), where it is followed by call to stdio_restore().
>
> I think this change is Ok.
>
> [...]
>
> > @@ -1276,6 +1281,18 @@ void crash_handler(int signum)
> >       backtrace_symbols_fd(bt, sz, STDERR_FILENO);
> >  }
> >
> > +static bool in_crash_handler(void)
> > +{
> > +     struct sigaction sigact;
> > +
> > +     /* sa_handler will be cleared if invoked since crash_handler is
> > +      * registered with SA_RESETHAND
> > +      */
> > +     sigaction(SIGSEGV, NULL, &sigact);
> > +
> > +     return sigact.sa_handler !=3D crash_handler;
> > +}
> > +
>
> The patch would be simpler w/o this function. I double checked
> functions called from crash_handler() and two 'fprintf(stderr, ...)'
> there are the only places where stderr/stdout is used instead of
> *_saved versions. It is already a prevalent pattern to do
> 'fprintf(env.stderr_saved, ...)' in this file.
> Or pass a flag as in v3?

While that is a common pattern, I think restoring stdio there can make
sure people don't accidentally use stdout in the crash handler and
find that it does not work occasionally.

I will remove the in_crash_handler special case handling per Martin's
suggestion.


>
> >  void hexdump(const char *prefix, const void *buf, size_t len)
> >  {
> >       for (int i =3D 0; i < len; i++) {
> > @@ -1957,6 +1974,8 @@ int main(int argc, char **argv)
>
> [...]
>

