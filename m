Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B371BBB93
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 12:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgD1Ks0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 06:48:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgD1Ks0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 06:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588070905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5Zy6MY1lit5ibuHW3UQvtHO3CqtEhEXXGm3gncifMQ=;
        b=YfuR1FvPPf5fbov4PRkG/WCg5LD4x7t5YP3arr6q3784xXaxA8mODiLOA3hPdrDidUIJ7H
        rv8g1KfyxtXy/7iiKlz7p2RBrgVlSmyH3D9E2s9QiuHl97l24NEt+mWhmdUI0NCy+cjmJY
        d2KKqIEjdpI8o/Ns6gvNV8Y09gWBmBM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-pqy7EoEQPRaBHVzKs5zTdA-1; Tue, 28 Apr 2020 06:48:23 -0400
X-MC-Unique: pqy7EoEQPRaBHVzKs5zTdA-1
Received: by mail-lf1-f71.google.com with SMTP id b22so8748497lfa.18
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 03:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=P5Zy6MY1lit5ibuHW3UQvtHO3CqtEhEXXGm3gncifMQ=;
        b=N/cYTvLfb4urIord7TZlLyi8xi1iZLw0uG0Ar0gouibkZvlSDFm0SUWp977uFwrsJm
         /PdM6zCZcIDQ2u9wZboHbvh7/Z039By/0msWDA/6nmaavlGVkUIv2h7+x20VU5gA04qL
         dzyCCXFPNO4orif/pHROwy7eWBUne1cQJOgVJ8jfK1Jnbg6S1TTtGtfBwFqKno2F7k66
         oVGcFLb3nTaJhxStqg7D+PCvtQyQYurmViJjST529Ne51GSLYFggLu2Po0g/54eLBrrE
         /gz0AJhOW5B7cmhxFgdS7t6hk7IkT9GQobuiul4a6FDtV7Wls5B2sISEBY3aGw7QEl5c
         6esA==
X-Gm-Message-State: AGi0Pubz1ImU4LdOvFZOPYZmL+pXNNr+t8tlHhNNkrX1uJiNOoBOlVNV
        Pv9P6sQAiEUnVi7kfl4+rRS0a1wL2iYEMr0EP5nAgA5e4HqHO5KtzcZH0b5m7uW4Acr29le6W+k
        3fRnWEefCd5xt
X-Received: by 2002:a19:c385:: with SMTP id t127mr18633986lff.117.1588070901853;
        Tue, 28 Apr 2020 03:48:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypIW3bJR+0Ocu75lOY0jfrtgbDFx4U8HPiSf2InAtZjQyAv3duSStl2T7mTfbKCYlL1c+vgCEQ==
X-Received: by 2002:a19:c385:: with SMTP id t127mr18633978lff.117.1588070901688;
        Tue, 28 Apr 2020 03:48:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g22sm11329734ljl.17.2020.04.28.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:48:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6E6971814FF; Tue, 28 Apr 2020 12:48:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v2 bpf-next 2/3] libbpf: refactor map creation logic and fix cleanup leak
In-Reply-To: <20200428064140.122796-3-andriin@fb.com>
References: <20200428064140.122796-1-andriin@fb.com> <20200428064140.122796-3-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 28 Apr 2020 12:48:19 +0200
Message-ID: <87blnbx4wc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Factor out map creation and destruction logic to simplify code and especi=
ally
> error handling. Also fix map FD leak in case of partially successful map
> creation during bpf_object load operation.
>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF o=
bjects")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Good catch on the fd leak!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

