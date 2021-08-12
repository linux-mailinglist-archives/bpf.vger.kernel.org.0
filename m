Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E29F3E9B90
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhHLAUi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 20:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhHLAUh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 20:20:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD5C0613D3
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 17:20:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g21so6632338edb.4
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 17:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciNF9W+39aU1KfligFkasbssAwUB87TjLFIi4sKfemM=;
        b=Q/Xyt7pr8PpcaXXI/WFLYIo6GWhdgnu9a8MncUKdqxk0M22LyDtXUd3z/LHu59nN/J
         m6K3luOTMFEC4mMuVZpMNTRm+nXFDSfoB2CfyAUWM5QqJ3hiGl6mD3TgAZJQP7YygeII
         nVl9I4cljtvtT/v8yez9khnXaXZxHx59cjVs/Dtgp1MJRrQFormhC4G7JPJLDa6j9MuG
         TwpEQOsWaOoxzWAfPaWFr7d2CCjHCo9HbZubwtUyP08dHHMJCAD3NDueMi4vlC6W7mVd
         uyELL6eFzKCJGArr/s+PtcWbhiuJLBwdhtuTyPzdlg/d49T0Pb8b7ZRXAUNleX8sZajA
         Em1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciNF9W+39aU1KfligFkasbssAwUB87TjLFIi4sKfemM=;
        b=UOQvRRNf4UU3hDMN2n9x6MYwd40Lx4vlwDCkX2LRRfRnpPC/Y6TSsR5wHGU73cLBaV
         SMAlZHoptfdqlsumuKYZV6DpuGefZpYKNB3qCZgeoSBjWTPZqkAEQvKcRoAJnhoh8AL1
         ca114m0hxSpeNFIvfb6dxR6ylPRzDT8wGih9i7AUvYQufAoMGpCe0tHOs9oDqn5oCxRw
         GRERlPo4RelmpwXWjOiBWFmMOiSy2K67X+ILQSRy5m+zrghY8Bhk74T393oYywX68R47
         6SusfZ2qLbxzOzlfdNPTX1qkTVJUbWTfSC2ahMXilpQ4g1LVjUc5vaIR0D/nNUXnn0wT
         ILIA==
X-Gm-Message-State: AOAM532yO0Ll6rAVp09mOlIzlLRFE72/jAxe1zlKmk6Rpwww+5/i6eq9
        cYQzdN1L/KjiZJmjjcd71OPXUpYeawFsd2iB9Mk1XQ==
X-Google-Smtp-Source: ABdhPJybhf8Oq+5Fhh/V3kzdgpTQwfHdM36hP8tVVPUqorFzKOcI1KQIQKrl4yQdYp320z7ghsDvTyyKly2OFY6CMoc=
X-Received: by 2002:a50:be81:: with SMTP id b1mr2032098edk.295.1628727611637;
 Wed, 11 Aug 2021 17:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210811224036.2416308-1-haoluo@google.com> <CAEf4BzYX8Vg1YBHwGxj7cs+6FjsxnnYfxp1NKViZzO3nm=xudA@mail.gmail.com>
In-Reply-To: <CAEf4BzYX8Vg1YBHwGxj7cs+6FjsxnnYfxp1NKViZzO3nm=xudA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 11 Aug 2021 17:20:00 -0700
Message-ID: <CA+khW7g0bkEWnakHw4x+=HQrGHthdCyhCtmGTVPD7ERheJCP2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: support weak typed ksyms.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 11, 2021 at 4:41 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 11, 2021 at 3:40 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Currently weak typeless ksyms have default value zero, when they don't
> > exist in the kernel. However, weak typed ksyms are rejected by libbpf
> > if they can not be resolved. This means that if a bpf object contains
> > the declaration of a nonexistent weak typed ksym, it will be rejected
> > even if there is no program that references the symbol.
> >
> > Nonexistent weak typed ksyms can also default to zero just like
> > typeless ones. This allows programs that access weak typed ksyms to be
> > accepted by verifier, if the accesses are guarded. For example,
> >
> > extern const int bpf_link_fops3 __ksym __weak;
> >
> > /* then in BPF program */
> >
> > if (&bpf_link_fops3) {
> >    /* use bpf_link_fops3 */
> > }
> >
> > If actual use of nonexistent typed ksym is not guarded properly,
> > verifier would see that register is not PTR_TO_BTF_ID and wouldn't
> > allow to use it for direct memory reads or passing it to BPF helpers.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
Thanks for taking a look! All the comments seem reasonable. Let me fix
them, test and send a new version.

> >  Changes since v1:
> >   - Weak typed symbols default to zero, as suggested by Andrii.
> >   - Use ASSERT_XXX() for tests.
> >
> >  tools/lib/bpf/libbpf.c                        | 17 ++++--
> >  .../selftests/bpf/prog_tests/ksyms_btf.c      | 31 ++++++++++
> >  .../selftests/bpf/progs/test_ksyms_weak.c     | 57 +++++++++++++++++++
> >  3 files changed, 100 insertions(+), 5 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> >
[...]
