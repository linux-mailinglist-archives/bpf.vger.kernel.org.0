Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B2A4455D4
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 15:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhKDPA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhKDPA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 11:00:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F47C06127A
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 07:58:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g3so9975568ljm.8
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQDoDFu5us63IeM6Clu6q+8EwmonGZYLNVEp75Zdgto=;
        b=YgpOQQi+xsQyulncwSweWqpKG6G6IDW0U55Do2YHTcTF1ZHZOegdmdlbGBcg0Y9eY9
         cZuDpHq30JmDwgcNCwlmxiE6/b1Y4EakMucYEh7YI7qf4m5XwEFaxjmzZ0wsnU6pV/bZ
         kutwDGLV+yMOx7+hcangOirWSHCEAcrzciog0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQDoDFu5us63IeM6Clu6q+8EwmonGZYLNVEp75Zdgto=;
        b=dMomXgdr4RPKYY8v9eoGFuE1sB5sZDrzu8kHwB5gfC4mjIhNGx2S0etMzFIGvnwMxQ
         FmLn4gWVe6y5VJKvIPmCb/JRatE81nHEBxDvHbx1wVVxWz34nFsDqaFwhlbD7TBS9w1d
         eHb8U0g977WLvX804nXcuG7nbnCbz9/oxvlrbeh8+bfK3ToloTuXyyZy7fkiIErIaIt4
         Fby4t9gJDiH3foGmjpWA1bzrFxHf1PiaFI0Qaoto0QiXQ15a4h3gKPD7MVedNmgdbD3t
         TpBoA6JMw0zuFVDsYAMEuR+yYkxLJ7qk5Tox+RraxZ3sfrRsim5pjCpEmCdEwZk0Hb0Z
         91+w==
X-Gm-Message-State: AOAM531/Re6o5XMESPee27tV2d0svlsYOt+Q5/fRUbUD9aJhHrFbybMl
        4UhG18dU2wVrp4W80RQHx/RDrItDiSaZeA/luTUGOMQtpPn/gA==
X-Google-Smtp-Source: ABdhPJxyeo/p6jgX5UyslFFu2ECdKXr4W7bIVl2z1QL19a36wkHOG0o7FXwFDEt3CJzic2uDZYbxZQ5E88X/uHpi4aQ=
X-Received: by 2002:a2e:9f0f:: with SMTP id u15mr5498817ljk.60.1636037899134;
 Thu, 04 Nov 2021 07:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211027203727.208847-1-mauricio@kinvolk.io> <CAADnVQK2Bm7dDgGc6uHVosuSzi_LT0afXM6Hf3yLXByfftxV1Q@mail.gmail.com>
 <CAHap4zt7B1Zb56rr55Q8_cy8qdyaZsYcWt7ZHrs3EKr50fsA+A@mail.gmail.com>
 <CAEf4BzbDBGEnztzEcXmCFMNyzTjJ3pY41ahzieu9yJ+EDHU0dg@mail.gmail.com>
 <CAHap4zutG7KXywstCHcTbATN8iVCKuN84ZHxLfdsXDJS9sDmEA@mail.gmail.com> <CAEf4BzbALXu7ucrVcNdT38od5fU2Cd9qMncbXGJGe-KG1NOdNw@mail.gmail.com>
In-Reply-To: <CAEf4BzbALXu7ucrVcNdT38od5fU2Cd9qMncbXGJGe-KG1NOdNw@mail.gmail.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Thu, 4 Nov 2021 09:58:07 -0500
Message-ID: <CAHap4zvYaj9pnmgMLa9-B+3sbypj=OA0smrsJewyP+T-rsDtWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] libbpf: Implement BTF Generator API
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > ```
> > /* reduced version of struct bpf_core_spec */
> > struct bpf_core_spec_pub {
> > const struct btf *btf;
> > __u32 root_type_id;
> > enum bpf_core_relo_kind kind;
> > /* raw, low-level spec: 1-to-1 with accessor spec string */ --> we can
> > also use access_str_off and let the user parse it
> > int raw_spec[BPF_CORE_SPEC_MAX_LEN];
>
> string might be a more "extensible" way, but we'll need to construct
> that string for each relocation
>
> > /* raw spec length */
> > int raw_len;
>
> using string would eliminate the need for this
>
> > };
> >
> > struct bpf_core_relo_pub {
> > const char *prog_name; --> if we expose it by program then it's not needed.
>
> yep, not sure about per-program yet, but that's minor
>
> > int insn_idx;
> >
> > bool poison; --> allows the user to understand if the relocation
> > succeeded or not.
> >
> > /* new field offset for field based core relos */
> > __u32 new_offset;
> >
> > // TODO: fields for type and enum-based relos
>
> isn't it always just u64 new_value for all types of relos? We can also
> expose old_value just for completeness
>

Oh right. We can expose new_val, orig_val and let the user interpret
their meaning based on the relo_kind.

> >
> > struct bpf_core_spec_pub local_spec, targ_spec; --> BTFGen only needs
> > targ_spec, I suppose local spec would be useful for other use cases.
>
> targ_spec doesn't seem necessary given we have root_type_id, relo
> kind, access_string (or raw_spec). What am I missing?
>

Not sure I follow. root_type, relo kind and access_string are all part
of bpf_core_spec_pub, there are two instances of this structure,
targ_spec and local_spec.
