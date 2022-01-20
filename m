Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA28A494D8D
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiATMAc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 07:00:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232550AbiATMAa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 07:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642680030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Lq3A8rA2el0fGEcP1H0WpUnf3juFQ4Qp4pOKMri1Oc=;
        b=RItA3iG40lfwQxmnGdCKDjSgSGVoGzLawUoFhY3OeVi7evJLBl1GVtBD8uTHAFcnDVHJdP
        u2a42v61kdqlnx2p7qezmZysp9A1H7FOqMNZrQfirnd4sO/VWYTBhQGKXavMxxOg8An6fq
        szjBLyedDG710TE83GNCpFRSuV3Wx6w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-3B_E1cNiP1WRzBW_CJyxpw-1; Thu, 20 Jan 2022 07:00:29 -0500
X-MC-Unique: 3B_E1cNiP1WRzBW_CJyxpw-1
Received: by mail-ed1-f69.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso5695579edb.10
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 04:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8Lq3A8rA2el0fGEcP1H0WpUnf3juFQ4Qp4pOKMri1Oc=;
        b=fmp9egibfUPIjdZwaPvrcwKzeZMVCllnvSaN9qiE7KlcPZ0HSsnX5YFML8X8SDCCax
         kGJTfng+v8/B7DA2GoIZGVE4tzA4ectwtv0ERQ1ShrofaMMD4UNaqsKaKWvYUfBJbog0
         ArYwUr254lyUkgaxZ4U5yNp1xRot0e28cv5Nm16m8oMQgnVqulkwLBf2wkjwIDqhLMDZ
         rnW6G9EavdM44aF/DAdYsBsLg9Kf3NNSx2p0QKq1kuzsRHwmw2E/aaNdyQwz+yGs754d
         U37s2o1PeSYRxuQoRAGY92tAMigcDJG6MWfgZx3moqqVuIbeBYhM1XB9OQPx8NNkZasP
         2M7Q==
X-Gm-Message-State: AOAM53249AvC8X2HdgWHe+z72Mc+lJNF/+RrKFR1Ze7lbTx2Fd5MeHUv
        7BOMpnA1ILohhXQ6WSOEvMNAfZrsZa3STUzTonCgurz2XKxX0T+UkhrEvHSwBFgfe6ZSQ+g7jSH
        QwtQq3KYd4EEh
X-Received: by 2002:a50:da48:: with SMTP id a8mr34921439edk.146.1642680025257;
        Thu, 20 Jan 2022 04:00:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE/JT9NgGXr0lsZvGbDnA5TvqVTOmuj70MKuK7wsx5G32oY/KtXdXOhnGtbyaoFRIKAn9e7w==
X-Received: by 2002:a50:da48:: with SMTP id a8mr34921235edk.146.1642680022423;
        Thu, 20 Jan 2022 04:00:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y2sm909861ejh.80.2022.01.20.04.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:00:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 256311805F9; Thu, 20 Jan 2022 13:00:21 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/4] libbpf: streamline low-level XDP APIs
In-Reply-To: <20220120061422.2710637-2-andrii@kernel.org>
References: <20220120061422.2710637-1-andrii@kernel.org>
 <20220120061422.2710637-2-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 20 Jan 2022 13:00:21 +0100
Message-ID: <87tudy7h2i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> Introduce 4 new netlink-based XDP APIs for attaching, detaching, and
> querying XDP programs:
>   - bpf_xdp_attach;
>   - bpf_xdp_detach;
>   - bpf_xdp_query;
>   - bpf_xdp_query_id.
>
> These APIs replace bpf_set_link_xdp_fd, bpf_set_link_xdp_fd_opts,
> bpf_get_link_xdp_id, and bpf_get_link_xdp_info APIs ([0]). The latter
> don't follow a consistent naming pattern and some of them use
> non-extensible approaches (e.g., struct xdp_link_info which can't be
> modified without breaking libbpf ABI).
>
> The approach I took with these low-level XDP APIs is similar to what we
> did with low-level TC APIs. There is a nice duality of bpf_tc_attach vs
> bpf_xdp_attach, and so on. I left bpf_xdp_attach() to support detaching
> when -1 is specified for prog_fd for generality and convenience, but
> bpf_xdp_detach() is preferred due to clearer naming and associated
> semantics. Both bpf_xdp_attach() and bpf_xdp_detach() accept the same
> opts struct allowing to specify expected old_prog_fd.
>
> While doing the refactoring, I noticed that old APIs require users to
> specify opts with old_fd =3D=3D -1 to declare "don't care about already
> attached XDP prog fd" condition. Otherwise, FD 0 is assumed, which is
> essentially never an intended behavior. So I made this behavior
> consistent with other kernel and libbpf APIs, in which zero FD means "no
> FD". This seems to be more in line with the latest thinking in BPF land
> and should cause less user confusion, hopefully.
>
> For querying, I left two APIs, both more generic bpf_xdp_query()
> allowing to query multiple IDs and attach mode, but also
> a specialization of it, bpf_xdp_query_id(), which returns only requested
> prog_id. Uses of prog_id returning bpf_get_link_xdp_id() were so
> prevalent across selftests and samples, that it seemed a very common use
> case and using bpf_xdp_query() for doing it felt very cumbersome with
> a highly branches if/else chain based on flags and attach mode.
>
> Old APIs are scheduled for deprecation in libbpf 0.8 release.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/309
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

