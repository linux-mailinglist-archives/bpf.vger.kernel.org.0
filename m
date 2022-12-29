Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8732659257
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 23:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiL2WAI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 17:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiL2WAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 17:00:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB117409
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 14:00:02 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s5so28285505edc.12
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 14:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NfILxOtTrwOessBNpH/M2cZYHaUdUsckQa5zxZrMslQ=;
        b=TfIxjCr5FzO5XPN4bO73oQSVc2FylIEKfMNGR/FLa1jEUkZroBJiQGlwGC3OkkxzV7
         ca/8to7VSm3o1xLJiNroyHFpwEl7d2qVI9QlIVbzj9kfslpJjtt+Q3UDC7cZdBBb/GC3
         icK0vizI6GuPFJnI/8+CeqEj+y4GWywocfZ3EDPykFtPenWt7jx2C1wcngBxw/k75FG+
         BGUYU3dTvUbgxOkv42QJ42VgkpPvXVrpUoepZSsOk89ntvkeuqtx+QDXsY/ktZ8jF/NH
         UuacSqXavY4+kHeSOkaTj4fnZ4G+jFJ6dgtz2ycX5FK/IhtvE2cHsxennW3XEXUXA0Dd
         FMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfILxOtTrwOessBNpH/M2cZYHaUdUsckQa5zxZrMslQ=;
        b=pxXzXA/aktth6oeeATrJfSTO4Ob2J6YkhQdN6xrVjXgk3FwGCc7PbU6uGM17FpyEf/
         0wZI4s44KnN+fXpUhctf8ur+RHtcHIv5TLSdURtg7i3Nr8D06U+3Ri3A6UHVAV8FfKRW
         9tJGfbv0tWdQ78DvUIUeJ3hMdyFEcO/XOs8/ZY/yp2V/MHwAYOoEjN7+fyXK7E8oc+ul
         th4nDMDA9lIrQURKmiW5eq1HMO6XLmx7Fqe0ezOB6Rn+sNoc/e1ii1W7Es2Gd/uacUn/
         LzGK1xNxPxhzY59VaujkTTNF6SoBjq2zprSQuwKbcuq/EufXeNcdTq9rUTkN6SOXqYfw
         4U3A==
X-Gm-Message-State: AFqh2kqE7deCBVZV70nqk9HePcLKHeI4WVUY1s1Pj/659sZm8NlGnjiJ
        56hMQl/RofVK5BEcItioYvvGMeEdBbjmqbUA57w=
X-Google-Smtp-Source: AMrXdXv9KsCmvXn0Ki3nXCMt6HfYC8xPO2w7oEBcr1siwvJZtKUg+98PftA3+11uxVTA2ac9N8BaZ1695bRVIgo/99w=
X-Received: by 2002:a05:6402:2208:b0:48a:7ada:b260 with SMTP id
 cq8-20020a056402220800b0048a7adab260mr144864edb.311.1672351201351; Thu, 29
 Dec 2022 14:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20221223054921.958283-1-andrii@kernel.org> <20221223054921.958283-8-andrii@kernel.org>
 <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Dec 2022 13:59:49 -0800
Message-ID: <CAEf4BzaT_kp-F3QMeGqpCf8ekhmDVjHwV4y7fYtxjWPFq1yhSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with
 default case in regsafe()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 27, 2022 at 6:00 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 22, 2022 at 09:49:21PM -0800, Andrii Nakryiko wrote:
> > Make default case in regsafe() safer. Instead of doing byte-by-byte
>
> I love the patches 1-6, but this one is not making it safer.
> It looks to be going less safe route.
> More below.
>
> > comparison, take into account ID remapping and also range and var_off
>
> ID remapping is handled by the patch 6 in regs_exact().
> This patch adds range and var_off check as default.
> Which might not be correct in the future.
>
> > checks. For most of registers range and var_off will be zero (not set),
> > which doesn't matter. For some, like PTR_TO_MAP_{KEY,VALUE}, this
> > generalized logic is exactly matching what regsafe() was doing as
> > a special case. But in any case, if register has id and/or ref_obj_id
> > set, check it using check_ids() logic, taking into account idmap.
>
> That was already done in patch 6. So the commit log is misleading.
> It's arguing that it's a benefit of this change while it was in the previous patch.

True, I think I had regs_exact() and regs_equals() change in one
commit and split it at the last minute before submitting (I felt like
patch #7 will be controversial ;) ), should have proofread messages
more carefully. Sorry about that.

>
> > With these changes, default case should be handling most registers more
> > correctly, and even for future register would be a good default. For some
> > special cases, like PTR_TO_PACKET, one would still need to implement extra
> > checks (like special handling of reg->range) to get better state
> > equivalence, but default logic shouldn't be wrong.
>
> PTR_TO_BTF_ID with var_off would be a counter example where
> such default of comparing ranges and var_off would lead to issues.
> Currently PTR_TO_BTF_ID doesn't allow var_off, but folks requested this support.
> The range_within() logic is safe only for types like PTR_TO_MAP_KEY/VALUE
> that start from zero and have uniform typeless blob of bytes.
> PTR_TO_BTF_ID with var_off would be wrong to do with just range_within().

I'm trying to understand this future problem. I think this is the same
issue that Kumar was trying to fix before, but when I asked for more
specifics I didn't really get good answer of when this combined
var_off and range_within() would be incorrect.

Do you mind showing (even if hypothetically) an example when
var_off+range_within() won't work? I'm trying to understand this. We
should either document why this is not safe, in general, or come to
conclusion that it is safe. It's second time this comes up, so let's
spend a bit of time getting to the bottom of this?

>
> SCALARS and PTR_TO_BTF_ID will likely dominate future bpf progs.
> Keeping default as regs_exact (that does ID match) is safer default.

It's fine, though the point of this patch set was patch #7, enabling
logic similar to PTR_TO_MAP_VALUE for PTR_TO_MEM and PTR_TO_BUF. I can
send specific fixes for that, no problem. But as I said above, I'm
really curious to understand what kind of situations will lead to
unsafety if we do var_off+range_within checks.

>
> Having said all that the focus on safety should be balanced with focus on performance
> of the verifier itself.
> The regsafe is the hottest function.
> That first memcmp used to be the hottest part of the whole verifier.

yeah, and it was done unconditionally even if not needed, which was
kind of weird when I started looking at this. Probably some
refactoring leftover.

> I suspect this refactoring won't change the perf profile, but we can optimize it.
> Assuming that SCALAR, PTR_TO_BTF_ID and PTR_TO_MAP will be the majority of types
> we can special case them and refactor comparison to only things
> that matter to these types. var_off and min/max_value are the biggest part
> of bpf_reg_state. They should be zero for PTR_TO_BTF_ID, but we already check
> that in other parts of the verifier. There is no need to compare zeros again
> in the hottest regsafe() function.
> Same thing for SCALAR. Doing regs_exact() with big memcmp and then finer range_within()
> on the same bytes is probably wasteful and can be optimized.
> We might consider reshuffling bpf_reg_state fields again depending on cache line usage.
> I suspect doing "smart" reg comparison we will be able to significantly
> improve verification speed. Please consider for a follow up.

I agree. Perf wasn't the point for me (this is a preliminary for
iterator stuff to improve state equivalence checks), so I didn't want
to spend extra time on this (especially that benchmarking this
properly is time consuming, as benchmarking under QEMU isn't
representative (from me experiences with BPF ringbuf benchmarking).
But I'll keep it on TODO list, either for me or anyone interested in
contributing.

>
> I've applied the first 6 patches.

Cool, thanks, less patches to carry around. If you don't mind, let's
look at this var_off concern in details. I can send
PTR_TO_MEM-specific follow up fix, but if we can convince ourselves
that generic logic is safe and future-proof, I'd rather do a generic
change.
