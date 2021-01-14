Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2E02F6325
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbhANO35 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 09:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbhANO35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 09:29:57 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74CBC061574;
        Thu, 14 Jan 2021 06:29:16 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id o6so11427003iob.10;
        Thu, 14 Jan 2021 06:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LS8fg0HKEcY7Wt3YSvfXQWVT0giLgr+GsituOFMEcK4=;
        b=pcoPAMHIQ33GZfZ299U8S4AAs6TQ8HxAOJAW2rPViFCRQr1OTVNm2wiTPaKA6iGfCL
         SpQAHMgYGKOeFmYbcljC59E286eDxj1VE4BM7ogkRNq0r4iPkJOcbKAIPaj0qguE+dvA
         Pm9q0u3g8i/hPOcF5x8n6cxTFH+4wvXxpSR4LzpaPonWCqNEQ1xnwqx1wmfG6mGrIdNd
         uCIHs+bn1s2QEYGG4QrpGuJHBC0ghO6HKA6Dzm8pXOgyQ/txPNUzFD83gVcNp5/bZFAx
         q4J0211dCaFaESl0a1VCM0SRJ8IjlJHo6Ufs8xKS79JxhGQ+p/8Fw3j2xgfBIC7gOpn/
         jcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LS8fg0HKEcY7Wt3YSvfXQWVT0giLgr+GsituOFMEcK4=;
        b=ZpqpOxLLJrACjSgz6F11zlTLzLY4shU343l/vYVPa+C1xlEAMQUiVc/iKhpNmFlW6R
         Z0Ye/+yy987eZeqK4Sxk8fV1BB9SgQfjoSREhrGyvh07XMAvux7k/pto9fuuIfAimXj0
         pnd3ItX67zu4pkGYZvi5FreG1lZAcDJZC4I/sQenMtLGsAXakL7soGAFyeznFykRo+Gv
         RqpuDpmmrpsn0Ic71PTsKParQ7YrhxVOvGYkv+KgnQADNHsB8ys+XbAE4eJChmBZuE2K
         H+gzRj8RbTdPGwFnbL1NIiNsazThmYeHD/+l9k0nhrX2cC6H8x3zp4PCnBb3SZu7dtGP
         UerA==
X-Gm-Message-State: AOAM530TR14Jmc8V2rQmiQ1o8aHkXQ+kBP3zt0eMw9ZyuN/A+ZsVfjpB
        0Sy/eKbUf3K9ouyckqHL/W2f08MW0pfeomZcB1o=
X-Google-Smtp-Source: ABdhPJzPwSNEW9kofc4O9vuaIM6fol5UJ7RElQ20x+VMh8BkE6YNXxsh5eWFaEzHKHIaWkqLelSjccuA9gUJVNQbogU=
X-Received: by 2002:a92:c692:: with SMTP id o18mr6964355ilg.215.1610634556151;
 Thu, 14 Jan 2021 06:29:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com> <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava> <CA+icZUWaMktPBYy9P-gbgL-AD7EEPrrvS4jenahJ-3HkxOOC0g@mail.gmail.com>
 <20210114142431.GB1416940@krava>
In-Reply-To: <20210114142431.GB1416940@krava>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 15:29:05 +0100
Message-ID: <CA+icZUUUr+Dmwy9NMGG+yCzjB+ZnMoKnaxfkVV9qtMWgsFo2wQ@mail.gmail.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 3:24 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Jan 14, 2021 at 03:13:18PM +0100, Sedat Dilek wrote:
> > On Mon, Jan 11, 2021 at 11:31 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
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
> > > >  BTFIDS  vmlinux
> > > > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > FAILED: load BTF from vmlinux: Invalid argument
> > >
> > > hm, is there a .BTF section in vmlinux?
> > >
> > > is this working over vmlinux:
> > >  $ bpftool btf dump file ./vmlinux
> > >
> >
> > I switched to LLVM v12 from <apt.llvm.org> and saw the same FAILED line.
> >
> > The generated vmlinux file is cleaned on failure.
> >
> > + info BTFIDS vmlinux
> > + [  != silent_ ]
> > + printf   %-7s %s\n BTFIDS vmlinux
> >  BTFIDS  vmlinux
> > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > FAILED: load BTF from vmlinux: Invalid argument
>
> did pahole generated the .BTF section? earlier in the log
>
> jirka
>

Cannot say.

I did:

$ git diff
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 2d0b28758aa5..c6e679d08bbe 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -401,12 +401,6 @@ fi

vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}

-# fill in BTF IDs
-if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
-       info BTFIDS vmlinux
-       ${RESOLVE_BTFIDS} vmlinux
-fi
-
if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
       info SORTTAB vmlinux
       if ! sorttable vmlinux; then

- Sedat -
