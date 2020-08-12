Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C403924276B
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgHLJYw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 05:24:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28296 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726595AbgHLJYw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 05:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597224291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0RAsBMV1VRV9PTxV0Jb0bq8SzJBZPYK2PYTUHp8OeY=;
        b=YW7j3JlyVtgxy+Ehjg70JLa3vJ4hAzvP7ZkI150x1Yy/RpXWmcCb2txHqfQZe7fhCtYjgP
        q3oPp9LHf5bEZqxezJcdHx0zgZUP8YMMCMY/rEsPmw8S/BU+DBbMk2FU6EtAhkopgZJ9CH
        yG5wj53lCdlGNW5FWyUI6EFX64DV5b8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-nj7TZJAaOoKlVVI1ywKckA-1; Wed, 12 Aug 2020 05:24:49 -0400
X-MC-Unique: nj7TZJAaOoKlVVI1ywKckA-1
Received: by mail-wm1-f69.google.com with SMTP id t26so671499wmn.4
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 02:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=D0RAsBMV1VRV9PTxV0Jb0bq8SzJBZPYK2PYTUHp8OeY=;
        b=B5PuvKjEBaKWMaHj1aAINA7n6/7vPDHjWxTZpYtvQKgIkOBv57cfP/QsckXUIB3MF0
         dSqIK5O6bkFLyKQtbeOT4fbWwN3wHRZFgywFkHFT+m8YhuF/AA3279XSYql4IY1Li6mN
         aWnsu4RDeHsKvL8XcEU3CUl0+mp2Eus4Lpce6BWERUDstTeOTztYQ3S36Oc3oGtw7QKP
         KtRrF0VGSO1wUirI6+9qV0v+DqrFQra0B/7utAl6myUB7vT8OQGqqf7/fW/2xtNB70NH
         bLwoxQrwAEy0gv8BCwrpYqgjkpd+dV7Y6zWg10qbceeHtSUgk9sGDioBKcvQCuZCM/2d
         A0WQ==
X-Gm-Message-State: AOAM532vXHSpgln19fZ0ytfT8DIYIX95dpnrqKsi3n9uMGcX2p9SrBv1
        Rv/DXMblwpzX8aE3XflHuDjPTa3aE1wkm42t+xuJhY9hmmFmZpbUt+K7pr37uPuFlQVQQpI2sq7
        f3dmxdGhcJva2
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr8195716wmc.13.1597224288390;
        Wed, 12 Aug 2020 02:24:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqjk1UDn6Bdzt14vEBN5NYKE1v9wqJxw7iHNj67SWRlTXQtUQfNcFDAvuYP2Qw2MtuhfUqww==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr8195702wmc.13.1597224288234;
        Wed, 12 Aug 2020 02:24:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x6sm2976425wmx.28.2020.08.12.02.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 02:24:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D1AB518282F; Wed, 12 Aug 2020 11:24:46 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf] bpf: fix XDP FD-based attach/detach logic around XDP_FLAGS_UPDATE_IF_NOEXIST
In-Reply-To: <20200812022923.1217922-1-andriin@fb.com>
References: <20200812022923.1217922-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 12 Aug 2020 11:24:46 +0200
Message-ID: <87imdo1ajl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Enforce XDP_FLAGS_UPDATE_IF_NOEXIST only if new BPF program to be attache=
d is
> non-NULL (i.e., we are not detaching a BPF program).
>
> Reported-by: Stanislav Fomichev <sdf@google.com>
> Fixes: d4baa9368a5e ("bpf, xdp: Extract common XDP program attachment log=
ic")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

