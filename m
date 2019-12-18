Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86FF12459F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLRLUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:20:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20835 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726682AbfLRLUS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 06:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576668017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ut+xo9ffqp7U2w/m4MeHwCHpEskA84eDk3YygkoZgLQ=;
        b=eaPQyuC8aKzp32ji2dwcU79T14Irn0M67RGPvPGJdNueGxu4CMtF0f9sz3FyvqeRFRsAj1
        paxEMlBBY+stgsnhCsq4Hn0J6XMomdy+VZn0JhntMCZN5eRpdc63iFgKfjnkr/qi4gGJ/1
        6CytLFf539MW2Gz8ZwvG3VRczIFw9UA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-NlDZMoEIPzmYVYLNYMgEdw-1; Wed, 18 Dec 2019 06:20:14 -0500
X-MC-Unique: NlDZMoEIPzmYVYLNYMgEdw-1
Received: by mail-lj1-f198.google.com with SMTP id d14so580602ljg.17
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ut+xo9ffqp7U2w/m4MeHwCHpEskA84eDk3YygkoZgLQ=;
        b=jwnh3wzaKICgfb7e20n4iRvPHuwzJk2nGT5WY3KKE/uCcIKb3pe9gL92NvzjUzkuWd
         XtiTic+MIgfQb4rJjJQF2GTOY76vhlQGJYo8X4DfadGEcPfYogRLG+IfOT0y6jCfsnOm
         geJ5GkN8S0DxES5cPTiTUIwdBzqi+oA4whR1kXmqcELE/Fd2Cwh2nRzHlnY4vtCiC8T+
         SLjxEk29IUje9LwrCNWcgQD6ncsIYkifR+Fnp1PF8HeZl4joURYMOqliNXGsv30EhvIM
         FzpDZGoE++4xVxp7t0xX99FSsCoAjAqQe1zFV5ObZXh+TtlO9TQ7Xm+D9ROxJoo+SDxK
         KySQ==
X-Gm-Message-State: APjAAAXUfFFdLOnzM7I2VmCquEJ/xI/BLGvIzApgELn3wTN6HUW1Tf3+
        VBhyjhoa9BLmKwKUP0nuVXPJxEI/Ykk3BQaYQwGHNBdSRvPSZydokiHLMvSkC3JW4mYrKFUD6mj
        XLwgm6aETwa5r
X-Received: by 2002:a19:4f46:: with SMTP id a6mr1404252lfk.143.1576668013032;
        Wed, 18 Dec 2019 03:20:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqlaCqKGYD7S5dXgPmnjBqGrEvYVNkoqtJrsUhaWjfIlY5zrdjeCx/y7G5k+BDdHM6r+iZvg==
X-Received: by 2002:a19:4f46:: with SMTP id a6mr1404240lfk.143.1576668012891;
        Wed, 18 Dec 2019 03:20:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2sm941321ljq.38.2019.12.18.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:20:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9C922180969; Wed, 18 Dec 2019 12:20:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 7/8] xdp: remove map_to_flush and map swap detection
In-Reply-To: <20191218105400.2895-8-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com> <20191218105400.2895-8-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:20:11 +0100
Message-ID: <87lfr96ftg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Now that all XDP maps that can be used with bpf_redirect_map() tracks
> entries to be flushed in a global fashion, there is not need to track
> that the map has changed and flush from xdp_do_generic_map()
> anymore. All entries will be flushed in xdp_do_flush_map().
>
> This means that the map_to_flush can be removed, and the corresponding
> checks. Moving the flush logic to one place, xdp_do_flush_map(), give
> a bulking behavior and performance boost.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

