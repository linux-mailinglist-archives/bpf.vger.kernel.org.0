Return-Path: <bpf+bounces-21881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1034853AFB
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115961C24160
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1701E605D0;
	Tue, 13 Feb 2024 19:33:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736B60263
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852810; cv=none; b=N14vzKCXqXrbga4LgSB/feWm7Ey0BpgW3bLrFf3ghgvJJjrtY7CQiIEFUQ9MAPbzBH+02Bqp+LNFe9FcJCaiBRttbh4MxBgpiOt72PnQwMlnY/q/mzMXoiJcj0QtWyQhhL5mpVHTWQ6120jJ4SgrOuU/QbiJnZNqMknd1nWW+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852810; c=relaxed/simple;
	bh=F996xVl3sj2k+FrjSk8r9Q2je/qHJfYmJlVhZvv+7g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H354UqINA1r6RsXlvKvYwpIZB8WMlwz8IY7Z3VEXOKg5QUSulAxLKZDTL7ew+1hFlonuGRlgHbNmdOmdlmHyHu82YqQSJwwB4eGiTG9vtSdSjdLDtydHCapIxFyTYo3E9yYEdVIx648auMqvEun5XErBw5LZ733CmaE78OiMhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-599f5e71d85so3170706eaf.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 11:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852808; x=1708457608;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP+raURNDKsVUi5K/9fj2tm0C5fpjzuikoYekTUzNOM=;
        b=EopKPPE6wJzW2HUvbKpRzZAVf+p7l4C25niYqK3ZDjcs33gV6LEqz8ReRu5L+rdVZ/
         /WY110gAbg+ZVVfwUYzdjUE5sQQUs2G35IkrzFr2QHEBA/BcEAlv6vVm68vwadQkgnqE
         Wr14/4LaXZ5IbWemvRgtrbVzrSi7ehereVQYGFiVyW4MYCJYR7QP2YdrfnJ7TNSJwdRG
         17IZVWXA1pozKJjNTF0MDFohQ1dGhPf5W2OZweR0KOVcgM+qeP5FXf1+AN8BSHYmCvzD
         Hadde3uRZ5KpgNmmPe0+PTC5BDHaj9T6S1a8wPng2zx2nWo4yKSSkuUojzGLQq0Hrkxd
         WX6A==
X-Gm-Message-State: AOJu0Yx3oY/NWm3di9FbLLbwxJQ/TurqFjN43ic5k7St1G9avDJv1jGt
	ZV3J2FZKmQzq/cMPzv/DEBWuKeN0O5L0i9g08n2XpaPQMBBFBUO5
X-Google-Smtp-Source: AGHT+IGI5eQuS2HhWSVmvP/CP0i4rE3DUWm86i3R8ewzfmu8dkTTI4ZvgDbs4j95d2Pu66BsaaJajg==
X-Received: by 2002:a05:6358:e499:b0:178:94bc:72ef with SMTP id by25-20020a056358e49900b0017894bc72efmr252485rwb.25.1707852807580;
        Tue, 13 Feb 2024 11:33:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3Fpbg+3sEmuCiy/AwDc+5HBGxj3VKA42hYk6pe3CCzg1tq8xrZfeCEyCjaLZZ8K9y10iYyNHEcBb48evpTBsSAHrr/omKtvX5HhIfBPj3wlobkpBRGNmefq8IKgxCK8rfTJSvtKd1vnTOksUc74zoMjlZqETGCXdFYS7p/Xv/UbLgAWYo220mSatEiU1QEWGzmy5y1OBbSHM8rfnQOmMUU2br55ObGiZJvX9H63kpGK1muXmnWIVDUDP4jyNQnbSCqE+LSFYlKLt2JDXxukBx0nZTGB3Oh4Vhew9o7A==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id x8-20020a05622a000800b0042c6c103f7bsm1374895qtw.37.2024.02.13.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:33:26 -0800 (PST)
Date: Tue, 13 Feb 2024 13:33:24 -0600
From: David Vernet <void@manifault.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: Re: [RFC PATCH v1 14/14] selftests/bpf: Add tests for exceptions
 runtime cleanup
Message-ID: <20240213193324.GA2453398@maniforge.lan>
References: <20240201042109.1150490-1-memxor@gmail.com>
 <20240201042109.1150490-15-memxor@gmail.com>
 <20240212205314.GC2200361@maniforge.lan>
 <CAP01T76hX2jxHiJ_iiWSj7Wgu5t4RL48-eLGJmEtik9GR0rq6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOh5rHN0C6zXnctf"
Content-Disposition: inline
In-Reply-To: <CAP01T76hX2jxHiJ_iiWSj7Wgu5t4RL48-eLGJmEtik9GR0rq6g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--BOh5rHN0C6zXnctf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:43:42PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Mon, 12 Feb 2024 at 21:53, David Vernet <void@manifault.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 04:21:09AM +0000, Kumar Kartikeya Dwivedi wrote:
> > > Add tests for the runtime cleanup support for exceptions, ensuring th=
at
> > > resources are correctly identified and released when an exception is
> > > thrown. Also, we add negative tests to exercise corner cases the
> > > verifier should reject.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
> > >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> > >  .../bpf/prog_tests/exceptions_cleanup.c       |  65 +++
> > >  .../selftests/bpf/progs/exceptions_cleanup.c  | 468 ++++++++++++++++=
++
> > >  .../bpf/progs/exceptions_cleanup_fail.c       | 154 ++++++
> > >  .../selftests/bpf/progs/exceptions_fail.c     |  13 -
> > >  6 files changed, 689 insertions(+), 13 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions=
_cleanup.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_clea=
nup.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_clea=
nup_fail.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/tes=
ting/selftests/bpf/DENYLIST.aarch64
> > > index 5c2cc7e8c5d0..6fc79727cd14 100644
> > > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > > @@ -1,6 +1,7 @@
> > >  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link=
_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> > >  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link=
_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> > >  exceptions                                    # JIT does not support=
 calling kfunc bpf_throw: -524
> > > +exceptions_unwind                             # JIT does not support=
 calling kfunc bpf_throw: -524
> > >  fexit_sleep                                      # The test never re=
turns. The remaining tests cannot start.
> > >  kprobe_multi_bench_attach                        # needs CONFIG_FPRO=
BE
> > >  kprobe_multi_test                                # needs CONFIG_FPRO=
BE
> > > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testi=
ng/selftests/bpf/DENYLIST.s390x
> > > index 1a63996c0304..f09a73dee72c 100644
> > > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > > @@ -1,5 +1,6 @@
> > >  # TEMPORARY
> > >  # Alphabetical order
> > >  exceptions                            # JIT does not support calling=
 kfunc bpf_throw                                (exceptions)
> > > +exceptions_unwind                     # JIT does not support calling=
 kfunc bpf_throw                                (exceptions)
> > >  get_stack_raw_tp                         # user_stack corrupted user=
 stack                                             (no backchain userspace)
> > >  stacktrace_build_id                      # compare_map_keys stackid_=
hmap vs. stackmap err -2 errno 2                   (?)
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanu=
p.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> > > new file mode 100644
> > > index 000000000000..78df037b60ea
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> > > @@ -0,0 +1,65 @@
> > > +#include "bpf/bpf.h"
> > > +#include "exceptions.skel.h"
> > > +#include <test_progs.h>
> > > +#include <network_helpers.h>
> > > +
> > > +#include "exceptions_cleanup.skel.h"
> > > +#include "exceptions_cleanup_fail.skel.h"
> > > +
> > > +static void test_exceptions_cleanup_fail(void)
> > > +{
> > > +     RUN_TESTS(exceptions_cleanup_fail);
> > > +}
> > > +
> > > +void test_exceptions_cleanup(void)
> > > +{
> > > +     LIBBPF_OPTS(bpf_test_run_opts, ropts,
> > > +             .data_in =3D &pkt_v4,
> > > +             .data_size_in =3D sizeof(pkt_v4),
> > > +             .repeat =3D 1,
> > > +     );
> > > +     struct exceptions_cleanup *skel;
> > > +     int ret;
> > > +
> > > +     if (test__start_subtest("exceptions_cleanup_fail"))
> > > +             test_exceptions_cleanup_fail();
> >
> > RUN_TESTS takes care of doing test__start_subtest(), etc. You should be
> > able to just call RUN_TESTS(exceptions_cleanup_fail) directly here.
> >
>=20
> Ack, will fix.
>=20
> > > +
> > > +     skel =3D exceptions_cleanup__open_and_load();
> > > +     if (!ASSERT_OK_PTR(skel, "exceptions_cleanup__open_and_load"))
> > > +             return;
> > > +
> > > +     ret =3D exceptions_cleanup__attach(skel);
> > > +     if (!ASSERT_OK(ret, "exceptions_cleanup__attach"))
> > > +             return;
> > > +
> > > +#define RUN_EXC_CLEANUP_TEST(name)                                  =
    \
> >
> > Should we add a call to if (test__start_subtest(#name)) to this macro?
> >
>=20
> Makes sense, will change this.
>=20
> > > [...]
> > > +
> > > +SEC("tc")
> > > +int exceptions_cleanup_percpu_obj(struct __sk_buff *ctx)
> > > +{
> > > +    struct { int i; } *p;
> > > +
> > > +    p =3D bpf_percpu_obj_new(typeof(*p));
> > > +    MARK_RESOURCE(&p, RES_SPILL);
> > > +    bpf_throw(VAL);
> >
> > It would be neat if we could have the bpf_throw() kfunc signature be
> > marked as __attribute__((noreturn)) and have things work correctly;
> > meaning you wouldn't have to even return a value here. The verifier
> > should know that bpf_throw() is terminal, so it should be able to prune
> > any subsequent instructions as unreachable anyways.
> >
>=20
> Originally, I was tagging the kfunc as noreturn, but Alexei advised
> against it in
> https://lore.kernel.org/bpf/CAADnVQJtUD6+gYinr+6ensj58qt2LeBj4dvT7Cyu-aBC=
afsP5g@mail.gmail.com
> ... so I have dropped it since.

I see. Ok, we can ignore this for now, though I think we should consider
revisiting this at some point once we've clarified the rules behind the
implicit prologue/epilogue. Being able to actually specify noreturn
really can make a difference in performance in some cases.

> Right now, the verifier will do dead code elimination ofcourse, but
> sometimes the compiler does generate code that is tricky or unexpected
> (like putting the bpf_throw instruction as the final one instead of
> exit or jmp if somehow it can prove that bpf_throw will be taken by
> all paths) for the verifier if the bpf_throw is noreturn. Even though

Got it. As long as the verifier does dead-code elimination on that path,
that's really the most important thing.

> this would have the same effect at runtime (if the analysis of the
> compiler is not wrong), there were some places we would have to modify
> so that the compiler does not get confused.
>=20
> Overall I'm not opposed to this, but I think we need more consensus
> before flipping the flag. Since this can be changed later and the
> necessary changes can be made in the verifier (just a couple of places
> which expect exit or jmp to final insns), I decided to move ahead
> without noreturn.

Understood, thanks for explaining. Leaving off noreturn for now is fine
with me.

> > > +    return !p;
> > > +}
> > > +
> > > +SEC("tc")
> > > +int exceptions_cleanup_ringbuf(struct __sk_buff *ctx)
> > > +{
> > > +    void *p;
> > > +
> > > +    p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> > > +    MARK_RESOURCE(&p, RES_SPILL);
> > > +    bpf_throw(VAL);
> > > +    return 0;
> > > +}
> > > +
> > > +SEC("tc")
> > > +int exceptions_cleanup_reg(struct __sk_buff *ctx)
> > > +{
> > > +    void *p;
> > > +
> > > +    p =3D bpf_ringbuf_reserve(&ringbuf, 8, 0);
> > > +    MARK_RESOURCE(p, RES_REG);
> > > +    bpf_throw(VAL);
> > > +    if (p)
> > > +        bpf_ringbuf_discard(p, 0);
> >
> > Does the prog fail to load if you don't have this bpf_ringbuf_discard()
> > check? I assume not given that in
> > exceptions_cleanup_null_or_ptr_do_ptr() and elsewhere we do a reserve
> > without discarding. Is there some subtle stack state difference here or
> > something?
> >
>=20
> So I will add comments explaining this, since I realized this confused
> you in a couple of places, but basically if I didn't do a discard
> here, the compiler wouldn't save the value of p across the bpf_throw
> call. So it may end up in some caller-saved register (R1-R5) and since
> bpf_throw needs things to be either saved in the stack or in
> callee-saved regs (R6-R9) to be able to do the stack unwinding, we
> would not be able to test the case where the resource is held in
> R6-R9.
>=20
> In a correctly written program, in the path where bpf_throw is not
> done, you will always have some cleanup code (otherwise your program
> wouldn't pass), so the value should always end up being preserved
> across a bpf_throw call (this is kind of why Alexei was sort of
> worried about noreturn, because in that case the compiler may decide
> to not preserve it for the bpf_throw path).
> You cannot just leak a resource acquired before bpf_throw in the path
> where exception is not thrown.

Ok, that makes sense. I suppose another way to frame this would be to
consider it in a typical scheduling scenario:

struct task_ctx *lookup_task_ctx(struct task_struct *p)
{
	struct task_ctx *taskc;
	s32 pid =3D p->pid;

	taskc =3D bpf_map_lookup_elem(&task_data, &pid);
	if (!taskc)
		bpf_throw(-ENOENT); // Verifier=20

	return taskc;
}

void BPF_STRUCT_OPS(sched_stopping, struct task_struct *p, bool runnable)
{
	struct task_ctx *taskc;

	taskc =3D lookup_task_ctx(p)

	/* scale the execution time by the inverse of the weight and charge */
	p->scx.dsq_vtime +=3D
		(bpf_ktime_get_ns() - taskc->running_at) * 100 / p->scx.weight;
}

We're not dropping a reference here, but taskc is preserved across the
bpf_throw() path, so the same idea applies.

> Also,  I think the test is a bit fragile, I should probably rewrite it
> in inline assembly, because while the compiler chooses to hold it in a
> register here, it is not bound to do so in this case.

To that point, I wonder if it would be useful or possible to come up with s=
ome
kind of a macro that allows us to specify a list of variables that must be
preserved after a bpf_throw() call? Not sure how or if that would work exac=
tly.

> > >  [...]
> > >
> > > -SEC("?tc")
> > > -__failure __msg("Unreleased reference")
> > > -int reject_with_reference(void *ctx)
> > > -{
> > > -     struct foo *f;
> > > -
> > > -     f =3D bpf_obj_new(typeof(*f));
> > > -     if (!f)
> > > -             return 0;
> > > -     bpf_throw(0);
> >
> > Hmm, so why is this a memory leak exactly? Apologies if this is already
> > explained clearly elsewhere in the stack.
> >
>=20
> I will add comments around some of these to better explain this in the
> non-RFC v1.
> Basically, this program is sort of unrealistic (since it's always
> throwing, and not really cleaning up the object since there is no
> other path except the one with bpf_throw). So the compiler ends up
> putting 'f' in a caller-saved register, during release_reference we
> don't find it after bpf_throw has been processed (since caller-saved
> regs have been cleared due to kfunc processing, and we generate frame
> descriptors after check_kfunc_call, basically simulating the state
> where only preserved state after the call is observed at runtime), but
> the reference state still lingers around for 'f', so you get this
> "Unreleased reference" error later when check_reference_leak is hit.
>=20
> It's just trying to exercise the case where the pointer tied to a
> reference state has been lost in verifier state, and that we return an
> error in such a case and don't succeed in verifying the program
> accidently (because there is no way we can recover the value to free
> at runtime).

Makes total sense, thanks a lot for explaining!

This looks great, I'm really excited to use it.

--BOh5rHN0C6zXnctf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcvEBAAKCRBZ5LhpZcTz
ZCLRAP423S8M2/7k9Z2R5LIXmquxmuYusQJFF2z8b/GTav9ilwD+Pvt7lSDXSjcq
YIt5AoISjhf1XdzGPBgD5NO+dlz/Tgc=
=jeJD
-----END PGP SIGNATURE-----

--BOh5rHN0C6zXnctf--

