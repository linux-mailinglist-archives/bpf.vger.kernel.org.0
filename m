Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761262F205B
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391163AbhAKUEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 15:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391347AbhAKUEr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Jan 2021 15:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610395401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yLQmMZ6ys2ugYI/+oq68twRYkMfh5hQqN9gZPb0xjU0=;
        b=HK45pl3DHS4GnZgkv+QYUz5WzC0hW3WUZustGn5yPNcCUANG6CbcHyZSoC89xF7cc87DBE
        sMp2rAzJmrY9wl6Cqb/raZ9sH2t4vGXpaPnJPh/5/DmWo1KCPdEEm0c0P0OUYLcsf99UeS
        uSi4bvo29CLCSVA8VLEp2ZLzvZYL3Uw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-mU1Q1U28OTS0KSShOV5d0A-1; Mon, 11 Jan 2021 15:03:19 -0500
X-MC-Unique: mU1Q1U28OTS0KSShOV5d0A-1
Received: by mail-wr1-f72.google.com with SMTP id w8so266904wrv.18
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 12:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yLQmMZ6ys2ugYI/+oq68twRYkMfh5hQqN9gZPb0xjU0=;
        b=p8B0CoDFRZLupeBlZR5vN3KRkBifYBolvL68MEYWbcgs0YrvGbbOhlBDzxKMZQ+Xer
         2p9tkH7coIxMyQ4qps1XJQesKPjT+LXmR/ySlPpaW0QSS9GFKyIasEy+DHPy0IRWRMzJ
         sVaWAF+eD54eeuNdvCLWRM5ri4PzmJ72HhYIo1SSU/CsTnlQAUoX6RdaAcjIF2qGTsV2
         MvhvxLa2VMFl5TGd8bZv8T40uXhCLD5Sl2oAZa9T38y5oRXGTBPGZpMbHodIbqWBblIo
         nL5Xd0axEjm7hZCrTlWvJ6i1cEQHXMSyPi9Vr6nqLpth2QvAsmRnP1S7EHAqrRJMQvTr
         pRsg==
X-Gm-Message-State: AOAM532EZ75/PMkZFYMh4mgjsk74nTyxElakLybLmVyvMWnvbv6+AVJY
        H0O2TZmhDUYLL43E+Jl7ff3IWX3oYvCS4beIMnBs6cG4Ott/wOeIzSw818liio9PcDDl589X/sL
        DIpeA1l1laXhR
X-Received: by 2002:adf:80d0:: with SMTP id 74mr777120wrl.110.1610395398557;
        Mon, 11 Jan 2021 12:03:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjT7R3mujYmNW1o0GxR3M9Qx/7k7gL8Def+uuyrNAHhm78ih8zfUFboPQVio6lTkUs4uTlXQ==
X-Received: by 2002:adf:80d0:: with SMTP id 74mr777085wrl.110.1610395397977;
        Mon, 11 Jan 2021 12:03:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s20sm441203wmj.46.2021.01.11.12.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:03:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0703218031A; Mon, 11 Jan 2021 21:03:17 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH] bpf: Prevent double bpf_prog_put call from
 bpf_tracing_prog_attach
In-Reply-To: <20210111191650.1241578-1-jolsa@kernel.org>
References: <20210111191650.1241578-1-jolsa@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 11 Jan 2021 21:03:16 +0100
Message-ID: <87y2gzi6m3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Olsa <jolsa@kernel.org> writes:

> The bpf_tracing_prog_attach error path calls bpf_prog_put
> on prog, which causes refcount underflow when it's called
> from link_create function.
>
>   link_create
>     prog =3D bpf_prog_get              <-- get
>     ...
>     tracing_bpf_link_attach(prog..
>       bpf_tracing_prog_attach(prog..
>         out_put_prog:
>           bpf_prog_put(prog);        <-- put
>
>     if (ret < 0)
>       bpf_prog_put(prog);            <-- put
>
> Removing bpf_prog_put call from bpf_tracing_prog_attach
> and making sure its callers call it instead.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

