Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1848A56ABB5
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 21:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiGGTSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 15:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiGGTSg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 15:18:36 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E771E62FB
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 12:18:34 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 5-20020a620605000000b00527ca01f8a3so7841345pfg.19
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=di/3X7K0Eq6JzY/+jIQgDDcERKrK8FXqpHC5V0V9MCQ=;
        b=pmNDuzB2H8UbtaxgLzpt77jYnYwqtXjNVwmPhbyduipCDbvKhmr9ELAqt0tbqP3DoH
         55UZtVKicj33VqH7DhT9z72+SBoA1NuwQpFW4jiqWwuL+04Z32skL+gASLl3c/ykKR1Y
         J58z5f6FgKTt1f54pcBQvSBAk5TbRCyy+u+qYe0DIb6AdRMBKjJQJfEI+1tU3gS8lJd4
         5UKfhhduaYoPL0vGNkZXuhAp6USRBme0LjDG4R7WBJHr1c1BW6+XoYIt6VWUfRvQ62MO
         syzPN4SQ0g4AOqBNFXf7hGXpIoMwS0ciuD+HDRjpS+NeIuEd/DZ7NVunK0Maibkn7cWg
         YdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=di/3X7K0Eq6JzY/+jIQgDDcERKrK8FXqpHC5V0V9MCQ=;
        b=54HZ5xee8Zp/Dy/YxToVNc7ySIMcnE+eC0BSJRuKInsdS1q8n3LTp8pYzllg+L1daA
         EWDtP6t/eG/er7CS8xfMFrkNQ5ptHUcjJZUTij/8YRPTqvv+/yCM6JGAZszrDaEAbSln
         FErVkhPYhvFstdNnDwYuqkQlAaLK3ZXAlCMoOr8V+OGzZYhiIZwPqokF+TDq4E42QCiB
         iVpKBP1bunB6AfMlOzWGnOkOT4S3eTQTv/cbnGHIeXyUyokFE8EWsgzG0GpG2vpPiEv7
         RZ+QM2rvv95RC+odNrgEQwV55bhkKUNWpR6W8RfHlaUWtRxxs36Etb3Jsc1O8kEdi700
         ZrAA==
X-Gm-Message-State: AJIora+wb6JF3UcpHoTqMrTqFeLPD7Cjc7SB3IKpMJ6rPi/oYdZ/uU4i
        PMKFjzqSslFuZID4CeAdl1XFC5s=
X-Google-Smtp-Source: AGRyM1tHUXHe239Z2VxhSu9MbW85v3mHc7jNRl951cavc1TnyWQld19rlnsk1vVd3gb2iZlqakceh+Q=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:cec4:b0:16a:16d6:f67f with SMTP id
 d4-20020a170902cec400b0016a16d6f67fmr52128633plg.139.1657221514413; Thu, 07
 Jul 2022 12:18:34 -0700 (PDT)
Date:   Thu, 7 Jul 2022 12:18:33 -0700
In-Reply-To: <20220707181451.6xdtdesokuetj4ud@kafai-mbp.dhcp.thefacebook.com>
Message-Id: <YscxieVQayT2cVgi@google.com>
Mime-Version: 1.0
References: <20220707160233.2078550-1-sdf@google.com> <20220707181451.6xdtdesokuetj4ud@kafai-mbp.dhcp.thefacebook.com>
Subject: Re: [PATCH bpf-next v2] bpf: check attach_func_proto more carefully
 in check_return_code
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/07, Martin KaFai Lau wrote:
> On Thu, Jul 07, 2022 at 09:02:33AM -0700, Stanislav Fomichev wrote:
> > Syzkaller reports the following crash:
> > RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
> > RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
> > RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610
> >
> > With the following reproducer:
> > bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3,  
> &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"],  
> &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b,  
> 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
> >
> > Because we don't enforce expected_attach_type for XDP programs,
> > we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
> > part in check_return_code and follow up with testing
> > `prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
> > is NULL.
> >
> > Add explicit prog_type check for the "Note, BPF_LSM_CGROUP that
> > attach ..." condition. Also, don't skip return code check for
> > LSM/STRUCT_OPS.
> >
> > The above actually brings an issue with existing selftest which
> > tries to return EPERM from void inet_csk_clone. Fix the
> > test (and move called_socket_clone to make sure it's not
> > incremented in case of an error) and add a new one to explicitly
> > verify this condition.
> >
> > v2:
> > - Martin: don't add new helper, check prog_type instead
> > - Martin: check expected_attach_type as well at the function entry
> > - Update selftest to verify this condition
> >
> > Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> > Reported-by: syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  kernel/bpf/verifier.c                              |  2 ++
> >  .../testing/selftests/bpf/prog_tests/lsm_cgroup.c  | 12 ++++++++++++
> >  tools/testing/selftests/bpf/progs/lsm_cgroup.c     | 12 ++++++------
> >  .../selftests/bpf/progs/lsm_cgroup_nonvoid.c       | 14 ++++++++++++++
> >  4 files changed, 34 insertions(+), 6 deletions(-)
> >  create mode 100644  
> tools/testing/selftests/bpf/progs/lsm_cgroup_nonvoid.c
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index df3ec6b05f05..2bc1e7252778 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10445,6 +10445,7 @@ static int check_return_code(struct  
> bpf_verifier_env *env)
> >
> >  	/* LSM and struct_ops func-ptr's return type could be "void" */
> >  	if (!is_subprog &&
> > +	    prog->expected_attach_type != BPF_LSM_CGROUP &&
> BPF_PROG_TYPE_STRUCT_OPS also uses the expected_attach_type,
> so the expected_attach_type check should only be done for LSM prog alone.
> Others lgtm.

In this case, something like the following should be sufficient?

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2bc1e7252778..6702a5fc12e6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10445,11 +10445,13 @@ static int check_return_code(struct  
bpf_verifier_env *env)

  	/* LSM and struct_ops func-ptr's return type could be "void" */
  	if (!is_subprog &&
-	    prog->expected_attach_type != BPF_LSM_CGROUP &&
-	    (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
-	     prog_type == BPF_PROG_TYPE_LSM) &&
-	    !prog->aux->attach_func_proto->type)
-		return 0;
+	    !prog->aux->attach_func_proto->type) {
+		if (prog_type == BPF_PROG_TYPE_STRUCT_OPS)
+			return 0;
+		if (prog_type == BPF_PROG_TYPE_LSM &&
+		    prog->expected_attach_type != BPF_LSM_CGROUP)
+			return 0;
+	}

  	/* eBPF calling convention is such that R0 is used
  	 * to return the value from eBPF program.

> >  	    (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> >  	     prog_type == BPF_PROG_TYPE_LSM) &&
> >  	    !prog->aux->attach_func_proto->type)
> > @@ -10572,6 +10573,7 @@ static int check_return_code(struct  
> bpf_verifier_env *env)
> >  	if (!tnum_in(range, reg->var_off)) {
> >  		verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
> >  		if (prog->expected_attach_type == BPF_LSM_CGROUP &&
> > +		    prog_type == BPF_PROG_TYPE_LSM &&
> >  		    !prog->aux->attach_func_proto->type)
> >  			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks  
> can't modify return value!\n");
> >  		return -EINVAL;
