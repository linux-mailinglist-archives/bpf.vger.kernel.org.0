Return-Path: <bpf+bounces-7933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF177E9CB
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 21:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A431C2119A
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827717746;
	Wed, 16 Aug 2023 19:39:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84814A80
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 19:39:48 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAECC271F
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 12:39:45 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-76d7224c5bcso55143885a.2
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 12:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692214785; x=1692819585;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbmHsSrwuHnzqw/r7i7I+jmR6BQBfJK00o9mmYdieLU=;
        b=MGiQmNfyQ937U8aizBkEddC5EusXfrk4pku17giUqcvrQBtasq9gD2mrjM3dT5accD
         Ymuy+ect9zONnqcBZyer7xdkRv3fJ/4KZSzWhGiiXZ1kego4/3kUVLBQRvDvuq7RGIsU
         wHwmR0E3QfachEAeVeDPFABk5xdxBj/Llq+k8Uu4lBkBD917kypWVkP7fc7BXhO54MIz
         cn31zd7yYNWmWBQZyJgko5+gUNNb9sE2t6nmcOoFnGCi9Q4UtkNh6KQCdjOjbQHlI5XW
         DtC1UL46RJmWgfFrG+ax+EP9F3kpAcNqVuI59pJv1JNG0vq8MzSjVSj2xpF07ahVKfYR
         robg==
X-Gm-Message-State: AOJu0YzneBOe1AN7G5ov5PLojGpbvZN0Ey7OfYvVPM7jdwRtwBOK/AVn
	9+iTrFuxomOgo0uFo50S0s8=
X-Google-Smtp-Source: AGHT+IF04CNQ3uT/lB/Nrq+o50fXk+YMMyiJKWcy+WKydNqyS/7rSpJmCGvSDPywxXNQPlD77UBeEQ==
X-Received: by 2002:a0c:e1d3:0:b0:63d:281d:d9cc with SMTP id v19-20020a0ce1d3000000b0063d281dd9ccmr3095378qvl.60.1692214784812;
        Wed, 16 Aug 2023 12:39:44 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:6eb])
        by smtp.gmail.com with ESMTPSA id v15-20020ae9e30f000000b0076ce061f44dsm4626702qkf.25.2023.08.16.12.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:39:44 -0700 (PDT)
Date: Wed, 16 Aug 2023 14:39:42 -0500
From: David Vernet <void@manifault.com>
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add CO-RE relocs kfunc
 flavors tests
Message-ID: <20230816193942.GB1295964@maniforge>
References: <20230816165813.3718580-1-davemarchevsky@fb.com>
 <20230816165813.3718580-2-davemarchevsky@fb.com>
 <20230816174455.GB814797@maniforge>
 <2ce292e0-f9e5-b1ea-0de3-735670139cb9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce292e0-f9e5-b1ea-0de3-735670139cb9@linux.dev>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 03:10:23PM -0400, David Marchevsky wrote:
> On 8/16/23 1:44 PM, David Vernet wrote:
> > On Wed, Aug 16, 2023 at 09:58:13AM -0700, Dave Marchevsky wrote:
> >> This patch adds selftests that exercise kfunc flavor relocation
> >> functionality added in the previous patch. The actual kfunc defined in
> >> kernel/bpf/helpers.c is
> >>
> >>   struct task_struct *bpf_task_acquire(struct task_struct *p)
> >>
> >> The following relocation behaviors are checked:
> >>
> >>   struct task_struct *bpf_task_acquire___one(struct task_struct *name)
> >>     * Should succeed despite differing param name
> >>
> >>   struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ctx)
> >>     * Should fail because there is no two-param bpf_task_acquire
> >>
> >>   struct task_struct *bpf_task_acquire___three(void *ctx)
> >>     * Should fail because, despite vmlinux's bpf_task_acquire having one param,
> >>       the types don't match
> >>
> >> Changelog:
> >> v1 -> v2: https://lore.kernel.org/bpf/20230811201346.3240403-2-davemarchevsky@fb.com/
> >>   * Change comment on bpf_task_acquire___two to more accurately reflect
> >>     that it fails in same codepath as bpf_task_acquire___three, and to
> >>     not mention dead code elimination as thats an implementation detail
> >>     (Yonghong)
> >>
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >> ---
> >>  .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
> >>  .../selftests/bpf/progs/task_kfunc_success.c  | 37 +++++++++++++++++++
> >>  2 files changed, 38 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> >> index 740d5f644b40..99abb0350154 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> >> @@ -79,6 +79,7 @@ static const char * const success_tests[] = {
> >>  	"test_task_from_pid_current",
> >>  	"test_task_from_pid_invalid",
> >>  	"task_kfunc_acquire_trusted_walked",
> >> +	"test_task_kfunc_flavor_relo",
> >>  };
> >>  
> >>  void test_task_kfunc(void)
> >> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> >> index b09371bba204..ffbe3ff72639 100644
> >> --- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> >> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> > 
> > Do you think it's worth it to also add a failure case for if there's no
> > correct bpf_taks_acquire___one(), to verify e.g. that we can't resolve
> > bpf_task_acquire___three(void *ctx) __ksym __weak?
> > 
> 
> IIUC you're asking about whether it's possible to fail loading the program
> entirely if _none_ of the three variants resolve successfully? If so, I
> sent out a response to another email in this round of your comments that should
> address it.

Sorry, that was unclear in the way I worded it. I understand that the
program will still load if none of the variants resolve succesfully. I
was asking whether we should add a test that verifies that the wrong
variant won't be resolved if a correct one isn't present. Maybe that's
overkill? Seems prudent to add just in case, though. Something like
this:

SEC("tp_btf/task_newtask")
int BPF_PROG(test_task_kfunc_flavor_relo_not_found,
	     struct task_struct *task, u64 clone_flags)
{
	/* Neither symbol should resolve successfully. */
        if (bpf_ksym_exists(bpf_task_acquire___two))
                err = 1;
        else if (bpf_ksym_exists(bpf_task_acquire___three))
                err = 2;
	
	return 0;
}

> 
> >> @@ -18,6 +18,13 @@ int err, pid;
> >>   */
> >>  
> >>  struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
> >> +
> >> +struct task_struct *bpf_task_acquire___one(struct task_struct *task) __ksym __weak;
> >> +/* The two-param bpf_task_acquire doesn't exist */
> >> +struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ctx) __ksym __weak;
> >> +/* Incorrect type for first param */
> >> +struct task_struct *bpf_task_acquire___three(void *ctx) __ksym __weak;
> >> +
> >>  void invalid_kfunc(void) __ksym __weak;
> >>  void bpf_testmod_test_mod_kfunc(int i) __ksym __weak;
> >>  
> >> @@ -55,6 +62,36 @@ static int test_acquire_release(struct task_struct *task)
> >>  	return 0;
> >>  }
> >>  
> >> +SEC("tp_btf/task_newtask")
> >> +int BPF_PROG(test_task_kfunc_flavor_relo, struct task_struct *task, u64 clone_flags)
> >> +{
> >> +	struct task_struct *acquired = NULL;
> >> +	int fake_ctx = 42;
> >> +
> >> +	if (bpf_ksym_exists(bpf_task_acquire___one)) {
> >> +		acquired = bpf_task_acquire___one(task);
> >> +	} else if (bpf_ksym_exists(bpf_task_acquire___two)) {
> >> +		/* Here, bpf_object__resolve_ksym_func_btf_id's find_ksym_btf_id
> >> +		 * call will find vmlinux's bpf_task_acquire, but subsequent
> >> +		 * bpf_core_types_are_compat will fail
> >> +		 */
> >> +		acquired = bpf_task_acquire___two(task, &fake_ctx);
> >> +		err = 3;
> >> +		return 0;
> >> +	} else if (bpf_ksym_exists(bpf_task_acquire___three)) {
> >> +		/* bpf_core_types_are_compat will fail similarly to above case */
> >> +		acquired = bpf_task_acquire___three(&fake_ctx);
> >> +		err = 4;
> >> +		return 0;
> >> +	}
> >> +
> >> +	if (acquired)
> >> +		bpf_task_release(acquired);
> > 
> > Might be slightly simpler to do the release + return immediately in the
> > bpf_task_acquire___one branch, and then to just do the following here
> > without the if / else:
> > 
> > err = 5;
> > return 0;
> > 
> > What do you think?
> > 
> 
> Eh, I like this form more because it's easier to visually distinguish that the
> bpf_task_acquire___one case above is not a 'failure' case and should
> successfully resolve, whereas the other two bail out early.
> 
> >> +	else
> >> +		err = 5;
> >> +	return 0;
> >> +}
> >> +
> >>  SEC("tp_btf/task_newtask")
> >>  int BPF_PROG(test_task_acquire_release_argument, struct task_struct *task, u64 clone_flags)
> >>  {
> >> -- 
> >> 2.34.1
> >>
> >>

