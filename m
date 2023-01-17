Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA6666E2A1
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjAQPqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 10:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjAQPpV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 10:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A54B181
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673970136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwrmeCk3Vdh5Ni4V2DeawssQ/R4WD/TS7RftRQHb0hI=;
        b=jK4/sBkfW3vjkCaQxo1ts1Bvv7sYjZGE6rlJl9tJCsqXUN0ljA4WrO5k1cV+Rj8hrGQtEt
        fdnMtW7fb6tYjcQwarKd7ojdRsrnAQG/x/0JY3WBleAYm+F7yZJYvNsxsex9/+YHKNCOvu
        LTxSRFdgE5l9WdxxIL045hb0NBrkCJY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-UKb0We2WNeeXslPhPMfjAQ-1; Tue, 17 Jan 2023 10:42:12 -0500
X-MC-Unique: UKb0We2WNeeXslPhPMfjAQ-1
Received: by mail-ej1-f72.google.com with SMTP id hs18-20020a1709073e9200b007c0f9ac75f9so21738088ejc.9
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 07:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwrmeCk3Vdh5Ni4V2DeawssQ/R4WD/TS7RftRQHb0hI=;
        b=FHSATNWaG/ZUyVK07EWumlaOfMBMSx5Di9mP4SCTbsdQYz19/qTNVqjDgbtkLLlwkU
         u69crbhCZrMWavt+NotWtELbVm0TawZS6bXVh3sWQWRFdoFt4Y3jbAi3cKChQE2AZGM8
         vokD+Bb62ZpCEV4jA+cGh0g/tgUDPI+4CSZiKmTeCSOSe01+CbH1oi5ZGOYGcCCnLUP+
         MnZ3cLBERJz3gfY/fjKnNcJzafRqPBGE+qomJSLMl+2vLa7p3+oXmWsINL5e118hG3G5
         Y5YL7RWHSABUV7BezhLKo1as//xvpRVXylEOv0/e4GLNSCoaFCm1UIMioN9cx5lk6L0m
         nXIA==
X-Gm-Message-State: AFqh2krAJARbe7cFaKTdcVq7DmDsiH10zRiCkfnbGv6k+hv1Mc0iTFcP
        XQCbJ3AA6wGOf4hrMJFYoOl6e5HfAnTo0o9tkeouTM4ddX/TRl9pdzilICYEzKNSdKmUNc3QczM
        LHNbi8NkNBIXJ
X-Received: by 2002:a17:907:d38a:b0:86e:c9e2:6313 with SMTP id vh10-20020a170907d38a00b0086ec9e26313mr3485219ejc.32.1673970118899;
        Tue, 17 Jan 2023 07:41:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtZ8j8Q7Y3SggC04i+UfU3PH+M+2OWdMokXvtBaIUSRdw4xLDlHb6BwrlLx8vDmPvDQ51yp7w==
X-Received: by 2002:a17:907:d38a:b0:86e:c9e2:6313 with SMTP id vh10-20020a170907d38a00b0086ec9e26313mr3485172ejc.32.1673970117985;
        Tue, 17 Jan 2023 07:41:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id kw17-20020a170907771100b0084c4b87aa18sm13388557ejc.37.2023.01.17.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 07:41:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D297F901137; Tue, 17 Jan 2023 16:41:56 +0100 (CET)
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
In-Reply-To: <21baf37f-32a1-69cb-bf3d-afe253bd8243@iogearbox.net>
References: <20230116225724.377099-1-toke@redhat.com>
 <6deb800f-57d8-9ee5-d588-ee6354e74aa9@iogearbox.net>
 <87fsc9csa5.fsf@toke.dk>
 <bb5b4544-7011-ecca-5d10-cb7c6e72f181@iogearbox.net>
 <87cz7dcpvy.fsf@toke.dk>
 <aaa31102-7ac9-0b39-b545-a51352deaf27@iogearbox.net>
 <874jspcjk8.fsf@toke.dk>
 <21baf37f-32a1-69cb-bf3d-afe253bd8243@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Jan 2023 16:41:56 +0100
Message-ID: <871qntcgmz.fsf@toke.dk>
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

> On 1/17/23 3:38 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>> On 1/17/23 1:22 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>> On 1/17/23 12:30 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>>>> On 1/16/23 11:57 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>> Following up on the discussion at the BPF office hours, this patch=
 adds a
>>>>>>>> description of the (new) concept of "stable kfuncs", which are kfu=
ncs that
>>>>>>>> offer a "more stable" interface than what we have now, but is stil=
l not
>>>>>>>> part of UAPI.
>>>>>>>>
>>>>>>>> This is mostly meant as a straw man proposal to focus discussions =
around
>>>>>>>> stability guarantees. From the discussion, it seemed clear that th=
ere were
>>>>>>>> at least some people (myself included) who felt that there needs t=
o be some
>>>>>>>> way to export functionality that we consider "stable" (in the sens=
e of
>>>>>>>> "applications can rely on its continuing existence").
>>>>>>>>
>>>>>>>> One option is to keep BPF helpers as the stable interface and impl=
ement
>>>>>>>> some technical solution for moving functionality from kfuncs to he=
lpers
>>>>>>>> once it has stood the test of time and we're comfortable committin=
g to it
>>>>>>>> as a stable API. Another is to freeze the helper definitions, and =
instead
>>>>>>>> use kfuncs for this purpose as well, by marking a subset of them as
>>>>>>>> "stable" in some way. Or we can do both and have multiple levels o=
f "stable",
>>>>>>>> I suppose.
>>>>>>>>
>>>>>>>> This patch is an attempt to describe what the "stable kfuncs" idea=
 might look
>>>>>>>> like, as well as to formulate some criteria for what we mean by "s=
table", and
>>>>>>>> describe an explicit deprecation procedure. Feel free to critique =
any part
>>>>>>>> of this (including rejecting the notion entirely).
>>>>>>>>
>>>>>>>> Some people mentioned (in the office hours) that should we decide =
to go in
>>>>>>>> this direction, there's some work that needs to be done in libbpf =
(and
>>>>>>>> probably the kernel too?) to bring the kfunc developer experience =
up to par
>>>>>>>> with helpers. Things like exporting kfunc definitions to vmlinux.h=
 (to make
>>>>>>>> them discoverable), and having CO-RE support for using them, etc. =
I kinda
>>>>>>>> consider that orthogonal to what's described here, but I added a
>>>>>>>> placeholder reference indicating that this (TBD) functionality exi=
sts.
>>>>>>>
>>>>>>> Thanks for the writeup.. I did some edits to your sections to make =
some parts
>>>>>>> more clear and to leave out other parts (e.g. libbpf-related bits w=
hich are not
>>>>>>> relevant in here and it's one of many libs). I also edited some par=
ts to leave
>>>>>>> us more flexibility. Here would be my take mixed in:
>>>>>>
>>>>>> Edits LGTM, with just one nit, below:
>>>>>>
>>>>>>> 3. API (in)stability of kfuncs
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>
>>>>>>> By default, kfuncs exported to BPF programs are considered a kernel=
-internal
>>>>>>> interface that can change between kernel versions. In the extreme c=
ase that
>>>>>>> could also include removal of a kfunc. This means that BPF programs=
 using
>>>>>>> kfuncs might need to adapt to changes between kernel versions. In o=
ther words,
>>>>>>> kfuncs are _not_ part of the kernel UAPI! Rather, these kfuncs can =
be thought
>>>>>>> of as being similar to internal kernel API functions exported using=
 the
>>>>>>> ``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functio=
nality must
>>>>>>> initially start out as kfuncs.
>>>>>>>
>>>>>>> 3.1 Promotion to "stable"
>>>>>>> -------------------------
>>>>>>>
>>>>>>> While kfuncs are by default considered unstable as described above,=
 some kfuncs
>>>>>>> may warrant a stronger stability guarantee and could be marked as *=
stable*. The
>>>>>>> decision to move a kfunc to *stable* is taken on a case-by-case bas=
is and has
>>>>>>> a high barrier, taking into account its usefulness under longer-ter=
m production
>>>>>>> deployment without any unforeseen API issues or limitations. In gen=
eral, it is
>>>>>
>>>>> Forgot, we should probably also add after "[...] or limitations.":
>>>>>
>>>>>      Such promotion request along with aforementioned argumentation o=
n why a kfunc
>>>>>      is ready to be stabilized must be driven from developer-side.
>>>>
>>>> What does "driven from developer-side" mean, exactly? And what kind of
>>>> developers (BPF app developers, or kernel devs)?
>>>
>>> Mainly to denote that this needs to be an explicit request from the com=
munity
>>> rather than something that would happen automagically after some time (=
e.g.
>>> where maintainers would just put the KF_STABLE stamp to it). 'kfunc xyz=
 has
>>> been used in our fleet in production in the context of project abc for =
two
>>> years now and its API is sufficient to cover all foreseeable needs. The
>>> kfunc didn't need to get extended since it was added [...]', for exampl=
e.
>>> The developer-hat can be both as long as there is a concrete relation to
>>> usage of the kfunc that can be provided to then make the case.
>>=20
>> Right, makes sense! So how about:
>>=20
>> "The process for requesting a kfunc be marked as stable consists of
>> submitting a patch to the bpf@vger.kernel.org mailing list adding the
>> KF_STABLE tag to that kfunc's definition. The patch description must
>> include the rationale for why the kfunc should be promoted to stable,
>> including references to existing production uses, etc."
>
> Sounds good to me!

Cool. I'll incorporate your changes (+ what we discussed) and send a v2
to make it easier for others to chime in...

-Toke

