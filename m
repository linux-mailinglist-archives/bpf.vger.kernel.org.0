Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782ED66DD75
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 13:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjAQMXI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 07:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjAQMW6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 07:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589F12B603
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 04:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673958135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3PW2rptG67A9v/XuwxDVwyicikTSuZCj9iSrujRHV8=;
        b=Dl/LMk0gxJQC2iGb9J3Q6p1Xe0MHJ3s8QSZ10OrtVsLlJYHgR4rIT9xa0Kq7NV0DUlAspd
        jC+tJQQHDliW+DiPmDA/jRsTdwq2nEhJ3mCD2a7+N8Tq+QnWj16aZwiIAWLlyWLBGXnxlU
        SFXEV/UstcVkzO/TX/rkx8nOjt83ljk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-Iip_5-bIOE2nz0GywWLiMA-1; Tue, 17 Jan 2023 07:22:14 -0500
X-MC-Unique: Iip_5-bIOE2nz0GywWLiMA-1
Received: by mail-ed1-f69.google.com with SMTP id f11-20020a056402354b00b0049e18f0076dso3614531edd.15
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 04:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3PW2rptG67A9v/XuwxDVwyicikTSuZCj9iSrujRHV8=;
        b=710/QPxLv1OQqvptMbSl+vpK9ARYpxaTV9S0P/s1wsCm8xToBhBaMVPaDLxSIoNL/X
         lyDNKS4x/bkQ5Xmb0xIQ4jgAPVIw1r4lxN4sObKH+6tcruglCmf/qKeGNkX1EnRW0UYP
         wTd362zlmVGn8t/pVJrPWGnXP8CdQrk9kVqbiC3p9IAd4LjTpRz6YUmb4C3g2fvRKYVf
         RLRVKhlZQ/6ywmj2AqPqBlB1PdVf3y+4v27olIfKrxKWo53+lZMNTE+cLZO/UPO/Ctmi
         OkOBziN+AaKHi5n4GGmh3BBUcTzE/ktYOpKaH2aF2uarObFN+XoeenXFg6LRzahflS9l
         LhfQ==
X-Gm-Message-State: AFqh2kokqG7ipatI493cQrLpjtkUv8Ioim4qnqq6wlRgn4+OV99cA2TZ
        XzOnR1imnbfGi6yLjltsBajuWkzMy8+bkNHJ7JOgWHRzHAptkmXtPCkV+x03i7nE8LijBi2GEmv
        tXSMAg0bWp4pY
X-Received: by 2002:aa7:c052:0:b0:475:dddc:374a with SMTP id k18-20020aa7c052000000b00475dddc374amr2929470edo.18.1673958132665;
        Tue, 17 Jan 2023 04:22:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXub7srECIl+OsLq8BNow3a4Xx/BBN3gZipjrfQdYQGmMB7FgRt1Q5vpHNjCXJojEMH9nErGcA==
X-Received: by 2002:aa7:c052:0:b0:475:dddc:374a with SMTP id k18-20020aa7c052000000b00475dddc374amr2929402edo.18.1673958130999;
        Tue, 17 Jan 2023 04:22:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c7029b24dsm13191076ejc.151.2023.01.17.04.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 04:22:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C9B909010F8; Tue, 17 Jan 2023 13:22:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH bpf-next] Documentation/bpf: Add a description of
 "stable kfuncs"
In-Reply-To: <bb5b4544-7011-ecca-5d10-cb7c6e72f181@iogearbox.net>
References: <20230116225724.377099-1-toke@redhat.com>
 <6deb800f-57d8-9ee5-d588-ee6354e74aa9@iogearbox.net>
 <87fsc9csa5.fsf@toke.dk>
 <bb5b4544-7011-ecca-5d10-cb7c6e72f181@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Jan 2023 13:22:09 +0100
Message-ID: <87cz7dcpvy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 1/17/23 12:30 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>=20
>>> On 1/16/23 11:57 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Following up on the discussion at the BPF office hours, this patch add=
s a
>>>> description of the (new) concept of "stable kfuncs", which are kfuncs =
that
>>>> offer a "more stable" interface than what we have now, but is still not
>>>> part of UAPI.
>>>>
>>>> This is mostly meant as a straw man proposal to focus discussions arou=
nd
>>>> stability guarantees. From the discussion, it seemed clear that there =
were
>>>> at least some people (myself included) who felt that there needs to be=
 some
>>>> way to export functionality that we consider "stable" (in the sense of
>>>> "applications can rely on its continuing existence").
>>>>
>>>> One option is to keep BPF helpers as the stable interface and implement
>>>> some technical solution for moving functionality from kfuncs to helpers
>>>> once it has stood the test of time and we're comfortable committing to=
 it
>>>> as a stable API. Another is to freeze the helper definitions, and inst=
ead
>>>> use kfuncs for this purpose as well, by marking a subset of them as
>>>> "stable" in some way. Or we can do both and have multiple levels of "s=
table",
>>>> I suppose.
>>>>
>>>> This patch is an attempt to describe what the "stable kfuncs" idea mig=
ht look
>>>> like, as well as to formulate some criteria for what we mean by "stabl=
e", and
>>>> describe an explicit deprecation procedure. Feel free to critique any =
part
>>>> of this (including rejecting the notion entirely).
>>>>
>>>> Some people mentioned (in the office hours) that should we decide to g=
o in
>>>> this direction, there's some work that needs to be done in libbpf (and
>>>> probably the kernel too?) to bring the kfunc developer experience up t=
o par
>>>> with helpers. Things like exporting kfunc definitions to vmlinux.h (to=
 make
>>>> them discoverable), and having CO-RE support for using them, etc. I ki=
nda
>>>> consider that orthogonal to what's described here, but I added a
>>>> placeholder reference indicating that this (TBD) functionality exists.
>>>
>>> Thanks for the writeup.. I did some edits to your sections to make some=
 parts
>>> more clear and to leave out other parts (e.g. libbpf-related bits which=
 are not
>>> relevant in here and it's one of many libs). I also edited some parts t=
o leave
>>> us more flexibility. Here would be my take mixed in:
>>=20
>> Edits LGTM, with just one nit, below:
>>=20
>>> 3. API (in)stability of kfuncs
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>
>>> By default, kfuncs exported to BPF programs are considered a kernel-int=
ernal
>>> interface that can change between kernel versions. In the extreme case =
that
>>> could also include removal of a kfunc. This means that BPF programs usi=
ng
>>> kfuncs might need to adapt to changes between kernel versions. In other=
 words,
>>> kfuncs are _not_ part of the kernel UAPI! Rather, these kfuncs can be t=
hought
>>> of as being similar to internal kernel API functions exported using the
>>> ``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionali=
ty must
>>> initially start out as kfuncs.
>>>
>>> 3.1 Promotion to "stable"
>>> -------------------------
>>>
>>> While kfuncs are by default considered unstable as described above, som=
e kfuncs
>>> may warrant a stronger stability guarantee and could be marked as *stab=
le*. The
>>> decision to move a kfunc to *stable* is taken on a case-by-case basis a=
nd has
>>> a high barrier, taking into account its usefulness under longer-term pr=
oduction
>>> deployment without any unforeseen API issues or limitations. In general=
, it is
>
> Forgot, we should probably also add after "[...] or limitations.":
>
>    Such promotion request along with aforementioned argumentation on why =
a kfunc
>    is ready to be stabilized must be driven from developer-side.

What does "driven from developer-side" mean, exactly? And what kind of
developers (BPF app developers, or kernel devs)?

>>> not expected that every kfunc will turn into a stable one - think of it=
 as an
>>> exception rather than the norm. kfuncs which have been promoted to stab=
le are
>>> then marked using the ``KF_STABLE`` tag. The possibility from a stable =
kfunc to
>>> a BPF helper addition is up to the maintainers to decide.
>>>
>>> 1. Stable kfuncs will not change their function signature or functional=
ity in
>>>      a way that may cause incompatibilities for BPF programs calling th=
e function.
>>>
>>> 2. The BPF community will make every reasonable effort to keep stable k=
funcs
>>>      around as long as they continue to be useful to real-world BPF app=
lications.
>>>
>>> 3. Should a stable kfunc turn out to be no longer useful, a deprecation=
 procedure
>>>      might be implemented for them as outlined below.
>>=20
>> "deprecation procedure might be implemented" could be interpreted as "we
>> may implement a deprecation procedure, or we may just remove it without
>> one". Which is presumably not what you meant? So maybe:
>>=20
>>   3. Should a stable kfunc turn out to be no longer useful, the BPF
>>      community may decide to eventually remove it. In this case, before
>>      being removed that kfunc will go through a deprecation procedure as
>>      outlined below.
>
> Yes, that sounds good to me.

Awesome!

-Toke

