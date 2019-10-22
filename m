Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2819BE0AD5
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfJVRmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 13:42:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42968 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727154AbfJVRmH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Oct 2019 13:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571766126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LpfkEMXmZt1WFPnGraTJgtnhIR/gR2WUdMmGfh42Rqs=;
        b=UExe9PcYfSVsQ1ZRKuiuuCO+lxd6pWTLCENBNysGJj0hU5kig02WdP4MYHMJ6l/bqrkp3A
        YcRA2bjSnc+pGV/nuxN6tfu2Nn7SSwYGthxff+GFqjmhr0zNRzqcR1EAlWc5ejVFxSFeK3
        5LXTuh3ZAGFjnmSdKnySevF1NTdhJpw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-Pl54trZ1P8mrrNaZvG_37w-1; Tue, 22 Oct 2019 13:42:05 -0400
Received: by mail-lj1-f198.google.com with SMTP id g28so744171ljl.10
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 10:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p4Ptj3uKdMq6GjmS+mQFiC7l4xjbjGQnVWvpWc/EejU=;
        b=h+XXmp1gDA3j42T20RRpQOtzu/XfuUJyXzMxVUIeb/mckYPegzVZ31X1WTE5B3oabo
         oDPJIyMNr2AuLWT6AX5H2wmvNplUcngL+9B5nwmT1pPMtYRn98I/FkZs0zOdi9HYcXhQ
         nL8GJnAheSXlhIY4qlFi6rqnbV0Hy6MOl5MnZSFvalxAuOIyQaPP9yQh9cMq4gH3HqN2
         1xk4K2kipjT9Sj4miACpN5vTRHt7be8GONoNn1GQvd+v6dW7W2Ht75G+LnUXNOj8dDrB
         fCXo5zttEBBYGc3/2nAItma/z+H/QM3DhMBA0900zji6QQ0oipJgTXCRro7sLviJYlZM
         h0Tg==
X-Gm-Message-State: APjAAAV4SUKUcim+r8UJWyYoajqTp4fYH4NFTlC64VhpwAqR6BAW16Lw
        kMGNLb/t7Cdzfyeln3Nsvks/vBod1a8UsU/tpTwfCF5JpZ0TfLNGsy6Y03hSR+aG8XVJ9ac1Jq7
        KPzrF0pj9VGpT
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr15510529lfp.43.1571766123958;
        Tue, 22 Oct 2019 10:42:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXH2l/yNrfKnO1j1J6tqaWWFT7bGLQEGy61vpzhv7Hh0Jh3G8Iow41oIQefEd4zdmGobctLw==
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr15510518lfp.43.1571766123769;
        Tue, 22 Oct 2019 10:42:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id i11sm8998963ljb.74.2019.10.22.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:42:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0522A1804B1; Tue, 22 Oct 2019 19:42:02 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: make DECLARE_LIBBPF_OPTS macro strictly a variable declaration
In-Reply-To: <20191022172100.3281465-1-andriin@fb.com>
References: <20191022172100.3281465-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 19:42:01 +0200
Message-ID: <87imogoexi.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Pl54trZ1P8mrrNaZvG_37w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> LIBBPF_OPTS is implemented as a mix of field declaration and memset
> + assignment. This makes it neither variable declaration nor purely
> statements, which is a problem, because you can't mix it with either
> other variable declarations nor other function statements, because C90
> compiler mode emits warning on mixing all that together.
>
> This patch changes LIBBPF_OPTS into a strictly declaration of variable
> and solves this problem, as can be seen in case of bpftool, which
> previously would emit compiler warning, if done this way (LIBBPF_OPTS as
> part of function variables declaration block).
>
> This patch also renames LIBBPF_OPTS into DECLARE_LIBBPF_OPTS to follow
> kernel convention for similar macros more closely.
>
> v1->v2:
> - rename LIBBPF_OPTS into DECLARE_LIBBPF_OPTS (Jakub Sitnicki).
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


> +#define DECLARE_LIBBPF_OPTS(TYPE, NAME, ...)=09=09=09=09    \
> +=09struct TYPE NAME =3D ({ =09=09=09=09=09=09    \
> +=09=09memset(&NAME, 0, sizeof(struct TYPE));=09=09=09    \
> +=09=09(struct TYPE) {=09=09=09=09=09=09    \
> +=09=09=09.sz =3D sizeof(struct TYPE),=09=09=09    \
> +=09=09=09__VA_ARGS__=09=09=09=09=09    \
> +=09=09};=09=09=09=09=09=09=09    \
> +=09})

Found a reference with an explanation of why this works, BTW; turns out
it's a GCC extension:

http://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html#Statement-Exprs

-Toke

