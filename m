Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D7226E141
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgIQQyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Sep 2020 12:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728713AbgIQQyV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Sep 2020 12:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600361660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pcr1KRCcZTluQX2F3AfgYRvNhcgJfYVSd/vHCvr/qrY=;
        b=g1A9RggMfD4ijF8kluznFT73uF/8yGr7f85dR9aCKh93RittoiVIC9wXevVIvAyTqxw/l6
        s6UXf/3+3koSAaKTPgQPZ+qBbfz1OIeDpw7g79anLx5S59R5aH+rZiLHxFHyoz5dCxt/Jn
        uKEClg2yAuzOcXhPxLQ4YAo70iaOqh0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-_Z0bPnoxMB-EcyQoNNwZ0A-1; Thu, 17 Sep 2020 12:54:16 -0400
X-MC-Unique: _Z0bPnoxMB-EcyQoNNwZ0A-1
Received: by mail-ed1-f72.google.com with SMTP id m88so1173612ede.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2020 09:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Pcr1KRCcZTluQX2F3AfgYRvNhcgJfYVSd/vHCvr/qrY=;
        b=d2G+9CXCSP2alr+jR41a/R+hdL6NohciM7J8AKXHaqhR8kkPKRtOt+HnO2r2w35bEQ
         RQzftWt8MLwK1XPddtq+mtxiJZcyQOSb1YlzR1KiL291xdAOb5L2dEIFoM7aI/dJEz/F
         HwfBty3AhsiKlbPAIjU5wVavttXt/KZ5U6zxOb9UbfkaR8R4TkgKK1kT28thU48phPQn
         /FHOx7g7O3upJKdYzrctHbasqCC8pJ3Xs941W/prqS0qKLJE6/looOML6fmxlzgsIqbx
         y5EeMaMxhHfCV6vXLAaOgX/YRx6qL1IOjIN8ysnfMv3GI9N20cgMmgUylwcn2k8LXTOZ
         tFBw==
X-Gm-Message-State: AOAM530mdVfBFoNCscF9GHFfvbIMvZN0RRY/E8W0YiKokcFzznscwZGA
        Jfg9uaZQlSVUB8GvQxrDCX91mauxyaHtA1/KxTxYAQx02Y7J+SaZ+Epz/nZEANenv6b0WDLCkEI
        Yxnd9CR1KDSms
X-Received: by 2002:aa7:d593:: with SMTP id r19mr15437919edq.331.1600361654931;
        Thu, 17 Sep 2020 09:54:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT2EJuNw5+m4yBbrH0gyO4GEhkUcaphftMFOzkJ88vFzUciikgtEbk5qWBCi38cP3UuMebuQ==
X-Received: by 2002:aa7:d593:: with SMTP id r19mr15437895edq.331.1600361654741;
        Thu, 17 Sep 2020 09:54:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k1sm312392eji.20.2020.09.17.09.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 09:54:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 97E7F183A90; Thu, 17 Sep 2020 18:54:12 +0200 (CEST)
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
Subject: Re: [PATCH bpf-next v5 2/8] bpf: verifier: refactor
 check_attach_btf_id()
In-Reply-To: <CAEf4Bzbs1cGO7u8X08isxMjub5nJCBs-kNOM1swM+3uwRNPFEA@mail.gmail.com>
References: <160017005691.98230.13648200635390228683.stgit@toke.dk>
 <160017005916.98230.1736872862729846213.stgit@toke.dk>
 <CAEf4BzbAsnzAUPksUs+bcNuuUPkumc15RLESu3jOGf87mzabBA@mail.gmail.com>
 <87lfh8ogyt.fsf@toke.dk>
 <CAEf4Bzbs1cGO7u8X08isxMjub5nJCBs-kNOM1swM+3uwRNPFEA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Sep 2020 18:54:12 +0200
Message-ID: <87wo0smjij.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Sep 17, 2020 at 3:06 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> >>
>> >> +int bpf_check_attach_target(struct bpf_verifier_log *log,
>> >> +                           const struct bpf_prog *prog,
>> >> +                           const struct bpf_prog *tgt_prog,
>> >> +                           u32 btf_id,
>> >> +                           struct btf_func_model *fmodel,
>> >> +                           long *tgt_addr,
>> >> +                           const char **tgt_name,
>> >> +                           const struct btf_type **tgt_type);
>> >
>> > So this is obviously an abomination of a function signature,
>> > especially for a one exported to other files.
>> >
>> > One candidate to remove would be tgt_type, which is supposed to be a
>> > derivative of target BTF (vmlinux or tgt_prog->btf) + btf_id,
>> > **except** (and that's how I found the bug below), in case of
>> > fentry/fexit programs attaching to "conservative" BPF functions, in
>> > which case what's stored in aux->attach_func_proto is different from
>> > what is passed into btf_distill_func_proto. So that's a bug already
>> > (you'll return NULL in some cases for tgt_type, while it has to always
>> > be non-NULL).
>>
>> Okay, looked at this in more detail, and I don't think the refactored
>> code is doing anything different from the pre-refactor version?
>>
>> Before we had this:
>>
>>                 if (tgt_prog && conservative) {
>>                         prog->aux->attach_func_proto =3D NULL;
>>                         t =3D NULL;
>>                 }
>>
>> and now we just have
>>
>>                 if (tgt_prog && conservative)
>>                         t =3D NULL;
>>
>> in bpf_check_attach_target(), which gets returned as tgt_type and
>> subsequently assigned to prog->aux->attach_func_proto.
>
> Yeah, you are totally right, I don't know how I missed that
> `prog->aux->attach_func_proto =3D NULL;`, sorry about that.

No worries - this was certainly not the easiest to review; thanks for
sticking with it! :)

[..]

> Please add my ack when you post a new version:
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Will do, thanks!

-Toke

