Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88643C6EAD
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhGMKjw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 06:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbhGMKjw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 06:39:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C563C0613DD
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 03:37:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id l26so24202106eda.10
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPbq5NcxcWQnhCYR27K6z3J1R/MbKXRGpt08bx05/o4=;
        b=T0ULi/i0vZ4UrkO63TANxhqnNtfT61VRg6boRvbsH+o8iP5RJInrqJ/cqBTZmEWUte
         VocBUavTgWlc6xOctjgSON62VRpQOBjgJ+ntAT75guq8jol/nm0B6PgUIkbvXILf+jMR
         QFScUPMA8/PIMatgnbva4bhglVjcf6wA86stePtaKWn5CDoDm/77O6hoo2U3h0z/pD63
         +WoXGeBnyXEBQRBdOaOWZ3a/I8xGZyxgc/7I27WiWfwR42P418CG0ca/yhV+rhZocxlQ
         hPI5BTKgQZhhjllSmWlfj7VEngC4+417nsDQTinzuRHxZm2YTmmqB/yYpQ7oyG4Py4ej
         YYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPbq5NcxcWQnhCYR27K6z3J1R/MbKXRGpt08bx05/o4=;
        b=Z+ZuH2l6lJw/yhGDOEcNNWs6ox6j7u2dO+hEvZRO9/+8thf1og0Vm/0TjfQMwR7irJ
         XXVyGUGrbXU0tVWiHNzIN+V2jEq5X9IVgitnRZ0Z9L+DuFioAPxAK4wYwuIIe+E0qhmZ
         sUFthT//VhMk6OiIunJLNiST1yj85sc7H0n++NM3c277gBr9bn/t8WTr+PDEoklPWmMG
         PspSzuaW0i+W9ZipMWq9xJQ/ZFOzWY75cs1rSEmLWDwkEa04bkWXYUhz6guSGjIN4Tj2
         tap1Jq36zIHFv2xCxNRTQn/n8G+Wk7ZrBqlxc2ZxkFDjXNOAej4JnBjcR1nL/zKITR21
         LgLw==
X-Gm-Message-State: AOAM530aqMp9uilR4578mFwB3/Q6bWKyHvrZbUT3Jw/PnsOgCkTOxjdc
        ZjTkerkhVzO1LEsyPUbxcQxRhe6sZD8rWn9w
X-Google-Smtp-Source: ABdhPJzsFn+MDCyNZE+0hiQJq/EKEPQDkOFFyREg3VWG2Gd9JUJKOCauDTv92UGB0R3hsxkBue8hnQ==
X-Received: by 2002:aa7:cac8:: with SMTP id l8mr4729528edt.135.1626172620761;
        Tue, 13 Jul 2021 03:37:00 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id qp12sm7924783ejb.90.2021.07.13.03.36.59
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 03:36:59 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id d12so29191334wre.13
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 03:36:59 -0700 (PDT)
X-Received: by 2002:a5d:5257:: with SMTP id k23mr4877698wrc.50.1626172618961;
 Tue, 13 Jul 2021 03:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210713102719.8890-1-tklauser@distanz.ch>
In-Reply-To: <20210713102719.8890-1-tklauser@distanz.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 13 Jul 2021 12:36:20 +0200
X-Gmail-Original-Message-ID: <CA+FuTSes3Lr0yGTc6GHGzgfPz4w6ReP_vnMKn=OeVhWgcpcOqA@mail.gmail.com>
Message-ID: <CA+FuTSes3Lr0yGTc6GHGzgfPz4w6ReP_vnMKn=OeVhWgcpcOqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove unused variable in
 tc_tunnel prog
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 13, 2021 at 12:27 PM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> The variable buf is unused since commit 005edd16562b ("selftests/bpf:
> convert bpf tunnel test to BPF_ADJ_ROOM_MAC"). Remove it to fix the
> following warning:
>
>     test_tc_tunnel.c:531:7: warning: unused variable 'buf' [-Wunused-variable]
>
> Fixes: 005edd16562b ("selftests/bpf: convert bpf tunnel test to BPF_ADJ_ROOM_MAC")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks for the fix, Tobias.
