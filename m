Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1835233F0D9
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 14:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCQNFP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 09:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229460AbhCQNEo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Mar 2021 09:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615986283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5K1eWFevd/HHcWFLKscE1HUL+tCoTqGMwfzyUYEhIo=;
        b=ZHhUrs215l2zWjExuxNSwG0iNmGA5/tO+4TkqVznMjp40D+CqZYTgtHqxtA8magO3A+LRI
        WMXMTnvNgcZMBjZTRYE4N8DLGPTqXWG65yss5OlR/fYsfHLxlKc5RbQqtMYpgLIKjiqqRy
        nZDWQp8ss5LMHuT5oaHM+oSoD0p4kfI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-pY8Qla2YM8WsqKuNsc4q_Q-1; Wed, 17 Mar 2021 09:04:41 -0400
X-MC-Unique: pY8Qla2YM8WsqKuNsc4q_Q-1
Received: by mail-ed1-f70.google.com with SMTP id p6so19215618edq.21
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 06:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h5K1eWFevd/HHcWFLKscE1HUL+tCoTqGMwfzyUYEhIo=;
        b=OXxa8P5RIlR0GnfpwWVYbl+17wFtO49RqIokwXS/PzAzTIcQ7EnNZbPSkp3NNCzvZG
         aF0yZGNCqvAZZ6hbNR0dz7O5LTpu/H4sIMsObZu8etZSV7LVC6S2P5v0iRsrDRRLOQF9
         Cj9p+Ox+2D9rL4w9AVZjWn5FVPXujS9vRQ6LokCXg4evrXHicMQpIOysx6E/asMUJMoJ
         J3R3Aueb8MNTbYCxJ2/jZF6nOftk0aJEhNO16j8ISic6qg2IhVdGmTj4JKAMTPt2bAp2
         4jynD3btrqhD+Yidh9EhHOH4+ZFD74Uy6O6wieHSPy3yCxzdMRS05+oGNoK82n7sL5Di
         VWbg==
X-Gm-Message-State: AOAM530f6RI5AUWxwOZuuPPjw0OS9cpsKCSloUrPZa16zzFxfYj7TImd
        yLe482VOJZQNPdXvFt0rkMGHLJOf0DJwNbjxwM5UtS92Se3CgSaT7nIb3rhVOYWCXWDs2BTG34g
        0jKOEG3EicK67
X-Received: by 2002:aa7:d98b:: with SMTP id u11mr42842210eds.352.1615986280774;
        Wed, 17 Mar 2021 06:04:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyDhSRwms9eliBndoHdtnij7qZI8LvV0vW97nB6OL4IrtYBHURFzssnERHOda1/sbEJA5eYQ==
X-Received: by 2002:aa7:d98b:: with SMTP id u11mr42842187eds.352.1615986280598;
        Wed, 17 Mar 2021 06:04:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x1sm1426421eji.8.2021.03.17.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:04:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 73A53181F55; Wed, 17 Mar 2021 14:04:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, ast@kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] libbpf: use SOCK_CLOEXEC when opening the
 netlink socket
In-Reply-To: <20210317115857.6536-1-memxor@gmail.com>
References: <20210317115857.6536-1-memxor@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 17 Mar 2021 14:04:38 +0100
Message-ID: <87lfamc4nt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Otherwise, there exists a small window between the opening and closing
> of the socket fd where it may leak into processes launched by some other
> thread.
>
> Fixes: 949abbe88436 ("libbpf: add function to setup XDP")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

