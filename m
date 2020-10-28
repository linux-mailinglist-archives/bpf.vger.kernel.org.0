Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA329DCD7
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 01:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgJ2Acm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 20:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387427AbgJ1W2q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 18:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603924125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wApZcyyCg/oHvQuw/XW+jOLHSnrOSTRGBkRyfmnnuNo=;
        b=fekCzrqXAdg5Q4oFFYv5tWJ6oD7aVUZMQb0ICgdDHmb4UAAkjtwWlcZvnY6VEBHZeJli0H
        T14Qtk/lN1bAXtgNopTIiWT9ynrPuetGDfehv6FjvFgD4Wgih1pE4ulLlWNzqxe3XXvHWN
        a1PGNqpjMhbUpqGBXXQ614jJIiB4NI4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-CgES4BPLO0KGCE7RyhSEXQ-1; Wed, 28 Oct 2020 18:28:43 -0400
X-MC-Unique: CgES4BPLO0KGCE7RyhSEXQ-1
Received: by mail-qk1-f197.google.com with SMTP id s14so657586qke.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wApZcyyCg/oHvQuw/XW+jOLHSnrOSTRGBkRyfmnnuNo=;
        b=m/60bDO5B3t13KGgOuh74CpbPZL6Ojbq3hjfTjO4n/xYtqMcB9Wzf8MJKCaqqToAqH
         BmzoREoyRIJhD9HR4zHCJ2xLWcgXfN0bYEaMiIEhKd7Eo+XFTnHVG+d+zK8ATPmGt176
         LZEPSXpHuEkuyFKfro6IzzGS6avzs2RHXqd4sUuR+LD1+d45RiGSucPttZIiY5U6LTin
         Pa8pLQRwcLJepF2jzPt8fN+Uto/4gxHbyrFRHY3E4L8hk42OYwEc+Yr5PBeAQaTBgWaJ
         sfizh1cvo52pxr0i0uxCAvkuqTC7v0CzfRRyhW6s0YS6bT4ZHEL8MdLxl3CUHbRT9W6Z
         OEDw==
X-Gm-Message-State: AOAM531VRaEKFz9XOolkr2LsCPRwOBMqCkP28u1ypTMq3iq3l0Vt6XqP
        p8PO8QB19Eh0i/iDA4eeMKFQYSzvsZXKoWbVNW5aUM6d2K8vT0711CZWSR0T/JRIkkCkh8367G9
        dJoroaGmZtGNi
X-Received: by 2002:a0c:9e0e:: with SMTP id p14mr1219951qve.25.1603924123522;
        Wed, 28 Oct 2020 15:28:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq9yyBSFxRxsVFnZ8IGw0Fts+hBOX/aebL+kXk1aaU6kEom8zA0qdvrPB2Hx90ZyB0KN/Pbw==
X-Received: by 2002:a0c:9e0e:: with SMTP id p14mr1219935qve.25.1603924123248;
        Wed, 28 Oct 2020 15:28:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 29sm423854qks.28.2020.10.28.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:28:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DE5FF181CED; Wed, 28 Oct 2020 23:28:40 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf: add struct bpf_redir_neigh forward
 declaration to BPF helper defs
In-Reply-To: <20201028181204.111241-1-andrii@kernel.org>
References: <20201028181204.111241-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 28 Oct 2020 23:28:40 +0100
Message-ID: <87eelim1d3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> Forward-declare struct bpf_redir_neigh in bpf_helper_defs.h to avoid
> compiler warning about unknown structs.
>
> Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support s=
upplying nexthop")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Ah! I did actually include that in my local tree at some point, but
guess it never made it into the patch; sorry about that!

I guess this should go into the bpf tree, rather than bpf-next, no?

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

