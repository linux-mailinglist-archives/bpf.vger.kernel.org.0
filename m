Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338BE4BCBD0
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 03:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiBTC7z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 21:59:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiBTC7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 21:59:54 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8225575E
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:59:34 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso15740930pjt.4
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S7kciw8UwwWy8lzT3Qwv5WfQ+dEnI8GvRE9FTYbT/Kw=;
        b=qLiVmeTY5i+1jv6mhEIwJyo8PwWnkHHllcOriQipMiQTFr4V7qt9XC9CgLxflssJMn
         y/FG77bLLp+A1mWyUKrawDnz7wYyIWBPWgX+00fQrnWit5jBSCj+2d6V70k6Sf0yUtPn
         kHAdvNsJ+LNxMybqibUgTlFaJdK+RqEFc7lTstyfgn+PO/+jVMQDW621XkePT6I7A+xP
         Ad//FBz0wmmVNxrmz7vniky/qYJeybgqOGDptFYHNLhqIeGSOfoS9QWAsIg/X9XuYzLy
         BDEjpQ+eirqd6XlJqdliIurrZ6vYfz3IvOEYpNLCh1fW0ZOfN4/XnK1l6GH2trCVQkNT
         Uuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7kciw8UwwWy8lzT3Qwv5WfQ+dEnI8GvRE9FTYbT/Kw=;
        b=BjV3y/kJUWX2F2ecvo5samKzk5vyN7hS7YwOWlyFw2vmsuu95lNXVra4GxkVLjNFnX
         wM/EcVyq5D1kHFhZxo/h2Ue6QriOqKCELcq28rifHZ4NX1lJ4BAYAEU9nWO7aiaYQnpk
         rA6VlxRM27e6PBmNOIfNBVzSEi+adyUX9WkIgUoqSzj3HS/ih9w9YLerkbaa6ggkJIvX
         x8qwCVsOKhGiYaoNoqfQEaQD64wxWFCI5Xe8Ga/MIbleOOFvU35jDU1L13gnJJIefNzf
         iOgoq1OgDE3jYa+VkjvXePGi1rZGtyOO2/0XyHgQZhOcTQmJbSTLHGXlfDfJ0SAYxq4V
         yOlg==
X-Gm-Message-State: AOAM533gws605NdUU7XN/pKHZq6dQbdnhS7LfEszpY2UvH+nulwyfIZd
        7dfJf2oC/1mBlmSLxWa8rVuHXvgJt/U=
X-Google-Smtp-Source: ABdhPJxGcrkPNdq7Izu9+GLEGStg0WchxI9GSJAU/VC4uorRbZtXDpD9Ll6DBC9lEx2ThGTE7VeYaQ==
X-Received: by 2002:a17:902:b616:b0:14d:be7f:717e with SMTP id b22-20020a170902b61600b0014dbe7f717emr13662978pls.149.1645325974138;
        Sat, 19 Feb 2022 18:59:34 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id b14sm294566pjl.21.2022.02.19.18.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:59:33 -0800 (PST)
Date:   Sun, 20 Feb 2022 08:29:31 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf v1 0/5] More fixes for crashes due to bad
 PTR_TO_BTF_ID reg->off
Message-ID: <20220220025931.6rhvlii4i4emumik@apollo.legion>
References: <20220219113744.1852259-1-memxor@gmail.com>
 <20220219121035.c6c5dmvbchzaqqak@apollo.legion>
 <20220220021808.surwmx5jhosasi2d@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220021808.surwmx5jhosasi2d@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 20, 2022 at 07:48:08AM IST, Alexei Starovoitov wrote:
> On Sat, Feb 19, 2022 at 05:40:35PM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Sat, Feb 19, 2022 at 05:07:39PM IST, Kumar Kartikeya Dwivedi wrote:
> > > A few more fixes for bad PTR_TO_BTF_ID reg->off being accepted in places, that
> > > can lead to the kernel crashing. Noticed while making sure my own series for BTF
> > > ID pointer in map won't allow stores for pointers with incorrect offsets.
> > >
> > > I include one example where d_path can crash even if you NULL check
> > > PTR_TO_BTF_ID, and one example of how missing NULL check in helper taking
> > > PTR_TO_BTF_ID (like bpf_sock_from_file) is a real problem, see the selftest
> > > patch.
> > >
> > > The &f->f_path becomes NULL + offset in case f is NULL, circumventing NULL
> > > checks in existing helpers. The only thing needed to trigger this finding an
> > > object that embeds the object of interest, and then somehow obtaining a NULL
> > > PTR_TO_BTF_ID to it (not hard, esp. due to exception handler for PROBE_MEM loads
> > > writing 0 to destination register).
> > >
> > > However, for the case of patch 2, it is allowed in my series since the next load
> > > of the bad pointer stored using:
> > >   struct file *f = ...; // some pointer walking returning NULL pointer
> > >   map_val->ptr = &f->f_path; // ptr being struct path *
> > > ... would be marked as PTR_UNTRUSTED, so it won't be allowed to be passed into
> > > the kernel, and hence can be permitted. In referenced case, the PTR_TO_BTF_ID
> > > should not be NULL anyway. kptr_get style helper takes PTR_TO_MAP_VALUE in
> > > referenced ptr case only, so the load either yields NULL or RCU protected
> > > pointer.
> > >
> > > Tests for patch 1 depend on fixup_kfunc_btf_id in test_verifier, hence will be
> > > sent after merge window opens, some other changes after bpf tree merges into
> > > bpf-next, but all pending ones can be seen here [0]. Tests for patch 2 are
> > > included, and try to trigger crash without the fix, but it's not 100% reliable.
> > > We may need special testing helpers or kfuncs to make it thorough, but wanted to
> > > wait before getting feedback.
> > >
> > > Issue fixed by patch 2 is a bit more broader in scope, and would require proper
> > > discussion (before being applied) on the correct way forward, as it is
> > > technically backwards incompatible change, but hopefully never breaks real
> > > programs, only malicious or already incorrect ones.
> > >
> > > Also, please suggest the right "Fixes" tag for patch 2.
> > >
> > > As for patch 3 (selftest), please suggest a better way to get a certain type of
> > > PTR_TO_BTF_ID which can be NULL or NULL+offset. Can we add kfuncs for testing
> > > that return such pointers and make them available to e.g. TC progs, if the fix
> > > in patch 2 is acceptable?
> > >
> > >   [0]: https://github.com/kkdwivedi/linux/commits/fixes-bpf-next
> > >
> >
> > Looking at BPF CI [1], it seems it surfaces another problem I was seeing locally
> > but couldn't craft a reliable test case for, that it forms a non-NULL but
> > invalid pointer using pointer walking, in some cases RCU read lock provides
> > protection for those cases, but not all (esp. if kernel doesn't clear the old
> > pointer that was in use before, and has it sitting in some location). RDI (arg1)
> > seems to be pointing somewhere behind the faulting address, which means the
> > &f->f_path is bad.
> >
> > But this requires a larger discussion.
> >
> > In that case, PAGE_SIZE thing won't help. We may have to introduce a PTR_BPF_REF
> > flag (e.g. set for ctx args of tracing progs, set based on BTF tagging in other
> > places) which tells the verifier that the pointer for the duration of program
> > will be valid, so it can be passed into helpers.
> >
> > So for cases like &f->f_path it will work, since file + off will still have
> > PTR_BPF_REF set in reg state. In case of pointer walking, where dst_reg state
> > is updated on walk, we may have to explicitly tag members where PTR_BPF_REF can
> > be inherited if parent object has PTR_BPF_REF (i.e. ref to parent implies ref to
> > child cases).
> >
> > Something like:
> >
> > struct foo {
> > 	...
> > 	struct bar __bpf_ref *p;
> > 	struct baz *q;
> > 	...
> > }
> >
> > ... then if getting:
> >
> > 	struct foo *f = ...; // PTR_TO_BTF_ID | PTR_BPF_REF
> > 	struct bar *p = f->p; // Inherits PTR_BPF_REF
> > 	struct baz *q = f->q; // Does not inherit PTR_BPF_REF
> >
> > Thoughts?
> >
> >   [1]: https://github.com/kernel-patches/bpf/runs/5258413028?check_suite_focus=true
>
> fd_array wasn't zero initialized at alloc time, so it contains garbage.
> fd_array[63] read that garbage.
> So patches 2 and 3 don't help.
> The 'fixes' list for patch 3 is ridiculous. No need.
> Pls drop patch 2 and in instead of
> +#define bpf_ptr_is_invalid(p) (unlikely((unsigned long)(p) < PAGE_SIZE))
> do static inline function that checks
> if ((unsigned long)p < user_addr_max())

This prevents this specific case, but what happens when PTR_TO_BTF_ID can be
formed to an already freed object (which seems even more likely to me in
sleepable progs, because typical RCU grace period won't wait for us)? Or even
just reading from structures which don't clear pointers they have freed, but are
themselves not freed (so exception handling zeroing dst reg won't kick in).

> and bails out.
> bpf-next is fine.
> Not sure whether patch 1 is strictly necessary after above change.

It is still needed to prevent the var_off case. See [0]. I think it allows you
to pass PTR_TO_BTF_ID while not actually pointing to the actual object, as long
as reg->off is 0 (so that btf_struct_ids_match doesn't fail).

  [0]: https://github.com/kkdwivedi/linux/commit/51981fd301ff55edb72b6cf346c7ac302b3f1d7d#diff-98f6e99b9859bb0525d345f6b962f028d50a605b2397518ddd77b134b5a98977R124
--
Kartikeya
