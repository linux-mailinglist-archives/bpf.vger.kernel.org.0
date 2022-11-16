Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7862B177
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 03:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKPCs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 21:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiKPCs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 21:48:57 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374F1E72F
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:48:56 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3704852322fso155234747b3.8
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FW2dbbrYH64Tsisoc9cGF4YSFIsczMSsBOCNDpIILJs=;
        b=fUfuoBbtrBNliepEJDepKDGRIpvVgLcOaQWGRufRYo5QCTs83sNx3W+sOR6tKewu3g
         zYF51F4vxdSFYSyiu0X0D6BZPDs2wJaHhAG9X8WkhQPA/1S2GVFsofsGEZ60mQ3Zm6p6
         OqCKqPC/IxcsgIkbLD86FRpRR7eZFzgw8dMWVYQMnAjTBMACRrYNIFm74TvtykCTkQfx
         yzwo+HOPngwjO3M/biJG0rEswg3Qs46AFPcXMTohxAt6t4TepMD4rA1svoKTYWs73liR
         7bPZpjfnOnQlQ3GjErgEHNaxgqYsTJteNq82YnwAmhNFOspSgApbEmTEl8DNBpCwivVm
         XWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FW2dbbrYH64Tsisoc9cGF4YSFIsczMSsBOCNDpIILJs=;
        b=6FD/wy6Eghjz77AjyUkT8KjaT5hrW9WG9toNssvIKEqgN5StBKpleGJi4YB3aDtMbz
         Ap9ndv8KOEMFAb+Zg85tYCtrJWvDiN1p6EtiAb5Tk8GwQ/H9ZtmgZBECC5FCC+87z1yA
         LDqTVYazdf9+5Ol3nA6a+aeWDDXPQp7kL2iXO2EOgUym/MGQFxoh20w0nGoXa+qDLhNN
         ybwnB35E66FjCgVShILF23BQUGvNuVonDI4WEixsiHQSyL1FlPWN16+SJpn45lOG4Bzy
         0bSf0HwVEOeYrqMz2UcYmCoC361a9s7ThAhuqUvyu6vvLtBUcFstKAbsS3LWvXtDQmDG
         5I3A==
X-Gm-Message-State: ANoB5pkDiTa1LpP9kamT+gyelmzTq5Of7zTD/ONzTFTQdhqeOu+DNfyp
        ORsoZ4yTrR5fVTUWqw7L7bdextkcO27FgHVsmvXmGK0otF8=
X-Google-Smtp-Source: AA0mqf7F+B0k+pk36z9v7vm/GVbPc/hFFWahwHEB05+4aZCJRkbL/Oe5ZYs4slP9xdZwtf1KMmSQ8WYVaBsFc2qPggc=
X-Received: by 2002:a81:ae60:0:b0:373:4bf9:626e with SMTP id
 g32-20020a81ae60000000b003734bf9626emr20616299ywk.173.1668566935361; Tue, 15
 Nov 2022 18:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com> <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
 <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
In-Reply-To: <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 15 Nov 2022 18:48:44 -0800
Message-ID: <CA+khW7gA3PgMwX5SmZELRdOATYeKN3XkAN9qKUWpjFU-M6YZjw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 5:37 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 15, 2022 at 11:16 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > On 11/10/22 10:34 PM, Hou Tao wrote:
> > > From: Hou Tao <houtao1@huawei.com>
> > >
> > > For many bpf iterator (e.g., cgroup iterator), iterator link acquires
> > > the reference of iteration target in .attach_target(), but iterator link
> > > may be closed before or in the middle of iteration, so iterator will
> > > need to acquire the reference of iteration target as well to prevent
> > > potential use-after-free. To avoid doing the acquisition in
> > > .init_seq_private() for each iterator type, just pin iterator link in
> > > iterator.
> >
> > iiuc, a link currently will go away when all its fds closed and pinned file
> > removed.  After this change, the link will stay until the last iter is closed().
> >   Before then, the user space can still "bpftool link show" and even get the
> > link back by bpf_link_get_fd_by_id().  If this is the case, it would be useful
> > to explain it in the commit message.
> >
> > and does this new behavior make sense when comparing with other link types?

I think this is a unique problem in iter link. Because iter link is
the only link type that can generate another object.

>
> One more question to the above...
>
> Does this change mean that pinned cgroup iterator in bpffs
> would prevent cgroup removal?

Yes, when attaching the program to cgroup, the cgroup iter link gets
an extra ref of the cgroup. It puts that ref when detach.

> So that cgroup cannot even become a dying cgroup ?
>

No. The cgroup will become offline and its corresponding kernfs node
will be removed. The cgroup object is still accessible.

> If so we can do that and an approach similar to init_seq_private
> taken for map iterators is necessary here as well.
>
> Also pls target this kind of change to bpf-next especially
> when there is a consideration to revert other fixes.
> This kind of questionable fixes are not suitable for bpf tree
> regardless of how long the "bug" was present.
