Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2151CB4B0
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 09:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbfJDHAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 03:00:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388456AbfJDHAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 03:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570172420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8EyK1cVKkhMxyArw12T8tYjEZqilSb7AABG3zI0Hp2E=;
        b=S9AUDOVwYkuUNCelYiVuDwtNyFY7r2h+KotQ7Nb9CMoTCNwCittd91uvEXiQ64RQbSwHem
        oMYRXDFfRpCkclniBwctftnSonFFHgbA5R9eo640gShU+SAVrpA3eYQk3x1iOXS1YYiMvp
        62a1PuLKXKdyMTXMGT7P001pOfOMbR8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-ea0M041JPWi22kx5lKjGjQ-1; Fri, 04 Oct 2019 03:00:18 -0400
Received: by mail-lj1-f200.google.com with SMTP id v24so1470568ljh.23
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 00:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8EyK1cVKkhMxyArw12T8tYjEZqilSb7AABG3zI0Hp2E=;
        b=Oj5OV9/WzY84/6iajW0xoEtIuVyUy+HarMBj1eGwAkLbRx45pLpQCZd1JgiaKmvkr+
         AzYOk4vvmTo6m8XW61uGUwON4W9KeIMCgUrDXCd5Yoddq+DQzKbUPFKBN3ODvDGnXs5W
         G6SYfO3Yn55GwmYhjcbTDtWrvtHEljW43B3GwvWQNLvaMoC5gYHPg/VXxKzcdUGzIAEh
         TtkPPd+J8yQIW4r7zFJhL55ylFGTfCYL0SrkriZpG1rjqYPQJjOX/uxAVY9cA7vOVnQ1
         EBW53oGr6QNZwM9S15qL/KZew5dCEiQsUm47VwEZ545as4nkwuzdNh/Wn/5qKb/XeIwP
         b3hg==
X-Gm-Message-State: APjAAAVW9Rfb4GrZW7nU1rQOoEbmoBKz7oLmzyqDkJvopF64nEnvqwSb
        Bu6/SoFg/zGrGurTH2RQ1mMVaU4UHtK6wb19FtcxY4T/jutTxHti/JM2VheoXpNMOtxhTGFHFRV
        0xDltGQIAA/Kh
X-Received: by 2002:a2e:b1ce:: with SMTP id e14mr8281159lja.135.1570172417108;
        Fri, 04 Oct 2019 00:00:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz51eZ7+KoSwTzay+lh1nndT6s8FnzF2hCCR7+MAAVdzubj44stcpUFZ/rmV5qe5rZz4nM3EQ==
X-Received: by 2002:a2e:b1ce:: with SMTP id e14mr8281154lja.135.1570172416979;
        Fri, 04 Oct 2019 00:00:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b7sm930591lfp.23.2019.10.04.00.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 00:00:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B2D9218063D; Fri,  4 Oct 2019 09:00:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v3 bpf-next 2/7] selftests/bpf: samples/bpf: split off legacy stuff from bpf_helpers.h
In-Reply-To: <20191003212856.1222735-3-andriin@fb.com>
References: <20191003212856.1222735-1-andriin@fb.com> <20191003212856.1222735-3-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Oct 2019 09:00:15 +0200
Message-ID: <8736g9ov0g.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: ea0M041JPWi22kx5lKjGjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Split off few legacy things from bpf_helpers.h into separate
> bpf_legacy.h file:
> - load_{byte|half|word};
> - remove extra inner_idx and numa_node fields from bpf_map_def and
>   introduce bpf_map_def_legacy for use in samples;
> - move BPF_ANNOTATE_KV_PAIR into bpf_legacy.h.
>
> Adjust samples and selftests accordingly by either including
> bpf_legacy.h and using bpf_map_def_legacy, or switching to BTF-defined
> maps altogether.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

