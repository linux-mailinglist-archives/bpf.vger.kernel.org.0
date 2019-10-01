Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96B2C2DF8
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2019 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfJAHKQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Oct 2019 03:10:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51187 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726822AbfJAHKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Oct 2019 03:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569913815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FwK1cw+HTHejYMgpIxBGIUbF1NXkCBEpQH4yikdvzRc=;
        b=Q/gshWvcNmVZIRIRaIYJv0HRLCxxxeAlrxSmAIod6alsAP2TL718TjzYk0XGQmVP9s/O+D
        Md4uBvuLS83+SFT31DDrIWHg2rE67VHsf9RdZxeFx/yctE9f3OU4nLcNJCe40ttCT4fM44
        9/dPrDQ0ibItS/oiYra7kri+47spQPo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-kNNpazASOJKb0nzUDwE0nQ-1; Tue, 01 Oct 2019 03:10:13 -0400
Received: by mail-lj1-f200.google.com with SMTP id 5so3789439lje.12
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2019 00:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hqIzzpD8IOQLWmcd/1moh6fetqtyiKiVmX3233qBoxY=;
        b=Gyzm9zIko8iraCx3twfPqK+kATM23AAuYBe88MTsleEszXjaQ+Zcy6JC/0EKa3X05c
         9F65E46gnLWO5s9om/D+Ohbf2Z9U4qR54XMm2xqRsZc7mVMilKUOnXshxZsL6KdaQODf
         KOv4vFMFeETVVGBS0s8QXi5cSQhRzvDrhdocR8gKxij+FG9khzIY0+cLVffIc1L1Zjax
         QBENiKIxQNeiBIVs/I5C1h9mAWU18MHhqDQFmsoGf6xA3o0BZK7vU7yabwE/9XfoU1pV
         xP0iug3WkqqvpbNF2o9ouiBgjoJLFGemwuKDb5vmD+4dcRQL9RYpYlnVeNdzTDAZLKKx
         6HaA==
X-Gm-Message-State: APjAAAWrAUXydeo9ahHYYD4pvH30WNOoc3iDCsNN6eUz3Vieva8y4mQj
        8cvpSR7cWM5rB4kr1z4FM4fPJqWeB/yBorB3Rglrne0DHSpkzaO7qqyyfGn1mqz+2+jYtpbb6VG
        hjsU8nlJtOSF/
X-Received: by 2002:a2e:4296:: with SMTP id h22mr15129058ljf.208.1569913812089;
        Tue, 01 Oct 2019 00:10:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5zdtdRl6GeiHx7FeDGheYopkFgYAPPKNKhz2hYebf0a7QjqWVwALCnmww4Qavi6M7oJ8AHA==
X-Received: by 2002:a2e:4296:: with SMTP id h22mr15129039ljf.208.1569913811905;
        Tue, 01 Oct 2019 00:10:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id m17sm4638187lje.0.2019.10.01.00.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:10:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 60A2E18063D; Tue,  1 Oct 2019 09:10:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: move bpf_helpers.h, bpf_endian.h into libbpf
In-Reply-To: <20190930185855.4115372-3-andriin@fb.com>
References: <20190930185855.4115372-1-andriin@fb.com> <20190930185855.4115372-3-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 09:10:09 +0200
Message-ID: <87d0fhvt4e.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: kNNpazASOJKb0nzUDwE0nQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> +struct bpf_map_def {
> +=09unsigned int type;
> +=09unsigned int key_size;
> +=09unsigned int value_size;
> +=09unsigned int max_entries;
> +=09unsigned int map_flags;
> +=09unsigned int inner_map_idx;
> +=09unsigned int numa_node;
> +};

Didn't we agree on no new bpf_map_def ABI in libbpf, and that all
additions should be BTF-based?

-Toke

