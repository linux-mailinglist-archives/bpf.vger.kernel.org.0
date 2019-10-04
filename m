Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A59CB4B8
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 09:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbfJDHBW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 03:01:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27560 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387822AbfJDHBW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Oct 2019 03:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570172482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7sKR8lHgOs//1ZX2JG7IaLVTQKiw5ft09FgGbhCp5w=;
        b=QX5rBVI1nhSf7KfEogXXJl+P6AA/Ymod0jOezaVbHtCReJ/hKEzPmONSCof3XnTra5lIPr
        uT1LQLiZfRfaYu1oBKgeCWLF5zyOuM3vAw0varw2CiT83TpcQIisNPtcF1waiLc/jYD+hv
        ir+hPRS9nXFlmbhuKS0H1XfzcCF6Z0M=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-dORQjwzPM_GL5YPwt4-B-A-1; Fri, 04 Oct 2019 03:01:18 -0400
Received: by mail-lj1-f200.google.com with SMTP id h19so1488724ljc.5
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 00:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=a7sKR8lHgOs//1ZX2JG7IaLVTQKiw5ft09FgGbhCp5w=;
        b=LMQ/njs29tuiZdNmTWZ8w1O3Byj3hDwbjd10600QWzStXzXIbZfRG9wxURMLzhy6p1
         xuqr3q3Tv8TlYYPQlzha0elTdlOYd57tn3rKEM4p895Qr4R3bwuxcprmrRdHnedC2sIX
         qyjKusYIHjNjmqzNxlR7gwWymHSGW6X/qXGmmg46KaKVF9g7KGGfoL4jFcab+AkJittn
         BzPO++oh82Mq5PyYvloI6qKIQU4Yrp/Cl/Z+6D4iMrX0pmQgefcY/fYsD4AIaL4OoHdx
         Vs2TO41/GVb9brOHnUecib5a4T1ejZVmPWm/uoVl0sn/xQT+qjE9M83RMkLZJeTXjnYg
         O50w==
X-Gm-Message-State: APjAAAUDFg6az69/49i/B2tFGph7fpBpbrphCX1RwQIXm/JbITL1KFm2
        xY2XQF5DtDit5p0Xf6aktTkyB+dQK7Epmmh+KQTCiol3z5Ge62wZFcgVaurmVFrljUWOmUzmoZ3
        wccjf5OzftqlC
X-Received: by 2002:a19:f707:: with SMTP id z7mr8256042lfe.142.1570172476456;
        Fri, 04 Oct 2019 00:01:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+qyv0vaXwIRlImnSQAdgUqEb2zspoEtsVo+p2JoY74DJrgQ85FcFAdWogs4yc+OsyRLhy9A==
X-Received: by 2002:a19:f707:: with SMTP id z7mr8256021lfe.142.1570172476094;
        Fri, 04 Oct 2019 00:01:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id n5sm1333942ljh.54.2019.10.04.00.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 00:01:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D46F618063D; Fri,  4 Oct 2019 09:01:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v3 bpf-next 5/7] libbpf: move bpf_{helpers,endian,tracing}.h into libbpf
In-Reply-To: <20191003212856.1222735-6-andriin@fb.com>
References: <20191003212856.1222735-1-andriin@fb.com> <20191003212856.1222735-6-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Oct 2019 09:01:14 +0200
Message-ID: <87wodlnged.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: dORQjwzPM_GL5YPwt4-B-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Move bpf_helpers.h, bpf_tracing.h, and bpf_endian.h into libbpf. Ensure
> they are installed along the other libbpf headers. Also, adjust
> selftests and samples include path to include libbpf now.
>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

