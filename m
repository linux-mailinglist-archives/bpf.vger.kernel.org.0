Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDB479205
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 17:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbhLQQzg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 11:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbhLQQzg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 11:55:36 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Dec 2021 08:55:36 PST
Received: from mail.smart-cactus.org (schildkroeter.smart-cactus.org [IPv6:2a01:4f8:161:4431::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5AC06173E;
        Fri, 17 Dec 2021 08:55:36 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2001:470:e438:2:747b:446d:1213:d2e0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: ben@smart-cactus.org)
        by mail.smart-cactus.org (Postfix) with ESMTPSA id 73C32A5C05ED;
        Fri, 17 Dec 2021 16:45:34 +0000 (UTC)
Date:   Fri, 17 Dec 2021 11:45:32 -0500
From:   Ben Gamari <ben@smart-cactus.org>
To:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Sampling of non-C-like stacks with eBPF and perf_events?
Message-ID: <87o85ftc3p.fsf@smart-cactus.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi all,

I have recently been exploring the possibility of using a
BPF_PROG_TYPE_PERF_EVENT program to implement stack sampling for
languages which do not use the platform's %sp for their stack pointer
(in my case, GHC/Haskell [1], which on x86-64 uses %rbp for its stack
pointer). Specifically, the idea is to use a sampling perf_events
session with an eBPF overflow handler which locates the
currently-running thread's stack and records it in the sample ringbuffer
(see [2] for my current attempt). At this point I only care about
user-space samples.

However, I quickly ran up against the fact that perf_event's stack
sampling logic (namely perf_output_sample_ustack) is called from an IRQ
context. This appears to preclude use of a sleepable BPF program, which
would be necessary to use bpf_copy_from_user. Indeed, the fact that the
usual stack sampling logic uses copy_from_user_inatomic rather than
copy_from_user suggests that this isn't a safe context for sleeping.

So, I'm at this point a bit unclear on how to proceed. I can see a few
possible directions forward, although none are particularly enticing:

* Add a bpf_copy_from_user_atomic helper, which can be called from a
  non-sleepable context like a perf_events overflow handler. This would
  take the same set_fs() and pagefault_disable() precautions as
  perf_output_sample_ustack to ensure that the access is safe and aborts
  on fault.

* Introduce a new BPF program type,
  BPF_PROG_TYPE_PERF_EVENT_STACK_LOCATOR, which can be invoked by
  perf_output_sample_ustack to locate the stack to be sampled.

Do either of these ideas sound upstreamable? Perhaps there are other
ideas on how to attack this general problem? I do not believe Haskell is
alone in its struggle with the current inflexibility of stack sampling;
the JVM introduced framepointer support specifically to allow callgraph
sampling; however, dedicating a register and code to this seems like an
unfortunate compromise, especially on x86-64 where registers are already
fairly precious.

Any thoughts or suggestions would be greatly appreciated.

Cheers,

- Ben


[1] https://www.haskell.org/ghc/
[2] https://gitlab.haskell.org/bgamari/hs-bpf-prof/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEg5ai+U8IKhnDQZiPCIdltPrJkTcFAmG8vnoACgkQCIdltPrJ
kTfukgf+N739FsXjUEqkJe2kzicnVWpjtKXBg0vSuRb/uSh3IBQLzZEA7U85unXU
dKSNVBrrVS7XsD7IJzt27xGAMEDS7eOLyLg/ih7L2Kvt0wBCnTEg9jyUOBxWhtyl
uel34RDSAbyrQmxzstV2LhEbCQ0BA3a9BVO1M/Y8TDjS8cPJ8q8sD6PPo5ipucnQ
OEX41gGdNx8hLTl0HKQtBcdE2+rwheZ+H2dMpCiPFpCci5TIce1A+BmHolodV4Vf
Wd2llcFp9oPzCPEGytv3G/TJ9/bkkKof8A9wVANYLw7Fxp+D+e8pgxJIFYjIRV7/
My9hztP6fDmeNsxq+7/OYhWDiUYGSw==
=tF2b
-----END PGP SIGNATURE-----
--=-=-=--
