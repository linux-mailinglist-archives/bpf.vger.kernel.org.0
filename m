Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33905A2C6B
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiHZQhc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbiHZQhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:37:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3232DF084;
        Fri, 26 Aug 2022 09:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73FDAB831D7;
        Fri, 26 Aug 2022 16:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EE5C433D6;
        Fri, 26 Aug 2022 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661531848;
        bh=77z6JnzJcw0ptfDeQMykFv551L6QZ4YbBkOoz1WpbwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gU01zDd8ALXOBQlVbXTe206SWPFY9qPBFkEhBemYX72iQk9K1axPp9THSEvAc1/gT
         uxXzhRltVlWxo8xJz6XIjv5UxDk/7Fjz0NzfOtkuRPCBwwioUOcb873QVtoaS/skva
         uErbBhFGq2aMoZRZaFJIYwt7lPnQnUqZbVOoqmg4BbJD4X1Zr9ywrxQFk0AN/xuaYO
         /4/9hTV0UY0CLw0/QgRJ2/OeLPmNhQcxjHinFohAKlZhSw2miZHTlEqzCMOXLCaung
         h/BijBmdSsTmbI4cwJUQQTIKMjB1X2tEZ+gErKV7PtUlxr7wuwZLEauGHn3ipT+KaZ
         O31m6c64QMJhg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16D9E404A1; Fri, 26 Aug 2022 13:37:24 -0300 (-03)
Date:   Fri, 26 Aug 2022 13:37:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <Ywj2xCPATz1qb0lC@kernel.org>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org>
 <YwjQDBovX+cX/JDJ@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwjQDBovX+cX/JDJ@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Aug 26, 2022 at 03:52:12PM +0200, Jiri Olsa escreveu:
> On Fri, Aug 26, 2022 at 05:59:44AM +0300, Vitaly Chikunov wrote:
> > On Fri, Aug 26, 2022 at 05:52:20AM +0300, Vitaly Chikunov wrote:
> > > On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
> > > > On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > > > I also noticed that after upgrading pahole to v1.24 kernel build (tested on
> > > > > > v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:

> > > > > >     BTFIDS  vmlinux
> > > > > >   + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > > >   FAILED: load BTF from vmlinux: Invalid argument

> > > > > > Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
> > > > > > v1.23 resolves the issue.

> > > > > Can you try this, from Martin Reboredo (Archlinux):

> > > > > Can you try a build of the kernel or the by passing the
> > > > > --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?

> > > > > Here's a patch for either in tree scripts/pahole-flags.sh or
> > > > > /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh

> > > > This patch helped and kernel builds successfully after applying it.
> > > > (Didn't notice this suggestion in release discussion thread.)

> > > Even thought it now compiles with this patch, it does not boot
> > > afterwards (in virtme-like env), witch such console messages:

> > I'm talking here about 5.15.62. Yes, proposed patch does not apply there
> > (since there is no `scripts/pahole-flags.sh`), but I updated
> > `scripts/link-vmlinux.sh` with the similar `if` to append
> > `--skip_encoding_btf_enum64` which lets then compilation pass.

> > >   [    0.767649] Run /init as init process
> > >   [    0.770858] BPF:[593] ENUM perf_event_task_context
> > >   [    0.771262] BPF:size=4 vlen=4
> > >   [    0.771511] BPF:
> > >   [    0.771680] BPF:Invalid btf_info kind_flag
> > >   [    0.772016] BPF:
 
> I can see the same on 5.15, it looks like the libbpf change that
> pahole is compiled with is setting the type's kflag for values < 0:
> (which is the case for perf_event_task_context enum first value)
 
>   dffbbdc2d988 libbpf: Add enum64 parsing and new enum64 public API
 
> but IIUC kflag should stay zero for normal enum otherwise the btf meta
> verifier screams
 
> if I compile pahole with the libbpf change below I can boot 5.15 kernel
> normally
 
> Yonghong, any idea?

This made me try to build pahole with the system libbpf instead of with
the one that goes with it, here, testing with libbpf 0.7.0 it wasn't
building as BTF_KIND_ENUM64 came with libbpf 1.0 so I added the
following patch to again allow with the system libbpf, i.e. using:

  $ cmake -DCMAKE_BUILD_TYPE=Release -DLIBBPF_EMBEDDED=Off

This will return errors if trying to encode or load enum64 tags, but
disabling it, as done with kernels not supporting BTF_KIND_ENUM64 should
now work, can you please test and report results?

Vitaly I checked and alt:p9 has libbpf 0.2, which is really old, unsure
if it would build there, but alt:sisyphus has 0.8.0, so should work
there, please try.

- Arnaldo

From 2bb968b567011f8a3e47706dc11c2a6ec442352c Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 26 Aug 2022 13:18:26 -0300
Subject: [PATCH 1/1] btf: Fix building with system libbpf

Where we may not have newer things, like BTF_KIND_ENUM64.

So we're now again building with -DLIBBPF_EMBEDDED=Off.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 27 +++++++++++++++++++++++++--
 btf_loader.c  |  7 +++++++
 dutil.h       |  4 ++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index daa8e3b507d4a856..51d9897fbf1bf41f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -9,12 +9,12 @@
   Copyright (C) Red Hat Inc
  */
 
+#include <linux/btf.h>
 #include "dwarves.h"
 #include "elf_symtab.h"
 #include "btf_encoder.h"
 #include "gobuffer.h"
 
-#include <linux/btf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <ctype.h> /* for isalpha() and isalnum() */
@@ -124,7 +124,7 @@ static int btf_var_secinfo_cmp(const void *a, const void *b)
 #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
 #define BITS_ROUNDUP_BYTES(bits) (BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
 
-static const char * const btf_kind_str[NR_BTF_KINDS] = {
+static const char * const btf_kind_str[] = {
 	[BTF_KIND_UNKN]		= "UNKNOWN",
 	[BTF_KIND_INT]		= "INT",
 	[BTF_KIND_PTR]		= "PTR",
@@ -491,6 +491,29 @@ static int32_t btf_encoder__add_struct(struct btf_encoder *encoder, uint8_t kind
 	return id;
 }
 
+#if LIBBPF_MAJOR_VERSION < 1
+static inline int libbpf_err(int ret)
+{
+        if (ret < 0)
+                errno = -ret;
+        return ret;
+}
+
+static
+int btf__add_enum64(struct btf *btf __maybe_unused, const char *name __maybe_unused,
+		    __u32 byte_sz __maybe_unused, bool is_signed __maybe_unused)
+{
+	return  libbpf_err(-ENOTSUP);
+}
+
+static
+int btf__add_enum64_value(struct btf *btf __maybe_unused, const char *name __maybe_unused,
+			  __u64 value __maybe_unused)
+{
+	return  libbpf_err(-ENOTSUP);
+}
+#endif
+
 static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const char *name, struct type *etype,
 				     struct conf_load *conf_load)
 {
diff --git a/btf_loader.c b/btf_loader.c
index 406a007b61fd4014..69b63a52f591eb84 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -312,6 +312,7 @@ out_free:
 	return -ENOMEM;
 }
 
+#if LIBBPF_MAJOR_VERSION >= 1
 static struct enumerator *enumerator__new64(const char *name, uint64_t value)
 {
 	struct enumerator *en = tag__alloc(sizeof(*en));
@@ -354,6 +355,12 @@ out_free:
 	enumeration__delete(enumeration);
 	return -ENOMEM;
 }
+#else
+static int create_new_enumeration64(struct cu *cu __maybe_unused, const struct btf_type *tp __maybe_unused, uint32_t id __maybe_unused)
+{
+	return -ENOTSUP;
+}
+#endif
 
 static int create_new_subroutine_type(struct cu *cu, const struct btf_type *tp, uint32_t id)
 {
diff --git a/dutil.h b/dutil.h
index e45bba05d05d3725..335a17c07c80e28e 100644
--- a/dutil.h
+++ b/dutil.h
@@ -344,4 +344,8 @@ void __zfree(void **ptr);
 
 #define zfree(ptr) __zfree((void **)(ptr))
 
+#ifndef BTF_KIND_ENUM64
+#define BTF_KIND_ENUM64 19
+#endif
+
 #endif /* _DUTIL_H_ */
-- 
2.37.2

