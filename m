Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DDD4BCBAA
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 03:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiBTCSc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 21:18:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiBTCSc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 21:18:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1139148
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:18:12 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l73so11178735pge.11
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ENmNkCM1XWPVyAg1PWhvB40IBkZrFCy8mzDSleW+jj0=;
        b=M74WS1lRKWjpwiTviSayyHUorCXHQdtyMQoWpCpEATZnX+wzWJd2mkEbZqoqmb+k27
         9quzY6saYVi2QKSWMU92QHakDNEtVztFRCk3fSktkF8jSgnVQj1/G/wa5ziPQE7nCLCv
         6eI0XR8QJ62zWb6yhXM4XgWPIaJIqGDduBgha6ldHClfBmG/SXYoapWlYyt/ZW0gWNwg
         7qEV51cPYxffR/TgNERMjK+3cUj5YebIHkFW9wtt/Kigkyvt5lZe+GRsEfRNkN3Y2tbn
         vXe8UPkrAzglDxKJti5bfBbYDfB86j/uHXGeHBE4lGchvQZhQB9qIGCqm0jGTC/0Ba8a
         eQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ENmNkCM1XWPVyAg1PWhvB40IBkZrFCy8mzDSleW+jj0=;
        b=ExdxMDs30C9QYzVd9oGSeV7q6+YeVv89pwI47jzzlYW9eu2NgE3zXgDvvBPoaY4GzZ
         Z727MjjJ36R9Hr+CP10uLT3GfEy6e9p59pj4gKwAjmIQH89hcDt88eROvsLdTbNlgPGT
         +9d3rq96x40v/5F7leF437ATDueay6IieRcTALG1rHXRkKNZP6Bnbx4PeAo7/M+I5Xrr
         TSZvDeeYMf+f94mKkWK/ufVafKbKxVAlPa2RX5OJ/8BqXoxNOxWew0Oj+9cBExP4nxer
         SEhCn4sJUoKC8UCMccEPkb35YDQh137wPxqbLsdMzijBrcSoOHsKMi725WzK4VURNWMR
         dX9g==
X-Gm-Message-State: AOAM532UT1nVOrfpO6Ms0VucdSNwDz0DP9LnO8usYmF+r/H+p4gI/1QY
        6tCjncFFxsSyPw4zbJv2ZGP5OiOVpTE=
X-Google-Smtp-Source: ABdhPJwNGkeYYpyCOuZwLGOh8EsSUsDoTJ9JW5BplNPOlisED/5VCk38/qkGbi18CqX3qgNuKXOKYA==
X-Received: by 2002:aa7:9253:0:b0:4e1:53d4:c2c6 with SMTP id 19-20020aa79253000000b004e153d4c2c6mr14276570pfp.62.1645323491393;
        Sat, 19 Feb 2022 18:18:11 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e3e2])
        by smtp.gmail.com with ESMTPSA id f16sm8316161pfa.147.2022.02.19.18.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:18:10 -0800 (PST)
Date:   Sat, 19 Feb 2022 18:18:08 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf v1 0/5] More fixes for crashes due to bad
 PTR_TO_BTF_ID reg->off
Message-ID: <20220220021808.surwmx5jhosasi2d@ast-mbp.dhcp.thefacebook.com>
References: <20220219113744.1852259-1-memxor@gmail.com>
 <20220219121035.c6c5dmvbchzaqqak@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219121035.c6c5dmvbchzaqqak@apollo.legion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 19, 2022 at 05:40:35PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Sat, Feb 19, 2022 at 05:07:39PM IST, Kumar Kartikeya Dwivedi wrote:
> > A few more fixes for bad PTR_TO_BTF_ID reg->off being accepted in places, that
> > can lead to the kernel crashing. Noticed while making sure my own series for BTF
> > ID pointer in map won't allow stores for pointers with incorrect offsets.
> >
> > I include one example where d_path can crash even if you NULL check
> > PTR_TO_BTF_ID, and one example of how missing NULL check in helper taking
> > PTR_TO_BTF_ID (like bpf_sock_from_file) is a real problem, see the selftest
> > patch.
> >
> > The &f->f_path becomes NULL + offset in case f is NULL, circumventing NULL
> > checks in existing helpers. The only thing needed to trigger this finding an
> > object that embeds the object of interest, and then somehow obtaining a NULL
> > PTR_TO_BTF_ID to it (not hard, esp. due to exception handler for PROBE_MEM loads
> > writing 0 to destination register).
> >
> > However, for the case of patch 2, it is allowed in my series since the next load
> > of the bad pointer stored using:
> >   struct file *f = ...; // some pointer walking returning NULL pointer
> >   map_val->ptr = &f->f_path; // ptr being struct path *
> > ... would be marked as PTR_UNTRUSTED, so it won't be allowed to be passed into
> > the kernel, and hence can be permitted. In referenced case, the PTR_TO_BTF_ID
> > should not be NULL anyway. kptr_get style helper takes PTR_TO_MAP_VALUE in
> > referenced ptr case only, so the load either yields NULL or RCU protected
> > pointer.
> >
> > Tests for patch 1 depend on fixup_kfunc_btf_id in test_verifier, hence will be
> > sent after merge window opens, some other changes after bpf tree merges into
> > bpf-next, but all pending ones can be seen here [0]. Tests for patch 2 are
> > included, and try to trigger crash without the fix, but it's not 100% reliable.
> > We may need special testing helpers or kfuncs to make it thorough, but wanted to
> > wait before getting feedback.
> >
> > Issue fixed by patch 2 is a bit more broader in scope, and would require proper
> > discussion (before being applied) on the correct way forward, as it is
> > technically backwards incompatible change, but hopefully never breaks real
> > programs, only malicious or already incorrect ones.
> >
> > Also, please suggest the right "Fixes" tag for patch 2.
> >
> > As for patch 3 (selftest), please suggest a better way to get a certain type of
> > PTR_TO_BTF_ID which can be NULL or NULL+offset. Can we add kfuncs for testing
> > that return such pointers and make them available to e.g. TC progs, if the fix
> > in patch 2 is acceptable?
> >
> >   [0]: https://github.com/kkdwivedi/linux/commits/fixes-bpf-next
> >
> 
> Looking at BPF CI [1], it seems it surfaces another problem I was seeing locally
> but couldn't craft a reliable test case for, that it forms a non-NULL but
> invalid pointer using pointer walking, in some cases RCU read lock provides
> protection for those cases, but not all (esp. if kernel doesn't clear the old
> pointer that was in use before, and has it sitting in some location). RDI (arg1)
> seems to be pointing somewhere behind the faulting address, which means the
> &f->f_path is bad.
> 
> But this requires a larger discussion.
> 
> In that case, PAGE_SIZE thing won't help. We may have to introduce a PTR_BPF_REF
> flag (e.g. set for ctx args of tracing progs, set based on BTF tagging in other
> places) which tells the verifier that the pointer for the duration of program
> will be valid, so it can be passed into helpers.
> 
> So for cases like &f->f_path it will work, since file + off will still have
> PTR_BPF_REF set in reg state. In case of pointer walking, where dst_reg state
> is updated on walk, we may have to explicitly tag members where PTR_BPF_REF can
> be inherited if parent object has PTR_BPF_REF (i.e. ref to parent implies ref to
> child cases).
> 
> Something like:
> 
> struct foo {
> 	...
> 	struct bar __bpf_ref *p;
> 	struct baz *q;
> 	...
> }
> 
> ... then if getting:
> 
> 	struct foo *f = ...; // PTR_TO_BTF_ID | PTR_BPF_REF
> 	struct bar *p = f->p; // Inherits PTR_BPF_REF
> 	struct baz *q = f->q; // Does not inherit PTR_BPF_REF
> 
> Thoughts?
> 
>   [1]: https://github.com/kernel-patches/bpf/runs/5258413028?check_suite_focus=true

fd_array wasn't zero initialized at alloc time, so it contains garbage.
fd_array[63] read that garbage.
So patches 2 and 3 don't help.
The 'fixes' list for patch 3 is ridiculous. No need.
Pls drop patch 2 and in instead of
+#define bpf_ptr_is_invalid(p) (unlikely((unsigned long)(p) < PAGE_SIZE))
do static inline function that checks
if ((unsigned long)p < user_addr_max())
and bails out.
bpf-next is fine.
Not sure whether patch 1 is strictly necessary after above change.
