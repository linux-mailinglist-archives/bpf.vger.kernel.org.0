Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1F50D567
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbiDXVwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiDXVww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71987644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s17so22943097plg.9
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hm4ZDwxII8XenGzqSNjVlPsDilbbhT/DEDE2GeOBYYg=;
        b=mSrm2IEIuHQSGaz1zeRBzLGkwCcdV+7yuLZcN6iFQh1BSX0tfp8jXt13+sDNNsL3YZ
         k2CF3/jobcfX4s5xDXp3kF/jaVgLMmzJppttJCBETDuGr2hFe5C5UxRwTCp3Y16vw7UM
         riCT/C+Hs9xom8F5PD7Rbr3Y1xBO2IqxQbdBGJaVLee30VSqaSof/eu9HcATyyBVdgVB
         GyRbHnwEUpOBZ09ioBz5ZcHUoAsggSXC2ShPjPr+ionKL8CdrrQlP9s24x7qcSCt8kKh
         q8psPP896odn66p1Q0UrZqbUWml0WiqUBIA7fDaEpTqWRx8FJhcmTFdpzOMO+rrhzD3X
         Xt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hm4ZDwxII8XenGzqSNjVlPsDilbbhT/DEDE2GeOBYYg=;
        b=DO54xKHDNFY8Z+DLiVSxsryb9u/UnyMk/cdZZ9lM9VLOKxwufVXydALCAoETdayVGf
         bt9dA1fwUujQxxqjiyUghJkiMJ15SqtDkrN+AMb3N34Kuj3t720STek6OpQJAJMEaRpZ
         /BehwboJFkp/m1YX47eP33lPU3crMTTRcMEmLikxvXtWy5fKxfPWQyIQwxi9WBXoMmEw
         +H4tdvwuTD9W1F/UlKvAL1MemxasGpJl21XywR962fpDZKkGZz6aSdJG5aPnxNiA4Zme
         Vn60wskMizbfvoBrACZp5m/4eZbs0ZTxvhOEVjSNs+ehjwpjb70PYLAvYLbknil+lV36
         hXkA==
X-Gm-Message-State: AOAM533bv2NhRl3dVi7RjQaXwgQbUQvZq1djZEp0fvFX4Z/C6TJW23yx
        mGlTHQG0ZAU1Ql7fD8Nrjmw=
X-Google-Smtp-Source: ABdhPJxcDgruCSHSuPVZr11qO73++kzo3iWfmDAV8Z67P/621i5IQJ3KKEEwf6L2yykDlAtPzj4fZw==
X-Received: by 2002:a17:90a:730b:b0:1d9:7fc0:47c5 with SMTP id m11-20020a17090a730b00b001d97fc047c5mr753502pjk.60.1650836989947;
        Sun, 24 Apr 2022 14:49:49 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id u25-20020a62d459000000b0050d299e3b7dsm4389572pfl.186.2022.04.24.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:49 -0700 (PDT)
Date:   Mon, 25 Apr 2022 03:20:06 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 03/13] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220424215006.53rrzec4pkucjpf7@apollo.legion>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-4-memxor@gmail.com>
 <20220421041528.eez5euhgsm5dvjwz@MBP-98dd607d3435.dhcp.thefacebook.com>
 <20220421193621.3rk7rys7gjtjdhw7@apollo.legion>
 <CAADnVQLntQ7zVXXHZBpL_1H+ph8Evtcng-yG5QP5tfq5sYdHnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLntQ7zVXXHZBpL_1H+ph8Evtcng-yG5QP5tfq5sYdHnw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 22, 2022 at 03:56:44AM IST, Alexei Starovoitov wrote:
> On Thu, Apr 21, 2022 at 12:36 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > > > +
> > > > +   if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > > +                             off_desc->kptr.btf, off_desc->kptr.btf_id))
> > > > +           goto bad_type;
> > >
> > > Is full type comparison really needed?
> >
> > Yes.
> >
> > > reg->btf should be the same pointer as off_desc->kptr.btf
> > > and btf_id should match exactly.
> >
> > This is not true, it can be vmlinux or module BTF. But if you mean just
> > comparing the pointer and btf_id, we still need to handle reg->off.
> >
> > We want to support cases like:
> >
> > struct foo {
> >         struct bar br;
> >         struct baz bz;
> > };
> >
> > struct foo *v = func(); // PTR_TO_BTF_ID
> > map->foo = v;      // reg->off is zero, btf and btf_id matches type.
> > map->bar = &v->br; // reg->off is still zero, but we need to walk and retry with
> >                    // first member type of struct after comparison fails.
> > map->baz = &v->bz; // reg->off is non-zero, so struct needs to be walked to
> >                    // match type.
> >
> > In the ref case, the argument's offset will always be 0, so third case is not
> > going to work, but in the unref case, we want to allow storing pointers to
> > structs embedded inside parent struct.
> >
> > Please let me know if I misunderstood what you meant.
>
> Makes sense.
> Please add this comment to the code.
>

I took a closer look at this, and I think we're missing one extra corner case
from the ones covered in 24d5bb806c7e, i.e. when reg->off is zero and struct is
walked to match type. This would be incorrect for release/kptr_ref case, even if
it is unlikely to occur in practice, it should be rejected by default. I
included a patch + selftest for this in v6, ptal.

--
Kartikeya
