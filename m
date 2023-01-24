Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6567A49A
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 22:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjAXVLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 16:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAXVLL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 16:11:11 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA23F286;
        Tue, 24 Jan 2023 13:11:10 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso3416465pjj.1;
        Tue, 24 Jan 2023 13:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ss0SZeBtkJ7QpD8l3oHEzxDybW1VYSzAEeuI0YqP6CY=;
        b=2tBPXU/2oVcQTnYzbCtgPubL9hWnWlKs2ZVbtaCoU7lOzGyM4LX1HSXk0kh1rBDRsY
         xZPY8Fn92wqojJeoDh3s9j0qcpnokV8xo2WBRAZQQ9LB9OvqU29A9te9Q8WXnHXYLz2V
         M/D2mjhhkn9MkdTnXXVPnubbbNzXqIt1OlJc26Fspz/p6vb00sxdvuyzFA6DVHKhQAhV
         ZGOv2khKnV80ufHeFpWv5H4hAQLSx91fFnZXJPc04OXlGK5/7KP1op2L39J109H9jM4z
         BO6v9Qk4smNuEAaClfzAAdcd+Yuqdjbk14s5f24zIJR/DyzE5D+qEg1QRiaJH89Rd9Qf
         vX1g==
X-Gm-Message-State: AFqh2kqeSJ7q8zHzwHeBdUMp3acDWUOBMBGeiyc2r9vi/CnT5+ORzJy8
        Q6Nf5tjcwtidhxsWOM1PubM=
X-Google-Smtp-Source: AMrXdXtZf9Cas1NrdMubZUJkfSlUzUrdaOCauZzGg6YaboU6OYUFDIx/qBZoLOnCN3B+twW3slr51Q==
X-Received: by 2002:a17:902:e5d2:b0:191:3808:14b0 with SMTP id u18-20020a170902e5d200b00191380814b0mr40520566plf.4.1674594669087;
        Tue, 24 Jan 2023 13:11:09 -0800 (PST)
Received: from maniforge ([2620:10d:c090:400::5:ce3f])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902820c00b0019488090884sm2079384pln.273.2023.01.24.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 13:11:08 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:11:04 -0600
From:   David Vernet <void@manifault.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@meta.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] bpf/selftests: Verify struct_ops prog
 sleepable behavior
Message-ID: <Y9BJaFS9rwA/5Cb7@maniforge>
References: <20230124160802.1122124-1-void@manifault.com>
 <20230124160802.1122124-5-void@manifault.com>
 <57a2e223-6fe8-7b7b-1b02-800665673ad1@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a2e223-6fe8-7b7b-1b02-800665673ad1@linux.dev>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 11:52:17AM -0800, Martin KaFai Lau wrote:
> On 1/24/23 8:08 AM, David Vernet wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 50123afab9bf..64034311c5f7 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1474,6 +1474,7 @@ struct bpf_dummy_ops {
> >   	int (*test_1)(struct bpf_dummy_ops_state *cb);
> >   	int (*test_2)(struct bpf_dummy_ops_state *cb, int a1, unsigned short a2,
> >   		      char a3, unsigned long a4);
> > +	int (*test_3)(struct bpf_dummy_ops_state *cb);
> 
> nit. May be a self describe name like test_sleepable().

Will do. I agree that's better, but was just following the existing
contours of the file. Happy to have an excuse to improve it.

> 
> >   };
> >   int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
> > diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> > index 1ac4467928a9..46099737d1da 100644
> > --- a/net/bpf/bpf_dummy_struct_ops.c
> > +++ b/net/bpf/bpf_dummy_struct_ops.c
> > @@ -154,6 +154,23 @@ static bool bpf_dummy_ops_is_valid_access(int off, int size,
> >   	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> >   }
> > +static int bpf_dummy_ops_check_member(const struct btf_type *t,
> > +				      const struct btf_member *member,
> > +				      const struct bpf_prog *prog)
> > +{
> > +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> > +
> > +	switch (moff) {
> > +	case offsetof(struct bpf_dummy_ops, test_3):
> > +		break;
> > +	default:
> > +		if (prog->aux->sleepable)
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
> >   					   const struct bpf_reg_state *reg,
> >   					   int off, int size, enum bpf_access_type atype,
> > @@ -208,6 +225,7 @@ static void bpf_dummy_unreg(void *kdata)
> >   struct bpf_struct_ops bpf_bpf_dummy_ops = {
> >   	.verifier_ops = &bpf_dummy_verifier_ops,
> >   	.init = bpf_dummy_init,
> > +	.check_member = bpf_dummy_ops_check_member,
> >   	.init_member = bpf_dummy_init_member,
> >   	.reg = bpf_dummy_reg,
> >   	.unreg = bpf_dummy_unreg,
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 8da0d73b368e..33ea57d34c0b 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -730,6 +730,10 @@ noinline void bpf_kfunc_call_test_destructive(void)
> >   {
> >   }
> > +noinline void bpf_kfunc_call_test_sleepable(void)
> > +{
> > +}
> > +
> >   __diag_pop();
> >   BTF_SET8_START(bpf_test_modify_return_ids)
> > @@ -767,6 +771,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
> >   BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
> >   BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
> >   BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
> > +BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
> 
> KF_SLEEPABLE kfunc is not specific to the struct_ops prog. I hope a test has
> already covered that KF_SLEEPABLE kfunc can only be called from sleepable
> prog. eg. there is bpf_fentry_test1.
> 
> This new kfunc could then be omitted and make the test simpler. There is no
> need to add the test to the DENYLIST.s390x:
> https://github.com/kernel-patches/bpf/actions/runs/3998188872/jobs/6861920516

Ah, good point. Totally forgot about s390x. Will send out a v3 that
doesn't bother with also including the KF_SLEEPABLE invocation, and
instead just validates that .check_member() is called.

> 
> > diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h b/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h
> > new file mode 100644
> > index 000000000000..7d0761594b69
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> > +
> > +#ifndef _DUMMY_ST_OPS_COMMON_H
> > +#define _DUMMY_ST_OPS_COMMON_H
> > +
> > +struct bpf_dummy_ops_state {
> > +	int val;
> > +} __attribute__((preserve_access_index));
> > +
> > +struct bpf_dummy_ops {
> > +	int (*test_1)(struct bpf_dummy_ops_state *state);
> > +	int (*test_2)(struct bpf_dummy_ops_state *state, int a1, unsigned short a2,
> > +		      char a3, unsigned long a4);
> > +	int (*test_3)(struct bpf_dummy_ops_state *state);
> > +};
> 
> Instead of adding a new dummy_st_ops_common.h header, try to directly
> include vmlinux.h in the dummy_st_ops_{success,fail}.c.

Ack, I'll give it a shot. Should be fine to include once we get rid of
the test logic that includes the KF_SLEEPABLE kfunc.

> 
> > +
> > +void bpf_kfunc_call_test_sleepable(void) __ksym;
> 
