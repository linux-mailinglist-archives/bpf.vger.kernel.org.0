Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677664E397C
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 08:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiCVHTy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 03:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiCVHTu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 03:19:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB01BC17
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 00:18:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o8so12018135pgf.9
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 00:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=odzsUcbcJOWmxp1+exVYBexqmQD+00CKl1bKby1cyHI=;
        b=gQqm1LmWWduAo7hr6XQACubJlErN0WVUHlzvvZKvA/gAmtk5Kicdu2eRUZPHYQODrx
         guBHx/Ao6f39oelS7eX58kGGmkYrNQmbB9P5DFWqM/yxW9qyI1UHdDVV3lAAKOqfy4vW
         wisvIP2MiWK3bl6O99x6hJg750IXJwhe22vOrOC43++zdawaMzPAqiDoo+gE543OxYQZ
         aTv3p5b+GxwV/RQE0lfxqbL1PRXsBIkM3OMsDOrHMIHl0jlomBuHPAul09tBSDCm2NWN
         CSw2c3oq5f/oorstEUDAxhTQcbcNasYtEzde3rGuYuv+0LZy0CpmqhxiBaQaHM5cC9RL
         BVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=odzsUcbcJOWmxp1+exVYBexqmQD+00CKl1bKby1cyHI=;
        b=b3WfjRQ4sXSJD8INpJ4NXKOOa8p/9j2I8oSB9rvT8kkWogH39cFF/K2MXubNYgGKAQ
         WfYuGPXolgyDxb/47kK8bV1rzu7ZDXToYOjPAlzBC+cIlZs1jLC0mhaN1vWCXPNthxdk
         I/zBax0gGi5PmCCI0gH5BomMEGDbdDeiSfbnsdb9VGAy0L+QcNbR+0kQR+ObfGTrOpJZ
         UV37yMhZQFSDq0NHtxvH7VuHRom1f+DOFSyzu2wJMOv+OCL9JMAG2YBhl8f9sRXJo3S3
         8ecdsDxlS3pNdGibtx7DSJ1hXHU0V4RFon72A2uSfdyikCNsXGI9Zx9em9rjGL4kQlX2
         b0xw==
X-Gm-Message-State: AOAM532kZ/WHdoM37bB1+R9ojQ7XaNtBlWNYePNxu8OMBufRFdCCm5MZ
        8lhrPZ9v4P0g9tbaQEGBJVE=
X-Google-Smtp-Source: ABdhPJzyDKzzRdB8Wp0AaTCBi4OGgyn6F2VgRtiC9ZKQS5TmP9kaApeLEJmpNN3sx4T+P0fc0R1ORg==
X-Received: by 2002:a05:6a00:130c:b0:4bd:118:8071 with SMTP id j12-20020a056a00130c00b004bd01188071mr27961760pfu.28.1647933499724;
        Tue, 22 Mar 2022 00:18:19 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a00198b00b004fa7da68465sm11516849pfl.60.2022.03.22.00.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:18:19 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:48:18 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 06/13] bpf: Prevent escaping of kptr loaded
 from maps
Message-ID: <20220322071818.u7qb5ariyzkum3lm@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-7-memxor@gmail.com>
 <CAEf4BzbMKspdkz2N39+uO-pqQjBRXHGP5+Y6WfNAnUksPpos4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbMKspdkz2N39+uO-pqQjBRXHGP5+Y6WfNAnUksPpos4Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 11:28:26AM IST, Andrii Nakryiko wrote:
> On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > While we can guarantee that even for unreferenced kptr, the object
> > pointer points to being freed etc. can be handled by the verifier's
> > exception handling (normal load patching to PROBE_MEM loads), we still
> > cannot allow the user to pass these pointers to BPF helpers and kfunc,
> > because the same exception handling won't be done for accesses inside
> > the kernel. The same is true if a referenced pointer is loaded using
> > normal load instruction. Since the reference is not guaranteed to be
> > held while the pointer is used, it must be marked as untrusted.
> >
> > Hence introduce a new type flag, PTR_UNTRUSTED, which is used to mark
> > all registers loading unreferenced and referenced kptr from BPF maps,
> > and ensure they can never escape the BPF program and into the kernel by
> > way of calling stable/unstable helpers.
> >
> > In check_ptr_to_btf_access, the !type_may_be_null check to reject type
> > flags is still correct, as apart from PTR_MAYBE_NULL, only MEM_USER,
> > MEM_PERCPU, and PTR_UNTRUSTED may be set for PTR_TO_BTF_ID. The first
> > two are checked inside the function and rejected using a proper error
> > message, but we still want to allow dereference of untrusted case.
> >
> > Also, we make sure to inherit PTR_UNTRUSTED when chain of pointers are
> > walked, so that this flag is never dropped once it has been set on a
> > PTR_TO_BTF_ID (i.e. trusted to untrusted transition can only be in one
> > direction).
> >
> > In convert_ctx_accesses, extend the switch case to consider untrusted
> > PTR_TO_BTF_ID in addition to normal PTR_TO_BTF_ID for PROBE_MEM
> > conversion for BPF_LDX.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   | 10 +++++++++-
> >  kernel/bpf/verifier.c | 34 +++++++++++++++++++++++++++-------
> >  2 files changed, 36 insertions(+), 8 deletions(-)
> >
>
> [...]
>
> > -       if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> > -               goto bad_type;
> > +       if (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF) {
> > +               if (reg->type != PTR_TO_BTF_ID &&
> > +                   reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL))
> > +                       goto bad_type;
> > +       } else { /* only unreferenced case accepts untrusted pointers */
> > +               if (reg->type != PTR_TO_BTF_ID &&
> > +                   reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL) &&
> > +                   reg->type != (PTR_TO_BTF_ID | PTR_UNTRUSTED) &&
> > +                   reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_UNTRUSTED))
>
> use base_type(), Luke! ;)
>

Ack, will switch.

> > +                       goto bad_type;
> > +       }
> >
> >         if (!btf_is_kernel(reg->btf)) {
> >                 verbose(env, "R%d must point to kernel BTF\n", regno);
>
> [...]

--
Kartikeya
