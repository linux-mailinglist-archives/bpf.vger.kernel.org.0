Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2629A2F30D0
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 14:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbhALNLw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 08:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbhALNLs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 08:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610457022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wr8CnqvgUjiddjHdSAdz1133yKSaodcwKywtgCq5eKg=;
        b=WQ7pNL7e7xHpS8EkgDVR2E0D7uSfoRhkdnC0n0bZydh87YTrnWx/wK7rzlHCjJPzWOeW0i
        CjwRYW/iY4pTUtvJ6pwKeuVeUXfxclpCaC68njA3YV1qDrHxVz2pijixP59alZq7jtEjG2
        HYqFjOvcK7FSqVpBBwWiR1E/LgAhuPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-_pqsbvhvPfGggUOzF8nyqQ-1; Tue, 12 Jan 2021 08:10:19 -0500
X-MC-Unique: _pqsbvhvPfGggUOzF8nyqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9EF71DDE2;
        Tue, 12 Jan 2021 13:10:16 +0000 (UTC)
Received: from krava (unknown [10.40.195.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD1775C1B4;
        Tue, 12 Jan 2021 13:10:13 +0000 (UTC)
Date:   Tue, 12 Jan 2021 14:10:12 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tom Stellard <tstellar@redhat.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
Message-ID: <20210112131012.GA1286331@krava>
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
 <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava>
 <ed779f29-18b9-218f-a937-878328a769fe@redhat.com>
 <20210112104622.GA1283572@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112104622.GA1283572@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 11:46:22AM +0100, Jiri Olsa wrote:
> On Mon, Jan 11, 2021 at 02:34:04PM -0800, Tom Stellard wrote:
> > On 1/11/21 2:31 PM, Jiri Olsa wrote:
> > > On Mon, Jan 11, 2021 at 10:30:22PM +0100, Sedat Dilek wrote:
> > > 
> > > SNIP
> > > 
> > > > > > 
> > > > > > Building a new Linux-kernel...
> > > > > > 
> > > > > > - Sedat -
> > > > > > 
> > > > > > [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> > > > > > [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
> > > > > > [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
> > > > > 
> > > > > There are no significant bug fixes between pahole 1.19 and master that
> > > > > would solve this problem, so let's try to repro this.
> > > > > 
> > > > 
> > > > You are right pahole fom latest Git does not solve the issue.
> > > > 
> > > > + info BTFIDS vmlinux
> > > > + [  != silent_ ]
> > > > + printf   %-7s %s\n BTFIDS vmlinux
> > > >   BTFIDS  vmlinux
> > > > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > FAILED: load BTF from vmlinux: Invalid argument
> > > 
> > > hm, is there a .BTF section in vmlinux?
> > > 
> > > is this working over vmlinux:
> > >   $ bpftool btf dump file ./vmlinux
> > > 
> > > do you have a verbose build output? I'd think pahole scream first..
> > > 
> > 
> > It does.  For me, pahole segfaults at scripts/link-vmlinux.sh:131.  This is
> > pretty easy for me to reproduce.  I have logs, what other information would
> > be helpful?  How about a pahole backtrace?
> 
> that'd be great.. I'll try to reproduce, but with the latest clang
> it will take me some time

reproduced, attached pahole patch fixes it for me,

looks like gcc never left function without name,
which does not seem to be the case for clang

I'll send full patch later today

jirka


---
diff --git a/btf_encoder.c b/btf_encoder.c
index c40f059580da..781fb35a2646 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -70,6 +70,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 		return 0;
 	if (!elf_sym__value(sym))
 		return 0;
+	if (!elf_sym__name(sym, btfe->symtab))
+		return 0;
 
 	if (functions_cnt == functions_alloc) {
 		functions_alloc = max(1000, functions_alloc * 3 / 2);
@@ -620,9 +622,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (!has_arg_names(cu, &fn->proto))
 			continue;
 		if (functions_cnt) {
-			struct elf_function *func;
+			const char *name = function__name(fn, cu);
+			struct elf_function *func = NULL;
 
-			func = find_function(btfe, function__name(fn, cu));
+			if (name)
+				func = find_function(btfe, name);
 			if (!func || func->generated)
 				continue;
 			func->generated = true;

