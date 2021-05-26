Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618D1391D3C
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 18:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhEZQni (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhEZQni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 12:43:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BCBC061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 09:42:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q7so3522312lfr.6
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEazQbJ9+L40/iRYOC5yf4niG3LvnPWU7irlkxhC4kA=;
        b=usUm78HB8YEZuckNZYXNEyvjiB0Cr5deOcu+25uZx6PBpkua45UUKcWjeL10LCJ4a6
         3BnvNbjqEwDcK9Vi+1Apa9aK8qUUCyiqMRhFhGLuC1sCx3vZtv/ihKVhidSVzjdG7Jt8
         3mwKo3zwaCrfVuc+/jEBSjsIC3VK0XMLQh4sg7f1NMTSLi+mkdaS5Tv8qSfdJ19F9l8l
         5QTmyJFxA90t6J41kqtWdmu4mKBaT2ds6rBOtCkc0E/e3wwpKLUJsrdE2jfKH0o7Pj5x
         VXYLNHY6zGPy0tdZQCEQyoPAxDBEBSQg7znti84v6r6YxCR46w06azQSCuW1j3bzm2Vl
         32Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEazQbJ9+L40/iRYOC5yf4niG3LvnPWU7irlkxhC4kA=;
        b=FZalDTmb2qIPI8y80A0v8h4AUeWnoVrJX3f6IM7bVCjfmm1pknMGIWN6MgXHl526tN
         TVXGZrY/+M6NAsIln15b8XZKVNz6uBpS2gLIGT41Fw/RsX+/kfoIheTCkCMMHyrfMda8
         d7Vy4nQbxMlA/wkY3ZKpcsHWsk5wM42gFbC6ZWxEjz3VnnsY5Xu1/XwX25VUmVh1S5pm
         L07Gw5S4L9RabORyH2WDDDf0AdfeD9j0EIJAfawMlQ4z4WqII6czwnQrAA37pKPcCOO5
         Jq/cUoaszigNuUXpT/S8wzNQ/CmbzhLqcats4om+MswxMKsK6OSoncAkm2WqCm/GW+oh
         yOpg==
X-Gm-Message-State: AOAM533vKYHn/QhgclTC1rtyD+duQ90VmC8nW57QHnXynftMY5G5Sdk5
        X4QP5LtJs82kTgygKu4IOaw6Hg16TtmmW4spIY6RIztlofo=
X-Google-Smtp-Source: ABdhPJykyUrMdj5/61HjHxsUtsBdDX4hmfi0o0Hm/Ladyld7O/QWlZTutIyHM9a2klkhi2Qxm9ACNUjRbFdN3wX/N4Y=
X-Received: by 2002:ac2:4838:: with SMTP id 24mr2818315lft.214.1622047323526;
 Wed, 26 May 2021 09:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
 <20210507131034.5a62ce56@carbon> <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210510185029.1ca6f872@carbon> <DM4PR11MB54227C25DFD4E882CB03BD3884539@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210512102546.5c098483@carbon> <DM4PR11MB542273C9D8BF63505DC6E21784519@DM4PR11MB5422.namprd11.prod.outlook.com>
 <7b347a985e590e2a422f837971b30bd83f9c7ac3.camel@nvidia.com>
 <DM4PR11MB5422762E82C0531B92BDF09A842B9@DM4PR11MB5422.namprd11.prod.outlook.com>
 <DM4PR11MB5422269F6113268172B9E26A842A9@DM4PR11MB5422.namprd11.prod.outlook.com>
 <DM4PR11MB54224769926B06EE76635A6484299@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210521153110.207cb231@carbon> <1426bc91c6c6ee3aaf3d85c4291a12968634e521.camel@kernel.org>
 <87lf85zmuw.fsf@toke.dk> <20210525142027.1432-1-alexandr.lobakin@intel.com>
 <60add3cad4ef0_3b75f2086@john-XPS-13-9370.notmuch> <20210526134910.1c06c5d8@carbon>
 <87y2c1iqz4.fsf@toke.dk> <60ae6ad5a2e04_18bf20819@john-XPS-13-9370.notmuch> <20210526155402.172-1-alexandr.lobakin@intel.com>
In-Reply-To: <20210526155402.172-1-alexandr.lobakin@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 May 2021 09:41:52 -0700
Message-ID: <CAADnVQL3uuKY4kY3v60Wzjh1QPT+k4+jVnN+Y3a_SBF3DFbwWg@mail.gmail.com>
Subject: Re: AF_XDP metadata/hints
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 8:57 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> >
> >Well likely libbpf would do the rewrite I think.
>
> So your proposal is to not compose metadata according to the prog's
> request, but rather reprogram the prog itself to access metadata
> accordingly? Sounds very nice.
>
> If follow this path, is it something like this?
>
> 1. Driver exposes the fields layout (e.g. Rx/Tx descriptor fields)
> via BTF to the BPF layer.
> 2. When an XDP prog is attached, BPF reprograms it to look for the
> required fields at the right offset.

The driver doesn't need to expose it directly via ndo.
There is already generic support for BTF in modules
and support for encoding btf_id for further use inside verifier
and other components.
I think the driver can simply do:
BTF_ID_LIST(known_packet_fields)
and the bpf core will pick it from there.
While libbpf will do a CO-RE style re-write when driver layout changes.
Ideally bpf core doesn't need to be involved and it's done completely in libbpf.
