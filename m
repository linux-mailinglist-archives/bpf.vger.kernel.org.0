Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B728228C49
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGUW4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 18:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgGUW4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 18:56:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E352C061794
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 15:56:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x184so165133ybx.10
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rq84c8NHhb7rAJnMBLD1Bd5cYTElYYF05pHIUiUcVAU=;
        b=CnLMq+qLPrHc/RYTXWT21L/cCtRd3hHA2mxpoLxw3KtIvb5CHyDIu9AhS3KR1Mk44k
         FKgxMIQwMZcJOWWMH+fJqYgseXsAjqn7BWIbLHhlejYwlav9zd+86BBwD+Key4HD1OJo
         rZ3zPI0xkvlsykyE7w06aH4e9gi+SWtF5nE5jr4elwzt7rAKiVmHGlJ6RcmrFVD4/mpf
         qIetCx3bfi8qFSa66RGmiBBZrjo41aHUL7cWlhPnRVNJxVlYBqUD2sRGtS41EsE4Ao1o
         MmgTN3CM5VQy6pklfMInvU8jviJfq5TNFR+KhzK0Z1Six8u2UEXwaevUy3EOauo02R/G
         jF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rq84c8NHhb7rAJnMBLD1Bd5cYTElYYF05pHIUiUcVAU=;
        b=PzApOA1ZfJvmdNclkKFQo33lCWATR6tbk/KiSc8ul3MWfOwYk9YE5WMzUtFin0tdTh
         MiswhCFlp6GdV9vBWb5MsI1gNKTs2ZcH5LPrt4mKJXahrta/Vp3IKgtIZrQGkoikx6DF
         5pyEDSs4eRyzX/QLOmW6QdJMjG2i7nyP5klvHbDtRxHO04u7tvwImq+I5CC5nqaTtu7b
         32NfnKrdICB4eFsNJ5dDdh3rmEtxoKh9xVOeaz71Akx7HXgDUdd7Y2RVlw65rCI4Ieyr
         OuZeoqHSrtOz12qJmWf+LJ8RaOfNpMF1APIksDoIW/KMVhYl/yC+zG9dXXW4HsCrk1gO
         yXcQ==
X-Gm-Message-State: AOAM53129TBKTumFtYsuUtwTvSgipMcBmrnm+VQLvjU4F5Fe+KruRAvH
        cHVseI9Srb3yo5H+OOuL/iI0HY4=
X-Google-Smtp-Source: ABdhPJzZ42Fv3n7qjjDFEhneqpxoXWHS1WZm82zYxbF3USG6qZQYG8qYj02AYH/uyyIOXbh0rwkgJlI=
X-Received: by 2002:a25:aba9:: with SMTP id v38mr46836390ybi.54.1595372198068;
 Tue, 21 Jul 2020 15:56:38 -0700 (PDT)
Date:   Tue, 21 Jul 2020 15:56:36 -0700
In-Reply-To: <20200721224158.ylrgjjljlighny4f@kafai-mbp>
Message-Id: <20200721225636.GB184844@google.com>
Mime-Version: 1.0
References: <cover.1595274799.git.zhuyifei@google.com> <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
 <20200721180536.57kbngehupi4hqra@kafai-mbp> <CAA-VZPm9fgNKMHX1rbOEcUJ17=S5qS=rkYcBiqzcsOxCSSKuGg@mail.gmail.com>
 <20200721224158.ylrgjjljlighny4f@kafai-mbp>
Subject: Re: [PATCH v4 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     YiFei Zhu <zhuyifei@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/21, Martin KaFai Lau wrote:
> On Tue, Jul 21, 2020 at 04:20:00PM -0500, YiFei Zhu wrote:
> > On Tue, Jul 21, 2020 at 1:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > I quickly checked zero is actually BPF_CGROUP_INET_INGRESS instead
> > > of UNSPEC for attach_type.  It will be confusing on the syscall
> > > side. e.g. map dumping with key.attach_type == BPF_CGROUP_INET_INGRESS
> > > while the only cgroup program is actually attaching to  
> BPF_CGROUP_INET_EGRESS.
> > >
> > > I don't have a clean way out for this.  Adding a non-zero UNSPEC
> > > to "enum bpf_attach_type" seems wrong also.
> > > One possible way out is to allow the bpf_cgroup_storage_map
> > > to have a smaller key size (i.e. allow both sizeof(cgroup_inode_id)
> > > and the existing sizeof(struct bpf_cgroup_storage_key).  That
> > > will completely remove attach_type from the picture if the user
> > > specified to use sizeof(cgroup_inode_id) as the key_size.
> > > If sizeof(struct bpf_cgroup_storage_key) is specified, the attach_type
> > > is still used in cmp().
> > >
> > > The bpf_cgroup_storage_key_cmp() need to do cmp accordingly.
> > > Same changes is needed to lookup_elem, delete_elem, check_btf,  
> map_alloc...etc.
> >
> > ACK. Considering that the cgroup_inode_id is the first field of struct
> > bpf_cgroup_storage_key, I can probably just use this fact and directly
> > use the user-provided map key (after it's copied to kernel space) and
> > cast the pointer to a __u64 - or are there any architectures where the
> > first field is not at offset zero? If this is done then we can change
> > all the kernel internal APIs to use __u64 cgroup_inode_id, ignoring
> > the existence of the struct aside from the map creation (size checking
> > and BTF checking).
> Just to be clear.  The problem is the userspace is expecting
> the whole key (cgroup_id, attach_type) to be meaningful and
> we cannot stop supporting this existing key type now.
To step back a bit. I think in the commit message we mentioned that
attach_type is essentially (mostly) meaningless right now.
If I want to share cgroup storage between BPF_CGROUP_INET_INGRESS and
BPF_CGROUP_INET_EGRESS, the verifier will refuse to load those programs.
So doing lookup with different attach_type for the same storage
shouldn't really happen.

Except. There is one use-case where it does make sense. If you take
the same loaded program and attach it to both ingress and egress, each
one will get a separate storage copy. And only in this case
attach_type really has any meaning.

But since more and more attach types started to require
expected_attach_type, it seems that the case where the same
prog is attached to two different hooks should be almost
non-existent. That's why we've decided to go with
the idea of completely ignoring it.

So the question is: is it really worth it trying to preserve
that obscure use-case (and have more complex implementation) or we can
safely assume that nobody is doing that sort of thing in the wild (and
can simplify the internal logic a bit)?
