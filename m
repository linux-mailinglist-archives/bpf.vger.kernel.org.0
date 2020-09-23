Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9C2762A1
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 22:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWU60 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 16:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgIWU60 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Sep 2020 16:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600894704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbvhTKklclsI9zCmQ1AhhPMI2tbrWk7sY+kWgVzvbmI=;
        b=b48sP14k17wwn3D6MKTIrkJ7dAooxIhg/o2Kmz0Mw90+WrVCy4Ch/swE8xwxlhfLEnJ6Ac
        84tnIohQeYQY9AW72jHpLw0UOemiWTA8IG7s8SSl6yopJNQUGFXPg7mUE/8GpuMgkTFWfg
        kbOiscQR1mWtk9tTySiaIPBkng6V7GI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-AbQq6T_GMq2MQU6y_OtQpg-1; Wed, 23 Sep 2020 16:58:22 -0400
X-MC-Unique: AbQq6T_GMq2MQU6y_OtQpg-1
Received: by mail-wm1-f72.google.com with SMTP id x81so374676wmg.8
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 13:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CbvhTKklclsI9zCmQ1AhhPMI2tbrWk7sY+kWgVzvbmI=;
        b=qp24EiFrw1SkowVXoDgoFxLplW2xaZbuvIGUGr7dOVIhrprhEcvzYTjQ/rBreEyIWB
         2I7J+dBdtHqhTcM6VkiIxMBawzRf0du0NU6c2y5hqV3Hm2D/jP5i71a8KNuNrWZK7z/V
         Yq6/gKkF/PMlsQwzwkxBfk5JKmZo8R2Wqrcw0jejDiuaoB5+W0+dQOWY5KuTogdHJh7o
         MQXmihpZtwUEyJJ4LyA7PQD1mN1cwCsfZXwr4Qs76G3b5sg0B+oCUJgqBxxPYTTANKcy
         8YTvmTpOcixTac9G7W2bJ2lmkyp8TbdgyjXyntqNlTmxc2XtHec/vPTyVOMUnqYvWXjD
         +J7g==
X-Gm-Message-State: AOAM5314M5B09URvWk1hUxdR8yIesaL5S/rKuW2DjVZbrYOPS/imqsH4
        mpRm1qNy6b6GpZpMn5Hbp1lyFncbchWrwq/NZe8Wh2JzOqxDsAeHcPGGHdLm15ZXAHLXOmwi4Mn
        rBz+VnMTQ0MtM
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr1445963wrn.47.1600894701139;
        Wed, 23 Sep 2020 13:58:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKIi4o1DnWBrnf7v3xh/SLjRJqh2QPYcFIZypc466O2I1YM5azEUnr24a+Og9abmTi1cOHfg==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr1445938wrn.47.1600894700595;
        Wed, 23 Sep 2020 13:58:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u63sm947897wmb.13.2020.09.23.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:58:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8AF54183A90; Wed, 23 Sep 2020 22:58:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 07/11] libbpf: add support for freplace
 attachment in bpf_link_create
In-Reply-To: <CAEf4BzZuMUA2B+Nz+7GfpoW2SGF3tyUpjRsjP2cX3VGH34OHgw@mail.gmail.com>
References: <160079991372.8301.10648588027560707258.stgit@toke.dk>
 <160079992129.8301.9319405264647976548.stgit@toke.dk>
 <CAEf4BzZuMUA2B+Nz+7GfpoW2SGF3tyUpjRsjP2cX3VGH34OHgw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Sep 2020 22:58:19 +0200
Message-ID: <87ft78nrbo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Sep 22, 2020 at 11:39 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> This adds support for supplying a target btf ID for the bpf_link_create()
>> operation, and adds a new bpf_program__attach_freplace() high-level API =
for
>> attaching freplace functions with a target.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> LGTM.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Awesome! Thanks again for your (as always) thorough review (for the
whole series, of course) :)

-Toke

