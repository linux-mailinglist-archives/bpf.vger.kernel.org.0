Return-Path: <bpf+bounces-31790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA3F9036D3
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC881C20C0C
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC4917BB0B;
	Tue, 11 Jun 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Frno7iWp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjgjKKe7"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571B17B512;
	Tue, 11 Jun 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095164; cv=none; b=N5CuhUxXcv+YqjQk2+L+w0zVAEAeFAVE+u4V9mf1xAwxkR/YRkOgSjkt4Ij9XK75pON4GfYZatkpVP2ZvWFow2rZucX1vwn0ukm2B5DYFmcB3uzW2P7akPs5PRKDEDhk+cR2lCn5PydjfPrbVgdnAUF59/n7bvkkRU3fjmn0BNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095164; c=relaxed/simple;
	bh=1h24dx2JKVjERM1QFoE+eH8jakyUv1BrkTo7u7Cy1mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcSka17IjBTtGnMJ9XvKPlU3bgyFAqyxe04H2rBnx6glJ7AsSFTCYjkSkRydOL75wplXzBz4CmaH643LQT5h1dmdjAC2uNFglG0a/5JdW/5jbZAEMHGol4a5ZiIUWChVAbS7ToUum3ZJ/eDZyDFF6ZbyrnoKWdomIp7rNzQ+EAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Frno7iWp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjgjKKe7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 10:39:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718095160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuXplidRVKDZsJB5bk5rseBUPZqBqoh+LVXPB8Cujkk=;
	b=Frno7iWpRpQcFkYJT4zVH82bPmWO9D4syoqcbYICV1B9X6BdEK26OvmZiDQt4X96TJQqNu
	rjuJKpP9MxJbHqEWnWz9T4UAsM4uPkm6mUQQRDypZz2LG3TWurTQQWMSccuJ/0jdKgUoEx
	n2cRMvY+w+rkHRHGSVdX1CBiIpvZYyXdMM5D2DIFXQ6BwW4/Gv/keDyXK1tHQeek+jLCMp
	sFYodGZ4kON3mJp1KgDWWyvJyxfctiGcRoUZSbFa1jKkwwUEBPTtcS3CvMBaZrbyBvzXDd
	X66aHOfb36YVeaTO+uWfV2rsX2fKh8DOhpCTfKU98o+TSw3dhvVb6Nc9bSQu1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718095160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuXplidRVKDZsJB5bk5rseBUPZqBqoh+LVXPB8Cujkk=;
	b=IjgjKKe7IawJ4noewwKXmuCDbEdTRZBn5m43lPRy2ZCuZWwvDh6HUY0DPpXwS8YWPWtuJS
	rR2yAxB3OF7kofAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240611083918.fJTJJtBu@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
 <20240607070427.1379327-15-bigeasy@linutronix.de>
 <045e3716-3c3a-4238-b38a-3616c8974e2c@kernel.org>
 <20240610165014.uWp_yZuW@linutronix.de>
 <18328cc2-c135-4b69-8c5f-cd45998e970f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <18328cc2-c135-4b69-8c5f-cd45998e970f@kernel.org>

On 2024-06-11 09:55:11 [+0200], Jesper Dangaard Brouer wrote:
> > For gcc the stosq vs movq depends on the CPU settings. The generic uses
> > movq up to 40 bytes, skylake uses movq even for 64bytes. clang=E2=80=A6
> > This could be tuned via -mmemset-strategy=3Dlibcall:64:align,rep_8byte:=
-1:align
> >=20
>=20
> Cool I didn't know of this tuning.  Is this a compiler option?
> Where do I change this setting, as I would like to experiment with this
> for our prod kernels.

This is what I play with right now, I'm not sure it is what I want=E2=80=A6=
 For
reference:

---->8-----
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d7122a1883e8..b35b7b21598de 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -775,6 +775,9 @@ config SCHED_OMIT_FRAME_POINTER
=20
 	  If in doubt, say "Y".
=20
+config X86_OPT_MEMSET
+	bool "X86 memset playground"
+
 menuconfig HYPERVISOR_GUEST
 	bool "Linux guest support"
 	help
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 801fd85c3ef69..bab37787fe5cd 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -151,6 +151,15 @@ else
         KBUILD_AFLAGS +=3D -m64
         KBUILD_CFLAGS +=3D -m64
=20
+	ifeq ($(CONFIG_X86_OPT_MEMSET),y)
+		#export X86_MEMSET_CFLAGS :=3D -mmemset-strategy=3Dlibcall:64:align,rep_=
8byte:-1:align
+		export X86_MEMSET_CFLAGS :=3D -mmemset-strategy=3Dlibcall:-1:align
+	else
+		export X86_MEMSET_CFLAGS :=3D
+	endif
+
+        KBUILD_CFLAGS +=3D $(X86_MEMSET_CFLAGS)
+
         # Align jump targets to 1 byte, not the default 16 bytes:
         KBUILD_CFLAGS +=3D $(call cc-option,-falign-jumps=3D1)
=20
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 215a1b202a918..d0c9a589885ef 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -121,6 +121,7 @@ KBUILD_CFLAGS_32 :=3D $(filter-out -m64,$(KBUILD_CFLAGS=
))
 KBUILD_CFLAGS_32 :=3D $(filter-out -mcmodel=3Dkernel,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 :=3D $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 :=3D $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 :=3D $(filter-out $(X86_MEMSET_CFLAGS),$(KBUILD_CFLAGS_32=
))
 KBUILD_CFLAGS_32 :=3D $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32=
))
 KBUILD_CFLAGS_32 :=3D $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_3=
2))
 KBUILD_CFLAGS_32 :=3D $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))


---->8-----

I dug this up in the gcc source code and initially played on the command
line with it. The snippet compiles the kernel and it boots so=E2=80=A6

> My other finding is, this primarily a kernel compile problem, because
> for userspace compiler chooses to use MMX instructions (e.g. movaps
> xmmword ptr[rsp], xmm0).  The kernel compiler options (-mno-sse -mno-mmx
> -mno-sse2 -mno-3dnow -mno-avx) disables this, which aparently changes
> the tipping point.

sure.

>=20
> > I folded this into the last two patches:
> >=20
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index d2b4260d9d0be..1588d208f1348 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -744,27 +744,40 @@ struct bpf_redirect_info {
> >   	struct bpf_nh_params nh;
> >   };
> > +enum bpf_ctx_init_type {
> > +	bpf_ctx_ri_init,
> > +	bpf_ctx_cpu_map_init,
> > +	bpf_ctx_dev_map_init,
> > +	bpf_ctx_xsk_map_init,
> > +};
> > +
> >   struct bpf_net_context {
> >   	struct bpf_redirect_info ri;
> >   	struct list_head cpu_map_flush_list;
> >   	struct list_head dev_map_flush_list;
> >   	struct list_head xskmap_map_flush_list;
> > +	unsigned int flags;
>=20
> Why have yet another flags variable, when we already have two flags in
> bpf_redirect_info ?

Ah you want to fold this into ri member including the status for the
lists? Could try. It is splitted in order to delay the initialisation of
the lists, too. We would need to be careful to not overwrite the
flags if `ri' is initialized after the lists. That would be the case
with CONFIG_DEBUG_NET=3Dy and not doing redirect (the empty list check
initializes that).

Sebastian

