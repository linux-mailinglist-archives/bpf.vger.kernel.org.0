Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D257B66E0FB
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 15:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjAQOjp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 09:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjAQOjn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 09:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2083D0AB
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673966343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uy+KpEzO2F+xUjIbaXpmEN6WCMLXwzV+62jjuPIyVw=;
        b=Gphy3sPwJQmiAtRSCz/ASpo3xkgskeFqGI/aN90l0KzKQ+ThMVBlucTFJOOFgWuMzektiP
        XZk/KnzLZKFVxTx9eOlrFQ7QkJKYoRwlojxVnx4piCLBJy0SDYsOw1Er+7YCuWaUi+1s5F
        hcheqForYASjVJwIMHCA9ru1MUdSCJY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-_f5s0pDnN7m8o_6Dz99t2Q-1; Tue, 17 Jan 2023 09:38:57 -0500
X-MC-Unique: _f5s0pDnN7m8o_6Dz99t2Q-1
Received: by mail-ed1-f71.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso21406046edd.14
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 06:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uy+KpEzO2F+xUjIbaXpmEN6WCMLXwzV+62jjuPIyVw=;
        b=7MbipzSswa0QwEHaR85lqWhDLLHfiSXn3KhXmHoHwP9DufGIKXnW07lhxzcvfMYR31
         GNCm+l6Ih7uWpUJCD4jmULrki/9WCs6+KnNKvELGX0tmw+XjI4Cc6kXvnm2BH0yBGCu1
         2Z6xpMphzaqbnQwrSBPhecJtmiiTk+Nh19IXdla0Y/hu5fiPKLdolzCMpSbdkGWJzHc3
         BZgo1lE/N4Vy4a1qoG80ZM0x9fyOodSKyQtBeCeuCchhBOythcNsmGbupfQsdz2Ak/Y1
         SS4UEyzvrTthq6ZJOlJDWZhTviMjcSfPBv4VOs7Vku9MrvbR1/y2RwQJItRbk1qRjEaY
         +nAg==
X-Gm-Message-State: AFqh2ko/do1Tbj8/NNBvf6rMNv0o7jVB4bvv4GkqtM8wTAnkQ+ORiJiU
        1mCPfwVu0xWtKi/ltOPCmXEwSPPk5VJq0BN5NlGZ4Mm+wQrbR4M66AC1YojTmXd2YCvrwVh34ne
        fK+abHwW6jJay
X-Received: by 2002:a05:6402:1381:b0:499:7cf3:a452 with SMTP id b1-20020a056402138100b004997cf3a452mr16169560edv.14.1673966329851;
        Tue, 17 Jan 2023 06:38:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt/ZEyX/heSpW4dB3/eMoyxMhCB7Pbb7CSZN6MQdj7d+0GeuXxnO+TIEPsXszxSiVCWb5Plhg==
X-Received: by 2002:a05:6402:1381:b0:499:7cf3:a452 with SMTP id b1-20020a056402138100b004997cf3a452mr16169488edv.14.1673966328992;
        Tue, 17 Jan 2023 06:38:48 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m20-20020aa7c2d4000000b00495f4535a33sm13001414edp.74.2023.01.17.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:38:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6684901121; Tue, 17 Jan 2023 15:38:47 +0100 (CET)
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
In-Reply-To: <aaa31102-7ac9-0b39-b545-a51352deaf27@iogearbox.net>
References: <20230116225724.377099-1-toke@redhat.com>
 <6deb800f-57d8-9ee5-d588-ee6354e74aa9@iogearbox.net>
 <87fsc9csa5.fsf@toke.dk>
 <bb5b4544-7011-ecca-5d10-cb7c6e72f181@iogearbox.net>
 <87cz7dcpvy.fsf@toke.dk>
 <aaa31102-7ac9-0b39-b545-a51352deaf27@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Jan 2023 15:38:47 +0100
Message-ID: <874jspcjk8.fsf@toke.dk>
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

> On 1/17/23 1:22 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>> On 1/17/23 12:30 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>> On 1/16/23 11:57 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Following up on the discussion at the BPF office hours, this patch a=
dds a
>>>>>> description of the (new) concept of "stable kfuncs", which are kfunc=
s that
>>>>>> offer a "more stable" interface than what we have now, but is still =
not
>>>>>> part of UAPI.
>>>>>>
>>>>>> This is mostly meant as a straw man proposal to focus discussions ar=
ound
>>>>>> stability guarantees. From the discussion, it seemed clear that ther=
e were
>>>>>> at least some people (myself included) who felt that there needs to =
be some
>>>>>> way to export functionality that we consider "stable" (in the sense =
of
>>>>>> "applications can rely on its continuing existence").
>>>>>>
>>>>>> One option is to keep BPF helpers as the stable interface and implem=
ent
>>>>>> some technical solution for moving functionality from kfuncs to help=
ers
>>>>>> once it has stood the test of time and we're comfortable committing =
to it
>>>>>> as a stable API. Another is to freeze the helper definitions, and in=
stead
>>>>>> use kfuncs for this purpose as well, by marking a subset of them as
>>>>>> "stable" in some way. Or we can do both and have multiple levels of =
"stable",
>>>>>> I suppose.
>>>>>>
>>>>>> This patch is an attempt to describe what the "stable kfuncs" idea m=
ight look
>>>>>> like, as well as to formulate some criteria for what we mean by "sta=
ble", and
>>>>>> describe an explicit deprecation procedure. Feel free to critique an=
y part
>>>>>> of this (including rejecting the notion entirely).
>>>>>>
>>>>>> Some people mentioned (in the office hours) that should we decide to=
 go in
>>>>>> this direction, there's some work that needs to be done in libbpf (a=
nd
>>>>>> probably the kernel too?) to bring the kfunc developer experience up=
 to par
>>>>>> with helpers. Things like exporting kfunc definitions to vmlinux.h (=
to make
>>>>>> them discoverable), and having CO-RE support for using them, etc. I =
kinda
>>>>>> consider that orthogonal to what's described here, but I added a
>>>>>> placeholder reference indicating that this (TBD) functionality exist=
s.
>>>>>
>>>>> Thanks for the writeup.. I did some edits to your sections to make so=
me parts
>>>>> more clear and to leave out other parts (e.g. libbpf-related bits whi=
ch are not
>>>>> relevant in here and it's one of many libs). I also edited some parts=
 to leave
>>>>> us more flexibility. Here would be my take mixed in:
>>>>
>>>> Edits LGTM, with just one nit, below:
>>>>
>>>>> 3. API (in)stability of kfuncs
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>>
>>>>> By default, kfuncs exported to BPF programs are considered a kernel-i=
nternal
>>>>> interface that can change between kernel versions. In the extreme cas=
e that
>>>>> could also include removal of a kfunc. This means that BPF programs u=
sing
>>>>> kfuncs might need to adapt to changes between kernel versions. In oth=
er words,
>>>>> kfuncs are _not_ part of the kernel UAPI! Rather, these kfuncs can be=
 thought
>>>>> of as being similar to internal kernel API functions exported using t=
he
>>>>> ``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functiona=
lity must
>>>>> initially start out as kfuncs.
>>>>>
>>>>> 3.1 Promotion to "stable"
>>>>> -------------------------
>>>>>
>>>>> While kfuncs are by default considered unstable as described above, s=
ome kfuncs
>>>>> may warrant a stronger stability guarantee and could be marked as *st=
able*. The
>>>>> decision to move a kfunc to *stable* is taken on a case-by-case basis=
 and has
>>>>> a high barrier, taking into account its usefulness under longer-term =
production
>>>>> deployment without any unforeseen API issues or limitations. In gener=
al, it is
>>>
>>> Forgot, we should probably also add after "[...] or limitations.":
>>>
>>>     Such promotion request along with aforementioned argumentation on w=
hy a kfunc
>>>     is ready to be stabilized must be driven from developer-side.
>>=20
>> What does "driven from developer-side" mean, exactly? And what kind of
>> developers (BPF app developers, or kernel devs)?
>
> Mainly to denote that this needs to be an explicit request from the commu=
nity
> rather than something that would happen automagically after some time (e.=
g.
> where maintainers would just put the KF_STABLE stamp to it). 'kfunc xyz h=
as
> been used in our fleet in production in the context of project abc for two
> years now and its API is sufficient to cover all foreseeable needs. The
> kfunc didn't need to get extended since it was added [...]', for example.
> The developer-hat can be both as long as there is a concrete relation to
> usage of the kfunc that can be provided to then make the case.

Right, makes sense! So how about:

"The process for requesting a kfunc be marked as stable consists of
submitting a patch to the bpf@vger.kernel.org mailing list adding the
KF_STABLE tag to that kfunc's definition. The patch description must
include the rationale for why the kfunc should be promoted to stable,
including references to existing production uses, etc."

-Toke

