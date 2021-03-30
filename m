Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C355734EB99
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 17:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhC3PKq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 11:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhC3PKN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 11:10:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17674619CA;
        Tue, 30 Mar 2021 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617117013;
        bh=Ync+P2be63pYubOvM95WOXfKjIPEjUfSlXjmzMMjvyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZvQJAXgD2Km+7tCTVYtTobEsPu+KzLLeVvMJ7pBFaOufLKO3gVbjPKSkkRlt63wr
         3ouz4Cd5D9DvS9b0D8yUuX+LrXX5cZFWfishVQU4c8axzuNUkVeHkSw/CSc/qPAt94
         uGFsGkxgnslkD/AVx5SjoKcByseIql2fSPBx1IoQvYQ5NWF0T1CKXVFuxH9mNEQ7go
         DPZ0pEWcqAMdX4/6hclFJXWuMXsiN9oH34Ddem9W1dczQWvBewDlkaZq/gm60ry6Jm
         hJuI6Jef0gDhupiQganaZ+pM/DT4goCSpv9OqqraTak8Njh+gfiG0rpnqYcaKMMWTW
         MB1zUpuJDHi2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BA5CA40647; Tue, 30 Mar 2021 12:10:10 -0300 (-03)
Date:   Tue, 30 Mar 2021 12:10:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
Message-ID: <YGM/Uh61RVExWnTU@kernel.org>
References: <20210328201400.1426437-1-yhs@fb.com>
 <YGIQ9c3Qk+DMa+C7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGIQ9c3Qk+DMa+C7@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 29, 2021 at 02:40:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> [acme@five pahole]$ ulimit -c 10000000
> [acme@five pahole]$
> [acme@five pahole]$ file tcp_bbr.o
> tcp_bbr.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), with debug_info, not stripped
> [acme@five pahole]$ readelf -wi tcp_bbr.o | grep DW_AT_producer
>     <d>   DW_AT_producer    : (indirect string, offset: 0x4a97): GNU C89 10.2.1 20200723 (Red Hat 10.2.1-1) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu90 -p -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -fno-var-tracking-assignments -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fstack-check=no -fconserve-stack -fcf-protection=none
> [acme@five pahole]$ fullcircle tcp_bbr.o
> /home/acme/bin/fullcircle: line 38: 3969006 Segmentation fault      (core dumped) ${pfunct_bin} --compile $file > $c_output
> /tmp/fullcircle.4XujnI.c:1435:2: error: unterminated comment
>  1435 |  /* si
>       |  ^
> /tmp/fullcircle.4XujnI.c:1433:2: error: expected specifier-qualifier-list at end of input
>  1433 |  u32 *                      saved_syn;            /*  2184     8 */
>       |  ^~~
> codiff: couldn't load debugging info from /tmp/fullcircle.ZOVXGv.o
> /home/acme/bin/fullcircle: line 40: 3969019 Segmentation fault      (core dumped) ${codiff_bin} -q -s $file $o_output
> [acme@five pahole]$
> 
> Both seem unrelated to what you've done here, I'm investigating it now.

The fullcircle one, that crashes at the 'codiff' utility is related to
the patch that makes dwarf_cu to allocate space for the hash tables, as
you introduced a destructor for the dwarf_cu hashtables and the dwarf_cu
that was assigned to cu->priv was a local variable, which wasn't much of
a problem because we were not freeing it, as it went away at each loop
iteration, the following patch to that first patch in the series seems
to cure it, I'm folding it into your patch + a commiter note.

- Arnaldo

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5a1e860da079e04c..3e7875d4ab577f1b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -150,6 +150,18 @@ static int dwarf_cu__init(struct dwarf_cu *dcu)
 	return 0;
 }
 
+static struct dwarf_cu *dwarf_cu__new(void)
+{
+	struct dwarf_cu *dwarf_cu = zalloc(sizeof(*dwarf_cu));
+
+	if (dwarf_cu != NULL && dwarf_cu__init(dwarf_cu) != 0) {
+		free(dwarf_cu);
+		dwarf_cu = NULL;
+	}
+
+	return dwarf_cu;
+}
+
 static void dwarf_cu__delete(struct cu *cu)
 {
 	struct dwarf_cu *dcu = cu->priv;
@@ -2542,21 +2554,20 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 		}
 		cu->little_endian = ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
 
-		struct dwarf_cu dcu;
+		struct dwarf_cu *dcu = dwarf_cu__new();
 
-		if (dwarf_cu__init(&dcu) != 0)
+		if (dcu == NULL)
 			return DWARF_CB_ABORT;
 
-		dcu.cu = cu;
-		dcu.type_unit = type_cu ? &type_dcu : NULL;
-		cu->priv = &dcu;
+		dcu->cu = cu;
+		dcu->type_unit = type_cu ? &type_dcu : NULL;
+		cu->priv = dcu;
 		cu->dfops = &dwarf__ops;
 
 		if (die__process_and_recode(cu_die, cu) != 0)
 			return DWARF_CB_ABORT;
 
-		if (finalize_cu_immediately(cus, cu, &dcu, conf)
-		    == LSK__STOP_LOADING)
+		if (finalize_cu_immediately(cus, cu, dcu, conf) == LSK__STOP_LOADING)
 			return DWARF_CB_ABORT;
 
 		off = noff;
