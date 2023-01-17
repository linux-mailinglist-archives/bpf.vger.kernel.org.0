Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB334670B9E
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 23:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjAQW2D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 17:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAQW0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 17:26:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111D5DC27
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673993041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVLFfBmp+CUn8SGWx1LHm/3sesm1t56Z7TGbwcew3W0=;
        b=ep1eqCp7I06KBBSlZgAT52c0vhtBoJ+P8cmY4gx8yUc3rzKt7g19nHdqWwNPpQ2MhXCtiK
        9kC484zTe3a0RRoqck3nWFkuFsgKl05HwaK53w+N48TJ0s5mcWmhgMGHAeNU0dXprcQXxM
        FqKWr22x9GeV3oVHT/U2j7aeTfF1p38=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-u2G4xn6KP0CI3hHArh0DQw-1; Tue, 17 Jan 2023 17:04:00 -0500
X-MC-Unique: u2G4xn6KP0CI3hHArh0DQw-1
Received: by mail-ej1-f70.google.com with SMTP id qw29-20020a1709066a1d00b008725a1034caso2587102ejc.22
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVLFfBmp+CUn8SGWx1LHm/3sesm1t56Z7TGbwcew3W0=;
        b=ij0SFohvi7z101l7pzBcWYhrhoQiWs7DSWBzVc4jpwJBUv2icFooKqqOQMXksarj1e
         kX+QdwBD3olzcosCupxQQwYEjPR4MTVhGE+N3/EMRA5Rx0QrYwjeWJR9p272Mss2jqyf
         QS0OYbmuNfn+mGXKfaKfsHIs807GOs5nylPL5u2agyhvGTcpJZtRKCyNKULmzbnJZl8O
         /x0yPlXP+QVT/aKfmNFK+jcTzHJv80+1Y9xo+5Lnf4V1i+fGDU4E5lvxrm4vov1ya75y
         9y0nNd4QYDUR+2yciAORNUhAiuhvsHyfsKKc3+kjOHSpiysfYqgyShN2L2gMp8IrBedG
         ADrg==
X-Gm-Message-State: AFqh2kqR1CRvXfNp/5C4jMeyAr+A7a/f09j5lGr6TqiMr9SCEdURPQ8b
        tMODA/afnOO33481NXK8l/Qrw9ko+opqJXBXKZv5Mnn78IRJKOfF0WS3FOpZxid62bw1Zd2xhdH
        PDGZZ0BTUF8r1
X-Received: by 2002:a05:6402:1a4f:b0:499:c083:fd2e with SMTP id bf15-20020a0564021a4f00b00499c083fd2emr4383630edb.36.1673993038665;
        Tue, 17 Jan 2023 14:03:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvo1n+XRfWk8NwUE/NMXO1OK3OzWbf6cj/qVSpZ8SnqUE+yj6jCkA78S53QJC+OleKYSqaRvg==
X-Received: by 2002:a05:6402:1a4f:b0:499:c083:fd2e with SMTP id bf15-20020a0564021a4f00b00499c083fd2emr4383573edb.36.1673993037671;
        Tue, 17 Jan 2023 14:03:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402500300b00488abbbadb3sm13311259eda.63.2023.01.17.14.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:03:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8357C9011A4; Tue, 17 Jan 2023 23:03:56 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable
 kfuncs"
In-Reply-To: <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
References: <20230117212731.442859-1-toke@redhat.com>
 <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Jan 2023 23:03:56 +0100
Message-ID: <87v8l4byyb.fsf@toke.dk>
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

Stanislav Fomichev <sdf@google.com> writes:

> On Tue, Jan 17, 2023 at 1:27 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Following up on the discussion at the BPF office hours, this patch adds a
>> description of the (new) concept of "stable kfuncs", which are kfuncs th=
at
>> offer a "more stable" interface than what we have now, but is still not
>> part of UAPI.
>>
>> This is mostly meant as a straw man proposal to focus discussions around
>> stability guarantees. From the discussion, it seemed clear that there we=
re
>> at least some people (myself included) who felt that there needs to be s=
ome
>> way to export functionality that we consider "stable" (in the sense of
>> "applications can rely on its continuing existence").
>>
>> One option is to keep BPF helpers as the stable interface and implement
>> some technical solution for moving functionality from kfuncs to helpers
>> once it has stood the test of time and we're comfortable committing to it
>> as a stable API. Another is to freeze the helper definitions, and instead
>> use kfuncs for this purpose as well, by marking a subset of them as
>> "stable" in some way. Or we can do both and have multiple levels of
>> "stable", I suppose.
>>
>> This patch is an attempt to describe what the "stable kfuncs" idea might
>> look like, as well as to formulate some criteria for what we mean by
>> "stable", and describe an explicit deprecation procedure. Feel free to
>> critique any part of this (including rejecting the notion entirely).
>>
>> Some people mentioned (in the office hours) that should we decide to go =
in
>> this direction, there's some work that needs to be done in libbpf (and
>> probably the kernel too?) to bring the kfunc developer experience up to =
par
>> with helpers. Things like exporting kfunc definitions to vmlinux.h (to m=
ake
>> them discoverable), and having CO-RE support for using them, etc. I kinda
>> consider that orthogonal to what's described here, but I do think we sho=
uld
>> fix those issues before implementing the procedures described here.
>>
>> v2:
>> - Incorporate Daniel's changes
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++++---
>>  1 file changed, 81 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>> index 9fd7fb539f85..dd40a4ee35f2 100644
>> --- a/Documentation/bpf/kfuncs.rst
>> +++ b/Documentation/bpf/kfuncs.rst
>> @@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
>>
>>  BPF Kernel Functions or more commonly known as kfuncs are functions in =
the Linux
>>  kernel which are exposed for use by BPF programs. Unlike normal BPF hel=
pers,
>> -kfuncs do not have a stable interface and can change from one kernel re=
lease to
>> -another. Hence, BPF programs need to be updated in response to changes =
in the
>> -kernel.
>> +kfuncs by default do not have a stable interface and can change from on=
e kernel
>> +release to another. Hence, BPF programs may need to be updated in respo=
nse to
>> +changes in the kernel. See :ref:`BPF_kfunc_stability`.
>>
>>  2. Defining a kfunc
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> @@ -223,14 +223,89 @@ type. An example is shown below::
>>          }
>>          late_initcall(init_subsystem);
>>
>> -3. Core kfuncs
>> +
>> +.. _BPF_kfunc_stability:
>> +
>> +3. API (in)stability of kfuncs
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> +
>> +By default, kfuncs exported to BPF programs are considered a kernel-int=
ernal
>> +interface that can change between kernel versions. This means that BPF =
programs
>> +using kfuncs may need to adapt to changes between kernel versions. In t=
he
>> +extreme case that could also include removal of a kfunc. In other words=
, kfuncs
>> +are _not_ part of the kernel UAPI! Rather, these kfuncs can be thought =
of as
>> +being similar to internal kernel API functions exported using the
>
> [..]
>
>> +``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionali=
ty must
>> +initially start out as kfuncs.
>
> To clarify, as part of this proposal, are we making a decision here
> that we ban new helpers going forward?

Good question! That is one of the things I'm hoping we can clear up by
this discussing. I don't have a strong opinion on the matter myself, as
long as there is *some* way to mark a subset of helpers/kfuncs as
"stable"...

> (also left some spelling nits below)
>
>> +
>> +3.1 Promotion to "stable" kfuncs
>> +--------------------------------
>> +
>> +While kfuncs are by default considered unstable as described above, som=
e kfuncs
>> +may warrant a stronger stability guarantee and can be marked as *stable=
*. The
>> +decision to move a kfunc to *stable* is taken on a case-by-case basis a=
nd must
>> +clear a high bar, taking into account the functions' usefulness under
>> +longer-term production deployment without any unforeseen API issues or
>> +limitations. In general, it is not expected that every kfunc will turn =
into a
>> +stable one - think of it as an exception rather than the norm.
>> +
>> +Those kfuncs which have been promoted to stable are then marked using t=
he
>> +``KF_STABLE`` tag. The process for requesting a kfunc be marked as stab=
le
>> +consists of submitting a patch to the bpf@vger.kernel.org mailing list =
adding
>> +the ``KF_STABLE`` tag to that kfunc's definition. The patch description=
 must
>> +include the rationale for why the kfunc should be promoted to stable, i=
ncluding
>> +references to existing production uses, etc. The patch will be consider=
ed the
>> +same was as any other patch, and ultimately the decision on whether a k=
func
>
> nit: most likely s/same was/same way/ here?

Yup!

>> +should be promoted to stable is taken by the BPF maintainers.
>> +
>> +Stable kfuncs provide the following stability guarantees:
>> +
>> +1. Stable kfuncs will not change their function signature or functional=
ity in a
>> +   way that may cause incompatibilities for BPF programs calling the fu=
nction.
>> +
>> +2. The BPF community will make every reasonable effort to keep stable k=
funcs
>> +   around as long as they continue to be useful to real-world BPF appli=
cations.
>> +
>> +3. Should a stable kfunc turn out to be no longer useful, the BPF commu=
nity may
>> +   decide to eventually remove it. In this case, before being removed t=
hat kfunc
>> +   will go through a deprecation procedure as outlined below.
>> +
>> +3.2 Deprecation of kfuncs
>> +-------------------------
>> +
>> +As described above, the community will make every reasonable effort to =
keep
>> +kfuncs available through future kernel versions once they are marked as=
 stable.
>> +However, it may happen case that BPF development moves in an unforeseen
>
> 'may happen case' -> 'may happen in case' ?

Think I actually meant to drop 'case' entirely; thanks for spotting!

-Toke

