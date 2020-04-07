Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8AB1A09B6
	for <lists+bpf@lfdr.de>; Tue,  7 Apr 2020 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGJEV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 05:04:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40634 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgDGJEV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Apr 2020 05:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586250260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvcNpSK+OU/LRxwdqoUOwRf3eBqiC4+fLaH2dumuPXI=;
        b=NdrkX5RX02RnkPs1tjWnGsNSnI/7uBjowSp8O1R8JUMcLIaQUl0UXoCWIfTSSFc4NVQt1j
        Bt5d8SilQoLv5czEQM3JpWXknVLUWi6PABhqoQuhHrLXqIaPVAiB7F9Rirh9qLTYnjVybV
        FvMOlwEzCiJ8w2uvcYoKy/JErqz8jyI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-oVPXGG89O7CLCg7DzUSydw-1; Tue, 07 Apr 2020 05:04:16 -0400
X-MC-Unique: oVPXGG89O7CLCg7DzUSydw-1
Received: by mail-lj1-f197.google.com with SMTP id r6so309237ljn.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2020 02:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DvcNpSK+OU/LRxwdqoUOwRf3eBqiC4+fLaH2dumuPXI=;
        b=DavpKx94FjBqugulf0PHK3QuQOZa3KcG1m2+K4d3mCZkw/MPUSQtQ84YtNAb5T/4Rx
         dG0dkBLrS66ObyoaNoFUEJ5GfaEKBC8Zc8M7DvUD+puOwXdxV3wwQ/HmWiqXT6B5c846
         mYmUsGnwqyKJyZkj/S9GRyZV05elOnJfkS9NBIa0zEBaoZx6XpQQc1COkxYtrIi2qbAY
         RDDxMruzby3RbR5LS45l+7jTTo+Kif55vj4lj/2mpUygMaT/nFgs9v5YaJ2sFLpqygl9
         pqGpD9sIBX4U7aSZ8cDbZBOTOHj3QyhpYd+l87OeRXYuUbq/7IvQXwXTyTuAmJe8iUXd
         lGXQ==
X-Gm-Message-State: AGi0PuYvKGhlFTyV3ASxlBFhsQaMspyb1xgjvqnPaZERvRWjCRi4X+/Q
        nw4ligKKIh462lUWkdNHJsJIoMCzlE0xbmeiiFEcHXgb/tj4y6qf7FjKo+i4FQRGK1eWS+Hvxmd
        mwxJNSpVa5Pic
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr1062238ljj.74.1586250254736;
        Tue, 07 Apr 2020 02:04:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJAC3O86HRkKgoHr826/2in2fPs6YsF+lQZ/U3eK8zZhEyBO363iPU2r05sH7KV0hiGt74FTQ==
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr1062229ljj.74.1586250254509;
        Tue, 07 Apr 2020 02:04:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d15sm3658801lfl.77.2020.04.07.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:04:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EEA8C1804E7; Tue,  7 Apr 2020 11:04:10 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf 1/2] libbpf: Fix bpf_get_link_xdp_id flags handling
In-Reply-To: <0e9e30490b44b447bb2bebc69c7135e7fe7e4e40.1586236080.git.rdna@fb.com>
References: <cover.1586236080.git.rdna@fb.com> <0e9e30490b44b447bb2bebc69c7135e7fe7e4e40.1586236080.git.rdna@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Apr 2020 11:04:10 +0200
Message-ID: <87tv1vacqd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov <rdna@fb.com> writes:

> Currently if one of XDP_FLAGS_{DRV,HW,SKB}_MODE flags is passed to
> bpf_get_link_xdp_id() and there is a single XDP program attached to
> ifindex, that program's id will be returned by bpf_get_link_xdp_id() in
> prog_id argument no matter what mode the program is attached in, i.e.
> flags argument is not taken into account.
>
> For example, if there is a single program attached with
> XDP_FLAGS_SKB_MODE but user calls bpf_get_link_xdp_id() with flags =3D
> XDP_FLAGS_DRV_MODE, that skb program will be returned.
>
> Fix it by returning info->prog_id only if user didn't specify flags. If
> flags is specified then return corresponding mode-specific-field from
> struct xdp_link_info.
>
> The initial error was introduced in commit 50db9f073188 ("libbpf: Add a
> support for getting xdp prog id on ifindex") and then refactored in
> 473f4e133a12 so 473f4e133a12 is used in the Fixes tag.
>
> Fixes: 473f4e133a12 ("libbpf: Add bpf_get_link_xdp_info() function to get=
 more XDP information")
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Makes sense

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

