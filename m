Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AC391D78
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhEZRDU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhEZRDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 13:03:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48056C061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 10:01:47 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n10so1749195ion.8
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Maoq7XgQoiyBeHhvD5icRZhRC8xqjjLJhSdtIBR3BUw=;
        b=bzYQw4np3hfYzDqq3RkaTispoTO6nWAf9JvxfXmvLgad5s9VTre0mNGJQ7+ER7+7pT
         XPNsieR2KEIihbJNnX547+eW6gcdYjRpcYNtP5QWYhUZyCzdsMjrGcfKnJI1jYpbBUzk
         oQRhVNOpBVoT7XQPAsm+qp2jz6wVWCtU4xjyc9HIUKvHOITnhFLvZTF3AUcM1BJ5iQ7O
         HU4cbGZGt6pAIdN42kpizP2q0YK+lWio8hD/cMkH4zLwqF77Y3+z0RlMj2hyL1JhCxu6
         BJcDAvmnKMZ1wJYMmyNateJpTGRBGQON4YyX+Dbvk0hHuc7VRVPmmZnYzjgTR/9ksVJy
         dcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Maoq7XgQoiyBeHhvD5icRZhRC8xqjjLJhSdtIBR3BUw=;
        b=kCSesV8aucg8jq4YAwFM/jGhbPt4hyyr8rdZqgDHsXbKO+3oM+9VueGdYmzmB86NiN
         TXbsL5pAMkNBSoXye54OygbjU/zlyjVpjL2ljm5Noiijf9rJ/071Z1P1SOa0Qx+qrFVN
         s+Ex4QRlGlodCFkHppAA2T7/e8uPD5G4wFdSyg78wP4dVhM2W2/SZLlfahDwlGeO8ich
         3x2SP9M7L5QVzZcA0c4rCLcSRHkbkXrP6Q1SW12UFlsqQrQgjxs69JGR4NTysj960m9i
         18AIz5jKZHcpyfN5timVVcWptTgGY0HWjFa8fERr9E+bwvedCsfNJ/XBl4mHZY8h0ifB
         TiSw==
X-Gm-Message-State: AOAM530e7yWBrpEogk3eJLPQkRv/iG4DSzDBaqVIbR7o8TJwtu3czHtR
        WHlrwLcapG2DxzwYwxeDr1I=
X-Google-Smtp-Source: ABdhPJznfkv0A7cfKntpnJ2DMw3ZSTH4t7CYt2pKwt+zgIt+GAQGQ1QzhKdmN7WbbuxybZ3MqlFZPQ==
X-Received: by 2002:a5e:c913:: with SMTP id z19mr24842199iol.70.1622048506651;
        Wed, 26 May 2021 10:01:46 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id f11sm15235980iov.9.2021.05.26.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:01:46 -0700 (PDT)
Date:   Wed, 26 May 2021 10:01:37 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Kubiak, Marcin" <marcin.kubiak@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        bpf <bpf@vger.kernel.org>, xdp-hints@xdp-project.net
Message-ID: <60ae7ef1bfec1_83762083e@john-XPS-13-9370.notmuch>
In-Reply-To: <CAADnVQL3uuKY4kY3v60Wzjh1QPT+k4+jVnN+Y3a_SBF3DFbwWg@mail.gmail.com>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
 <20210507131034.5a62ce56@carbon>
 <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210510185029.1ca6f872@carbon>
 <DM4PR11MB54227C25DFD4E882CB03BD3884539@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210512102546.5c098483@carbon>
 <DM4PR11MB542273C9D8BF63505DC6E21784519@DM4PR11MB5422.namprd11.prod.outlook.com>
 <7b347a985e590e2a422f837971b30bd83f9c7ac3.camel@nvidia.com>
 <DM4PR11MB5422762E82C0531B92BDF09A842B9@DM4PR11MB5422.namprd11.prod.outlook.com>
 <DM4PR11MB5422269F6113268172B9E26A842A9@DM4PR11MB5422.namprd11.prod.outlook.com>
 <DM4PR11MB54224769926B06EE76635A6484299@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210521153110.207cb231@carbon>
 <1426bc91c6c6ee3aaf3d85c4291a12968634e521.camel@kernel.org>
 <87lf85zmuw.fsf@toke.dk>
 <20210525142027.1432-1-alexandr.lobakin@intel.com>
 <60add3cad4ef0_3b75f2086@john-XPS-13-9370.notmuch>
 <20210526134910.1c06c5d8@carbon>
 <87y2c1iqz4.fsf@toke.dk>
 <60ae6ad5a2e04_18bf20819@john-XPS-13-9370.notmuch>
 <20210526155402.172-1-alexandr.lobakin@intel.com>
 <CAADnVQL3uuKY4kY3v60Wzjh1QPT+k4+jVnN+Y3a_SBF3DFbwWg@mail.gmail.com>
Subject: Re: AF_XDP metadata/hints
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Wed, May 26, 2021 at 8:57 AM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> > >
> > >Well likely libbpf would do the rewrite I think.
> >
> > So your proposal is to not compose metadata according to the prog's
> > request, but rather reprogram the prog itself to access metadata
> > accordingly? Sounds very nice.
> >
> > If follow this path, is it something like this?
> >
> > 1. Driver exposes the fields layout (e.g. Rx/Tx descriptor fields)
> > via BTF to the BPF layer.
> > 2. When an XDP prog is attached, BPF reprograms it to look for the
> > required fields at the right offset.
> 
> The driver doesn't need to expose it directly via ndo.

+1

> There is already generic support for BTF in modules
> and support for encoding btf_id for further use inside verifier
> and other components.
> I think the driver can simply do:
> BTF_ID_LIST(known_packet_fields)
> and the bpf core will pick it from there.
> While libbpf will do a CO-RE style re-write when driver layout changes.
> Ideally bpf core doesn't need to be involved and it's done completely in libbpf.

Agree, I don't see any reason bpf core is needed for any of the above.

The only downside of BTF_ID_LIST is its not dynamic, a ucode update
might move the parser and fields around. But that can be handled
in userspace, by publishing a supplemental BTF file, to start with.
Once we have known value and understand the use case we can discuss
the dynamic case exposed from kernel side. Even the static case
with BTF_ID_LIST would be a first step.
