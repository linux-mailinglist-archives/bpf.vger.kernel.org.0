Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5563A659429
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 03:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiL3CUk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 21:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiL3CUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 21:20:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FDE186DA
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 18:19:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n4so20615889plp.1
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 18:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiCBsiB5aBLZPq1FMmYVkb1LDhDl3bAmM8Dzr9Aw+BY=;
        b=gtGv7SfarbtQT7i/BdmlEyjo7Q4gGX/HMBXHEB+stpzOz6XttPlHC1NcT0gpqNTwec
         63Wr1ttzJtjJGaqSKb6ooUK7MwTVRsoYu6kh4uF//Vybzodb1XDaSZYQYauBQGqUx5pz
         A3AocCKcE7EJAS8lTZ/Sk+2s2GDGZi2kuUFq0wtuE+LBK3974XlKQGs5DZNxW/8FgHal
         OOHZXBt0Q1W9aF7GGwc2N/aMCPQYhsmrgfqZEhMIEqboEhbGWYIoH8SzDZAvat+8TEBj
         +pjForDMAw6E/J8EtLDfyZr7208MZD9wlDVngu5PJi4/sx3lk2iIIKRXIf5+HannX8zh
         Mk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiCBsiB5aBLZPq1FMmYVkb1LDhDl3bAmM8Dzr9Aw+BY=;
        b=esMhOqKpmsSzxmzuj5BdyFkCdThfItyw00saasEjjGsBhcl7eoWMx4QnpHvZMAsaRL
         4mjs4/I2t0rJkOfuj3W1k08y3BHwo7Eu/JpAiQ1biPo6fM8KiD930XqtaSaCX13UP507
         sKDbX0icdxKM9hE/wm/Ujz1fi31MoqZgJB+d9CJyOfhdltvvYw5HSfKZ6wejnmDRV5Dg
         Cuum066v5FUc7h2//c9t24hfg6MhbTej75nIhJxWJvR9j0ABw2dJ0GDlgSyUF5BQzAX4
         7kgiMkiCvNoRxyEh4xu1mtzROgoPwgNV/j6jAUm+6vy0pPm8ISpXFFDOPkLlKduPf0of
         zZkA==
X-Gm-Message-State: AFqh2kqI3gmXATE9bruaq1dWF8hpQhz0TlPhR3eYgtxsgB4iM7uMDOj9
        46qTCWVf0w2Cpl4i/5cC+j1VprFStBw=
X-Google-Smtp-Source: AMrXdXu9Oi3YPauT7cYlXelA+6gn7Yzp/7DdqO+bBR4TyWk46uN+QIeVmULrhL4wfPWAU033asDscg==
X-Received: by 2002:a17:902:ab93:b0:191:317f:472 with SMTP id f19-20020a170902ab9300b00191317f0472mr31836363plr.64.1672366760160;
        Thu, 29 Dec 2022 18:19:20 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::4:afb4])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903404d00b00189ec622d23sm13670454pla.100.2022.12.29.18.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:19:19 -0800 (PST)
Date:   Thu, 29 Dec 2022 18:19:17 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with
 default case in regsafe()
Message-ID: <20221230021917.yuvm4g7sjj7vy5qc@MacBook-Pro-6.local>
References: <20221223054921.958283-1-andrii@kernel.org>
 <20221223054921.958283-8-andrii@kernel.org>
 <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzaT_kp-F3QMeGqpCf8ekhmDVjHwV4y7fYtxjWPFq1yhSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaT_kp-F3QMeGqpCf8ekhmDVjHwV4y7fYtxjWPFq1yhSg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 29, 2022 at 01:59:49PM -0800, Andrii Nakryiko wrote:
> On Tue, Dec 27, 2022 at 6:00 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Dec 22, 2022 at 09:49:21PM -0800, Andrii Nakryiko wrote:
> > > Make default case in regsafe() safer. Instead of doing byte-by-byte
> >
> > I love the patches 1-6, but this one is not making it safer.
> > It looks to be going less safe route.
> > More below.
> >
> > > comparison, take into account ID remapping and also range and var_off
> >
> > ID remapping is handled by the patch 6 in regs_exact().
> > This patch adds range and var_off check as default.
> > Which might not be correct in the future.
> >
> > > checks. For most of registers range and var_off will be zero (not set),
> > > which doesn't matter. For some, like PTR_TO_MAP_{KEY,VALUE}, this
> > > generalized logic is exactly matching what regsafe() was doing as
> > > a special case. But in any case, if register has id and/or ref_obj_id
> > > set, check it using check_ids() logic, taking into account idmap.
> >
> > That was already done in patch 6. So the commit log is misleading.
> > It's arguing that it's a benefit of this change while it was in the previous patch.
> 
> True, I think I had regs_exact() and regs_equals() change in one
> commit and split it at the last minute before submitting (I felt like
> patch #7 will be controversial ;) ), should have proofread messages
> more carefully. Sorry about that.
> 
> >
> > > With these changes, default case should be handling most registers more
> > > correctly, and even for future register would be a good default. For some
> > > special cases, like PTR_TO_PACKET, one would still need to implement extra
> > > checks (like special handling of reg->range) to get better state
> > > equivalence, but default logic shouldn't be wrong.
> >
> > PTR_TO_BTF_ID with var_off would be a counter example where
> > such default of comparing ranges and var_off would lead to issues.
> > Currently PTR_TO_BTF_ID doesn't allow var_off, but folks requested this support.
> > The range_within() logic is safe only for types like PTR_TO_MAP_KEY/VALUE
> > that start from zero and have uniform typeless blob of bytes.
> > PTR_TO_BTF_ID with var_off would be wrong to do with just range_within().
> 
> I'm trying to understand this future problem. I think this is the same
> issue that Kumar was trying to fix before, but when I asked for more
> specifics I didn't really get good answer of when this combined
> var_off and range_within() would be incorrect.
> 
> Do you mind showing (even if hypothetically) an example when
> var_off+range_within() won't work? I'm trying to understand this. We
> should either document why this is not safe, in general, or come to
> conclusion that it is safe. It's second time this comes up, so let's
> spend a bit of time getting to the bottom of this?

Kumar's example was for a constant. range_within is the same as equality
check, so we concluded it's safe for that case.
I'm worried about non uniformity of structs with types and general
comparison of ranges.
I guess you're arguing that if old state had wider range than every single
possible value from that range was already validated to be safe and
hence new narrow range is safe too.
It sounds logical, but it can get tricky with ranges and branch taken logic.
Consider something like:
R1=(min=2,max=8), R2=(min=1, max=10)
if (R1 within R2) // bpf prog is doing its own 'within'
  // branch taken kicks in
else
  // issues that were never checked

Now new state has:
R1=(min=4,max=6), R2=(min=5, max=5)

Both R1 and R2 of new state individually range_within of old safe state,
but together the prog may go to the unverified path.
Not sure whether it's practical today.
You asked for hypothetical, so here it goes :)
More gut feel than real issue.

> 
> >
> > SCALARS and PTR_TO_BTF_ID will likely dominate future bpf progs.
> > Keeping default as regs_exact (that does ID match) is safer default.
> 
> It's fine, though the point of this patch set was patch #7, enabling
> logic similar to PTR_TO_MAP_VALUE for PTR_TO_MEM and PTR_TO_BUF. I can
> send specific fixes for that, no problem. But as I said above, I'm
> really curious to understand what kind of situations will lead to
> unsafety if we do var_off+range_within checks.

PTR_TO_MEM and PTR_TO_BUF explicitly are likely ok despite my convoluted
example above.
I'm less sure about PTR_TO_BTF_ID. It could be ok.
Just feels safer to opt-in each type explicitly.

> 
> >
> > Having said all that the focus on safety should be balanced with focus on performance
> > of the verifier itself.
> > The regsafe is the hottest function.
> > That first memcmp used to be the hottest part of the whole verifier.
> 
> yeah, and it was done unconditionally even if not needed, which was
> kind of weird when I started looking at this. Probably some
> refactoring leftover.
> 
> > I suspect this refactoring won't change the perf profile, but we can optimize it.
> > Assuming that SCALAR, PTR_TO_BTF_ID and PTR_TO_MAP will be the majority of types
> > we can special case them and refactor comparison to only things
> > that matter to these types. var_off and min/max_value are the biggest part
> > of bpf_reg_state. They should be zero for PTR_TO_BTF_ID, but we already check
> > that in other parts of the verifier. There is no need to compare zeros again
> > in the hottest regsafe() function.
> > Same thing for SCALAR. Doing regs_exact() with big memcmp and then finer range_within()
> > on the same bytes is probably wasteful and can be optimized.
> > We might consider reshuffling bpf_reg_state fields again depending on cache line usage.
> > I suspect doing "smart" reg comparison we will be able to significantly
> > improve verification speed. Please consider for a follow up.
> 
> I agree. Perf wasn't the point for me (this is a preliminary for
> iterator stuff to improve state equivalence checks), so I didn't want
> to spend extra time on this (especially that benchmarking this
> properly is time consuming, as benchmarking under QEMU isn't
> representative (from me experiences with BPF ringbuf benchmarking).
> But I'll keep it on TODO list, either for me or anyone interested in
> contributing.

Thank you. Lorenz was pondering at it at some point, but lost interest. I guess.
I did a bunch of perf runs with our test_verif_scale* long ago.
The perf report used to be the same and stable for them.
processed_insn and number of states affects both memory and speed
and % wise have higher contribution to verifier speed, so any improvements
there help more. Optimizing the actual regsafe() is secondary.
Just something to put on todo list.

> >
> > I've applied the first 6 patches.
> 
> Cool, thanks, less patches to carry around. If you don't mind, let's
> look at this var_off concern in details. I can send
> PTR_TO_MEM-specific follow up fix, but if we can convince ourselves
> that generic logic is safe and future-proof, I'd rather do a generic
> change.
