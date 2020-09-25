Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7F2792C9
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 22:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgIYU5X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 16:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgIYU5U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Sep 2020 16:57:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601067438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EiL2XllvQB2LfKSShysemCAoHS0xuIwlKbztT1dTxBk=;
        b=WIHyxVX/Rcl/sBQrCd0iER3euh0XNrju9sBD5wNO0VthT1X6r59qSwuJWHr4zXPg7m2Ypa
        tr9y/4+DwDcjPipp5cGLS3Ip9K8T0YtfRwRXRK/mOUssW8Ep5KX3RAIiBgJHy2pDhI0o/D
        du+ozlhdcUtDGWfmvSRymHcuHGDiQFU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-2TMCNw1ONkeNg1QB5KaZ4g-1; Fri, 25 Sep 2020 16:57:14 -0400
X-MC-Unique: 2TMCNw1ONkeNg1QB5KaZ4g-1
Received: by mail-wm1-f71.google.com with SMTP id 23so110987wmk.8
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 13:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EiL2XllvQB2LfKSShysemCAoHS0xuIwlKbztT1dTxBk=;
        b=If5bOCXNVH2u8Hkck3N9NI2G9Lj98x6wB7U7zzusfLzPFbhktuYjYq7kpFouRyC864
         YbB0G0mwTjME4SMDdYmEof52CDs8vyiWy0ubcaUjlr7vmcDwcED7zCaG56v3eL16xkVI
         t1rwZi5sKVzP9QkVgF0l+crSc56A4z3nCabMOURoofWWz3Nw+VjhFqnBsB3cetW4uDqQ
         oWBpM34EECCIZoTPSwNkqNlnIcZClab18ekPzZbev7if1QcD2DL610ymJRgQCJxv6+Ki
         2n9zLiYVVPQMrHt1fTVeQlK5PK+oW+F/v6MqDuy5TC/ws1ppl2M4l7zJzZmhHdybmF6F
         7+nA==
X-Gm-Message-State: AOAM532u/pMhVFTZcFIl54u3U5s9gcG9VQCFst1UXLNh4mdqqrMbrWdY
        y+7DD2ykvjL1Frx/LBb9SQ9nJRqlN+j0TcKtQEB/U6mXD66sUO2+Gtw9VOvxN3WEBqSYEgUyTNb
        +rI/5h8A+BuHF
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr6376753wrj.1.1601067433549;
        Fri, 25 Sep 2020 13:57:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZfFA8ey5Qyk+yQKrYbWllg18SZYqXB51nWXG9iuDFjMRWMmI/xMmHWanoHvg+YD5hac8VxA==
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr6376726wrj.1.1601067433293;
        Fri, 25 Sep 2020 13:57:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 92sm4524389wra.19.2020.09.25.13.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:57:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2E8FC183C5B; Fri, 25 Sep 2020 22:57:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 04/11] bpf: move prog->aux->linked_prog and
 trampoline into bpf_link on attach
In-Reply-To: <CAADnVQLMBKAYsbS4PO87yVrPWJEf9H3qzpsL-p+gFQpcomDw2w@mail.gmail.com>
References: <160079991372.8301.10648588027560707258.stgit@toke.dk>
 <160079991808.8301.6462172487971110332.stgit@toke.dk>
 <20200924001439.qitbu5tmzz55ck4z@ast-mbp.dhcp.thefacebook.com>
 <87tuvmbztw.fsf@toke.dk>
 <CAADnVQLMBKAYsbS4PO87yVrPWJEf9H3qzpsL-p+gFQpcomDw2w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 25 Sep 2020 22:57:12 +0200
Message-ID: <878scx60d3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Sep 24, 2020 at 3:00 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> >> +    struct mutex tgt_mutex; /* protects tgt_* pointers below, *after=
* prog becomes visible */
>> >> +    struct bpf_prog *tgt_prog;
>> >> +    struct bpf_trampoline *tgt_trampoline;
>> >>      bool verifier_zext; /* Zero extensions has been inserted by veri=
fier. */
>> >>      bool offload_requested;
>> >>      bool attach_btf_trace; /* true if attaching to BTF-enabled raw t=
p */
>> > ...
>> >>  struct bpf_tracing_link {
>> >>      struct bpf_link link;
>> >>      enum bpf_attach_type attach_type;
>> >> +    struct bpf_trampoline *trampoline;
>> >> +    struct bpf_prog *tgt_prog;
>> >
>> > imo it's confusing to have 'tgt_prog' to mean two different things.
>> > In prog->aux->tgt_prog it means target prog to attach to in the future.
>> > Whereas here it means the existing prog that was used to attached to.
>> > They kinda both 'target progs' but would be good to disambiguate.
>> > May be keep it as 'tgt_prog' here and
>> > rename to 'dest_prog' and 'dest_trampoline' in prog->aux ?
>>
>> I started changing this as you suggested, but I think it actually makes
>> the code weirder. We'll end up with a lot of 'tgt_prog =3D
>> prog->aux->dest_prog' assignments in the verifier, unless we also rename
>> all of the local variables, which I think is just code churn for very
>> little gain (the existing 'target' meaning is quite clear, I think).
>
> you mean "churn" just for this patch. that's fine.
> But it will make names more accurate for everyone reading it afterwards.
> Hence I prefer distinct and specific names where possible.
>
>> I also think it's quite natural that the target moves; I mean, it's
>> literally the same pointer being re-assigned from prog->aux to the link.
>> We could rename the link member to 'attached_tgt_prog' or something like
>> that, but I'm not sure it helps (and I don't see much of a problem in
>> the first place).
>
> 'attached_tgt_prog' will not be the correct name.
> There is 'prog' inside the link already. That's 'attached' prog.
> Not this one. This one is the 'attached_to' prog.
> But such name would be too long.
> imo calling it 'dest_prog' in aux is shorter and more obvious.

Meh, don't really see how it helps ('destination' and 'target' are
literally synonyms). But I don't care enough to bikeshed about it
either, so I'll just do a search/replace...

-Toke

