Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0567A852
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 02:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjAYBTC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 20:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjAYBTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 20:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6142DE60
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 17:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674609494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bqL1nYLObU3WXUoBw8pTdVHyQKIHnraP8ftys9baeow=;
        b=RBo1Y3T8+t9yzmo8cqIkoyR75xYT2CxWSAaII/U8KbJep2Fh66O1NdWEGokP4/mx7K9Szz
        VQUd060zKYkjCT4FSvrZHCcVNCYSPIYGKdFA+xSea/wUds0ODPOv4DW9r1tU6cke7+ovol
        M3FBjt2h68lTaRzWczgHv6/Zm5CDLaQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-L3n9vZjtNcqBpgec4RPuCw-1; Tue, 24 Jan 2023 20:18:13 -0500
X-MC-Unique: L3n9vZjtNcqBpgec4RPuCw-1
Received: by mail-ej1-f70.google.com with SMTP id nc27-20020a1709071c1b00b0086dae705676so10978418ejc.12
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 17:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqL1nYLObU3WXUoBw8pTdVHyQKIHnraP8ftys9baeow=;
        b=6uHnnSzuPt3oXHz73WiYtpWgLrq0ahIrC+WzD4Z9QNU9sLq8nogr8e3LRIzMtDbD9E
         ggXBWX3dEW33qUnXpYGZoYfLWoY+wt/lmMAGrp1DxKOUtxFfzMdMyzvZ4o4KXEbSYy+q
         GUGUDogrhCywrHp4Z1ciA70/IvUR3TkcDkszEaWxg0AyAbfezfqELouN86G+902+eFNQ
         LgiHywJ01SDa0uFDlWStXemBmQYKduSLLqwkiFoy4eyRGNEVI54N7XYST2Liab5xEDsa
         vCpT3BejS/G3lQ3v064XqYaq+VYYXY+sIiQ2ex+xVnVNyw4Y5OTBAGOmlJF6a1nyzo1w
         F+6g==
X-Gm-Message-State: AFqh2kpZwG8Bzd5Fk4REUNqBRHl2qM2iZmySqmCaGXXMmMoBIL6gSz1N
        wOUsbzGgkRDlLtH66fWTL7AULG7SfUI0kCKks1DRbv4Zynfhbs63fpky9+lawnFOpzCFqH1rERV
        ZwqXsQ3bF0r79
X-Received: by 2002:a17:907:9118:b0:7c1:22a6:818f with SMTP id p24-20020a170907911800b007c122a6818fmr24262689ejq.25.1674609490923;
        Tue, 24 Jan 2023 17:18:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXusgP5TgpnRD1MDPdgOMnn2TZ6GSMcBsz/AV3lLNGSTTg7n9H2QryOpq8JgEXOnKsoetkgSKg==
X-Received: by 2002:a17:907:9118:b0:7c1:22a6:818f with SMTP id p24-20020a170907911800b007c122a6818fmr24262672ejq.25.1674609490635;
        Tue, 24 Jan 2023 17:18:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090655cc00b00877e1bb54b0sm1636550ejp.53.2023.01.24.17.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 17:18:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 76F1D942C33; Wed, 25 Jan 2023 02:18:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable
 kfuncs"
In-Reply-To: <20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local>
References: <20230117212731.442859-1-toke@redhat.com>
 <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk>
 <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
 <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
 <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net>
 <20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 25 Jan 2023 02:18:09 +0100
Message-ID: <875ycvo1im.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> The bpf developers adding new kfunc should assume that it's stable and proceed
> to use it in bpf progs and production applications.

"Assume all kfuncs are stable" is fine by me, but that is emphatically
not what we have been saying thus far, quite the opposite...

> The bpf maintainers will keep this stability promise. They obviously will not
> reap it out of the kernel on the whim, but they will nuke it if this kfunc
> will be in the way of the kernel innovation.

...and it is contradicted by this last bit. I mean "it's stable, but
we'll remove it if it's in the way" is not, well, stable.

[...]

> bpf developers and users should assume that all kfuncs are stable and use them.
> When somebody comes to argue that a particular kfunc needs to change
> the developer who added that kfunc better to be around to argue that the kfunc is
> perfect the way it is. If developer is gone the maintainers will make a call.
> It's a self regulating system.
> kfuncs will be stable if developers/users are around.
> Yet the maintainers will have a freedom to change if absolutely necessary.

This assumes users (i.e., BPF program authors) are around during the
development phase, which they are generally not. Except for the users
who are also BPF devs, but that's a minority (if not now, hopefully in
the future). So I really think we need to document some expectations
here.

For instance, what happens if we change a kfunc, and a user shows up
during the -rc phase saying it broke their application? Are we going to
revert that change?

> Back to deprecation...
> I think KF_DEPRECATED is a good idea.
> When kfunc will be auto emitted into vmlinux.h (or whatever other file)
> or shipped in libbpf header we can emit
> __attribute__((deprecated("reason", "replacement")));
> to that header file (so it's seen during bpf prog build) and
> start dmesg warn on them in the verifier.
> Kernel splats do get noticed. The users would have to act quickly.

So how about documenting that bit? Something like:

"We promise that kfuncs will not be removed without going through a
deprecation phase. The length of the deprecation will be proportional to
how long that kfunc has existed in the kernel, but will be no shorter
than XX kernel releases." ?

> As far as KF_STABLE... I think it hurts the system in the long run.
> The developer can argue at one point in time that kfunc has to be KF_STABLE.
> The patch will be applied, but the developer is off the hook and can disappear.
> The maintainers would have to argue on behalf of the developer
> and keep maintaining it? The maintainers won't have a signal whether
> kfunc is still useful after initial KF_STABLE patch.

Doing the above wrt deprecation without having an explicit stable tag
would be OK with me.

> I think it's more important to decide how we document kfuncs and
> how equivalent of bpf_helper_defs.h can be done.

I agree we (also) need to do this. As well as have some support for
querying for them from userspace on a running kernel (for CO-RE
purposes).

-Toke

