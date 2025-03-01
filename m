Return-Path: <bpf+bounces-52946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 400EEA4A6DF
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63685189CCBF
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E20610FD;
	Sat,  1 Mar 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9J3Brj5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DA635
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787867; cv=none; b=qJrvvhJa9xUSGSCKIyhvj0MSMqc3JliHjWTzEAi3s2vcYSb0IS0c9sHJVjcD/GPw/FvnZR0s4nRtRsjnuLblL3tgtBvf64OTt5eTq85Uf+DT4y6wT/Sf1VSd/6zQMYq9Zzg8DmdkaOieL2vUdODFoJa3XOQZZkZOSH+be2lFbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787867; c=relaxed/simple;
	bh=wCI/fLJ/js5si3AZU6eBHuF2jBzTHpV/Ga69xUzQrRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5Ykr6HFR26KefnlL5uW6FM+avOFzQP/DnUAKEaZqzIJSbExEvD9ypNdRV7ARb0HJev3oTzIm4JEmN4NrZmzLKtRcLKRgvwtsqo0itRnUsAKCqC19jxUS/tcsOeeCbEEwUcJW4innDgEKU3BFUu09H7EJ9JdewzFY32CrL62p9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9J3Brj5; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd4dcf2df7so10158937b3.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740787865; x=1741392665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zExPPOYo7ewGG6sx0vm/h/xblISg1sq86nRoloFFxK4=;
        b=m9J3Brj5INVNIKPIabkZGFxxEz/YTDPTqnvx4Y5RxbkZrsyoj+uby2JXBL8IvrwXcV
         jUPJ8x00dDNzf0GbgcplKiqyuuGQLjMen3hFaD1Ko9AOJwW2j+ibIf9cDOXuSy+Y0zBR
         4+fbE5othx84hzJJ952ahNX7YudX2wBYilpjDPRnYF0mDJuHu/CvsgquxJ6yyYf1fU16
         umSyeLlVkiKPVFloKKDnMpfIW3PAuqtONMydUTyP79KaRnbmaXEhFOBoaFXulMYbef+s
         apV96ZP5+vhyksKvvcA6qPrrTgscxi9eqmB6oQ+eK9sW6Ia0Ai1wPls7e733t/0RfXt0
         OPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787865; x=1741392665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zExPPOYo7ewGG6sx0vm/h/xblISg1sq86nRoloFFxK4=;
        b=BfrQRVLK2ZcfyAsI6CJJyU0tvmUbKm7F8d4TenIu13Wy2/KYXjoa5IB7k0OsFV+Zzk
         w85464beh/xZioATK56Lw91yDfwoZPTdmaPpxoNfIY6zBTKS9TQc7hM7zHLgHJYKDVxh
         iztSc5RYaOKYw7sww4T1p45cp/UOpicWzb8ZzzLF/xyIeInpHrjaFds9rwpJ9PF7+FrQ
         dSTYezuNRcx+bI26YEaoN/YfxuPoOySj+rR0L55H9WoPKSerzYYAleSnwl6iQxYMQYPg
         yxgUmAFtxKvo4FoG4xjcR7I/okDY9mua2lTzRhTXinEFY0H2Z2OHPol5lS6Jh0jOnT9u
         Qz/g==
X-Forwarded-Encrypted: i=1; AJvYcCXSwMhnLVNEdBWF5YUEGLKX0HXkp0ljLj9fYc3LB0dLdttiE3V1uPYNyJ5c2pA3bqDsfqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXlipExZVUsxg+toPvqSpM87l5lMlAr6SfJytU7ds+QPH8gad
	l03VLKnMKtOZ89970xf5z24ISJyZ/F9liNzwFtDeWa9ycXmDeS4RZlJpreZX0/X1WhiuDJ6whYi
	b28tKLeMwHF+P4QV7A2/gLMMTv5I=
X-Gm-Gg: ASbGncuuMlUl5wNbY04fMdwLnCSUar9F2/I7gXIn2P5EKHVa8/eeH4GTWTZp5qSKlWR
	SBlRJPe+VE38zYaPsrQon44Fej1Wh/uhxPeeBHXNcrmSvucvSnCbps2jvreC8BEPGRk8RsaoWmu
	i+82bP5AI0RbCgl6V6utmoN/wcvg==
X-Google-Smtp-Source: AGHT+IGPbekE0Jk8hU0Uc5RC3jOaavc3hYzL69H2Xx5yUsJh4YEds9haei6HD2/g5LeR55mPqP1oePz1b/8GEVKjXfM=
X-Received: by 2002:a05:690c:4801:b0:6f7:5a46:fe5f with SMTP id
 00721157ae682-6fd4a03af9fmr74763877b3.1.1740787864893; Fri, 28 Feb 2025
 16:11:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227222336.2236460-1-ameryhung@gmail.com> <96e57b71-169e-4534-b3af-d44df2b54a0b@linux.dev>
In-Reply-To: <96e57b71-169e-4534-b3af-d44df2b54a0b@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 28 Feb 2025 16:10:54 -0800
X-Gm-Features: AQ5f1Jo2gBzVlJ2rnjgbJ5f3-7uQNFuoVn3NM5Jz2dWxgkOv3MGUg2IlKtiOeBw
Message-ID: <CAMB2axOB1Q50g3avDKU1u=gw0TeGJtZ9yFP807EYT=S1igC4QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] selftests/bpf: Fix dangling stdout seen
 by traffic monitor thread
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:30=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/27/25 2:23 PM, Amery Hung wrote:
> > Traffic monitor thread may see dangling stdout as the main thread close=
s
> > and reassigns stdout without protection. This happens when the main thr=
ead
> > finishes one subtest and moves to another one in the same netns_new()
> > scope. Fix it by first consolidating stdout assignment into
> > stdio_restore_cleanup() and then protecting the use/close/reassignment =
of
> > stdout with a lock. The locking in the main thread is always performed
> > regradless of whether traffic monitor is running or not for simplicity.
> > It won't have any side-effect.
> >
> > The issue can be reproduced by running test_progs repeatedly with traff=
ic
> > monitor enabled:
> >
> > for ((i=3D1;i<=3D100;i++)); do
> >     ./test_progs -a flow_dissector_skb* -m '*'
> > done
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   tools/testing/selftests/bpf/network_helpers.c |  8 ++++-
> >   tools/testing/selftests/bpf/network_helpers.h |  6 ++--
> >   tools/testing/selftests/bpf/test_progs.c      | 29 +++++++++++++-----=
-
> >   3 files changed, 31 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/test=
ing/selftests/bpf/network_helpers.c
> > index 737a952dcf80..5014fd063d67 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.c
> > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > @@ -743,6 +743,7 @@ struct tmonitor_ctx {
> >       pcap_t *pcap;
> >       pcap_dumper_t *dumper;
> >       pthread_t thread;
> > +     pthread_mutex_t *stdout_lock;
> >       int wake_fd;
> >
> >       volatile bool done;
> > @@ -953,6 +954,7 @@ static void *traffic_monitor_thread(void *arg)
> >               ifindex =3D ntohl(ifindex);
> >               ptype =3D packet[10];
> >
> > +             pthread_mutex_lock(ctx->stdout_lock);
> >               if (proto =3D=3D ETH_P_IPV6) {
> >                       show_ipv6_packet(payload, ifindex, ptype);
> >               } else if (proto =3D=3D ETH_P_IP) {
> > @@ -967,6 +969,7 @@ static void *traffic_monitor_thread(void *arg)
> >                       printf("%-7s %-3s Unknown network protocol type 0=
x%x\n",
> >                              ifname, pkt_type_str(ptype), proto);
> >               }
> > +             pthread_mutex_unlock(ctx->stdout_lock);
> >       }
> >
> >       return NULL;
> > @@ -1055,7 +1058,8 @@ static void encode_test_name(char *buf, size_t le=
n, const char *test_name, const
> >    * in the give network namespace.
> >    */
> >   struct tmonitor_ctx *traffic_monitor_start(const char *netns, const c=
har *test_name,
> > -                                        const char *subtest_name)
> > +                                        const char *subtest_name,
> > +                                        pthread_mutex_t *stdout_lock)
>
> Thinking out loud here and see if the following will be better than passi=
ng a
> pthread_mutex_t.
>
> How about passing a print function pointer instead and this function can =
do what
> is needed before printf(), i.e. lock mutex here. Something like the
> "libbpf_print_fn_t __libbpf_pr" in libbpf.c.
>
> May be the test_progs.c can set it once by calling tm_set_print (similar =
to
> libbpf_set_print) instead of passing as an arg during every traffic_monit=
or_start().
>
> wdyt?
>

I think that will be cleaner. Especially explicit
pthread_mutext_lock/unlock() can then be removed from traffic monitor.
I will change to passing a print function pointer from test_progs.c to
traffic monitor.

> >   {
> >       struct nstoken *nstoken =3D NULL;
> >       struct tmonitor_ctx *ctx;
> > @@ -1109,6 +1113,8 @@ struct tmonitor_ctx *traffic_monitor_start(const =
char *netns, const char *test_n
> >               goto fail_eventfd;
> >       }
> >
> > +     ctx->stdout_lock =3D stdout_lock;
> > +
> >       r =3D pthread_create(&ctx->thread, NULL, traffic_monitor_thread, =
ctx);
> >       if (r) {
> >               log_err("Failed to create thread");
> > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/test=
ing/selftests/bpf/network_helpers.h
> > index 9f6e05d886c5..b80954eab8d8 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.h
> > +++ b/tools/testing/selftests/bpf/network_helpers.h
> > @@ -251,11 +251,13 @@ struct tmonitor_ctx;
> >
> >   #ifdef TRAFFIC_MONITOR
> >   struct tmonitor_ctx *traffic_monitor_start(const char *netns, const c=
har *test_name,
> > -                                        const char *subtest_name);
> > +                                        const char *subtest_name,
> > +                                        pthread_mutex_t *stdout_lock);
> >   void traffic_monitor_stop(struct tmonitor_ctx *ctx);
> >   #else
> >   static inline struct tmonitor_ctx *traffic_monitor_start(const char *=
netns, const char *test_name,
> > -                                                      const char *subt=
est_name)
> > +                                                      const char *subt=
est_name,
> > +                                                      pthread_mutex_t =
*stdout_lock)
> >   {
> >       return NULL;
> >   }
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/s=
elftests/bpf/test_progs.c
> > index 0cb759632225..db9ea69e8ba1 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -88,7 +88,9 @@ static void stdio_hijack(char **log_buf, size_t *log_=
cnt)
> >   #endif
> >   }
> >
> > -static void stdio_restore_cleanup(void)
> > +static pthread_mutex_t stdout_lock =3D PTHREAD_MUTEX_INITIALIZER;
> > +
> > +static void stdio_restore_cleanup(bool restore_default)
> >   {
> >   #ifdef __GLIBC__
> >       if (verbose() && env.worker_id =3D=3D -1) {
> > @@ -98,15 +100,25 @@ static void stdio_restore_cleanup(void)
> >
> >       fflush(stdout);
> >
> > +     pthread_mutex_lock(&stdout_lock);
> > +
> >       if (env.subtest_state) {
> >               fclose(env.subtest_state->stdout_saved);
> >               env.subtest_state->stdout_saved =3D NULL;
> > -             stdout =3D env.test_state->stdout_saved;
> > -             stderr =3D env.test_state->stdout_saved;
> >       } else {
> >               fclose(env.test_state->stdout_saved);
> >               env.test_state->stdout_saved =3D NULL;
> >       }
> > +
> > +     if (restore_default) {
>
> Why a new "bool restore_default" is needed? Testing env.subtest_state is =
not enough?
>

If a crash happens during a subtest, env.subtest_state will still be
set and stdout and stderr will not be restored to the default ones.

Thanks,
Amery

> Thanks for debugging this.
>
> > +             stdout =3D env.stdout_saved;
> > +             stderr =3D env.stderr_saved;
> > +     } else if (env.subtest_state) {
> > +             stdout =3D env.test_state->stdout_saved;
> > +             stderr =3D env.test_state->stdout_saved;
> > +     }
> > +
> > +     pthread_mutex_unlock(&stdout_lock);
> >   #endif
> >   }
> >
> > @@ -121,10 +133,7 @@ static void stdio_restore(void)
> >       if (stdout =3D=3D env.stdout_saved)
> >               return;
> >
> > -     stdio_restore_cleanup();
> > -
> > -     stdout =3D env.stdout_saved;
> > -     stderr =3D env.stderr_saved;
> > +     stdio_restore_cleanup(true);
> >   #endif
> >   }
> >
> > @@ -541,7 +550,8 @@ void test__end_subtest(void)
> >                                  test_result(subtest_state->error_cnt,
> >                                              subtest_state->skipped));
> >
> > -     stdio_restore_cleanup();
> > +     stdio_restore_cleanup(false);
> > +
> >       env.subtest_state =3D NULL;
> >   }
> >
> > @@ -779,7 +789,8 @@ struct netns_obj *netns_new(const char *nsname, boo=
l open)
> >           (env.subtest_state && env.subtest_state->should_tmon)) {
> >               test_name =3D env.test->test_name;
> >               subtest_name =3D env.subtest_state ? env.subtest_state->n=
ame : NULL;
> > -             netns_obj->tmon =3D traffic_monitor_start(nsname, test_na=
me, subtest_name);
> > +             netns_obj->tmon =3D traffic_monitor_start(nsname, test_na=
me, subtest_name,
> > +                                                     &stdout_lock);
> >               if (!netns_obj->tmon) {
> >                       fprintf(stderr, "Failed to start traffic monitor =
for %s\n", nsname);
> >                       goto fail;
>

