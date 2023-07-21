Return-Path: <bpf+bounces-5639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07575CFF2
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149FA2823A9
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42951200A6;
	Fri, 21 Jul 2023 16:44:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7081F95D
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:44:38 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF9410D2
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:44:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so3544593e87.1
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689957867; x=1690562667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+hV6rPMPUv6F82jG5/xUfsEjOSTmnFM3wV0sLGfEds=;
        b=kKD+nvRWXEu2R0ltxvuh0wuxGilOwbbO0GdgSoG7ldPs9Y4OHRtM22Fj9B6FeXPB69
         nTIwvl6a741lcLNwbTCC/vejSezuhHCqBvHeZRIS1+EgRtoiiiS//5NoWjGbEO0qfWhn
         83NBbDggk+LJUf9adPUCmkfGnsHq0Kpp+74DO2aErIjBsgM2ny94n//Y0m00I8WJ/0ra
         7K0UVt9ZsDza2TBAUwS0OCRf3Wzu0du7jSMN33CcIGb2NGzcofeWYUQ5yp44tMIO3w+S
         3v33yESmjD9Poh70exXFZ4bWqhu1WRTF/ccHBKq8l9eYS3BIMSiBbixIsXN8pKsAZJo8
         0QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689957867; x=1690562667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+hV6rPMPUv6F82jG5/xUfsEjOSTmnFM3wV0sLGfEds=;
        b=Z3GRwhQs6iLiplNJgnvPr2XZ7G2Q5XciqSxZOlT1a80pppwfTzkF/WyJuSjblexAvH
         RRl3UWVqcG9zdBAi4nNIuJ5Z8iq/PJT86mgmPqlDdxxjTWtkU3Eyx3TE9hMUcZIKF9Ts
         DzPBlWPEoyfn0O4zGxChZN1Q+AsPDsLiF6fGxhdwKa7R3ZgIGp4S/P4X5+kb7s3BCV/W
         lOfB/rXgW+79aEkQw5LCOTXpy8qD372Ovv8EjyDwzqLLKRIRz5+XzI+K65a/I2vQo02O
         y7GHqJXkn5o1hEuZVsxezimreDQ0YmJZjTRwUnzLesxs1YGFZvi2E2+gxx0ZXaAmyK8h
         kMJQ==
X-Gm-Message-State: ABy/qLZoiA7+0LAGuqcdRWrCEGCX3KDnZ3N/VUQA6IQ5r4avMyC1PBKP
	8KaUh0KxnthfLzFv4YNgl8x5SXe1awsx71c+JkLzzA==
X-Google-Smtp-Source: APBJJlH9IeFeV3NXadMuPzTBbEjqGtn9uW+AL4r6k87fi1UpAfCBxmYVBbqawTkO36F8KIcL7fDZYg==
X-Received: by 2002:a05:6512:b96:b0:4fd:c23b:959d with SMTP id b22-20020a0565120b9600b004fdc23b959dmr2617454lfv.34.1689957866627;
        Fri, 21 Jul 2023 09:44:26 -0700 (PDT)
Received: from google.com (107.187.32.34.bc.googleusercontent.com. [34.32.187.107])
        by smtp.gmail.com with ESMTPSA id o23-20020aa7dd57000000b0051e0cb4692esm2297118edw.17.2023.07.21.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:44:26 -0700 (PDT)
Date: Fri, 21 Jul 2023 16:44:22 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, memxor@gmail.com
Subject: Re: BPF/Question: PTR_TRUSTED vs PTR_UNTRUSTED
Message-ID: <ZLq15qZWLhHzXJli@google.com>
References: <ZIl0+n1Q5yn2r5vL@google.com>
 <20230615174033.GA2915572@maniforge>
 <ZLlEt0J+O7XqnQFb@google.com>
 <20230720151622.GA52260@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720151622.GA52260@maniforge>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:16:22AM -0500, David Vernet wrote:
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index fa43dc8e85b9..8b8ccde342f9 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -5857,6 +5857,7 @@ BTF_TYPE_SAFE_RCU(struct task_struct) {
> > >         struct css_set __rcu *cgroups;
> > >         struct task_struct __rcu *real_parent;
> > >         struct task_struct *group_leader;
> > > + struct fs_struct *fs;
> > >  };
> > 
> > Oh, right. So, if we explicitly dereference the struct fs_struct
> > member of struct task_struct within a RCU read-side critical section,
> > the BPF verifier considers the pointer to struct fs_struct as being
> > safe and trusted. Is that right?
> 
> With the above patch, yes.

After conducting some further tests today, it turns out that making
amendments to the struct task_struct BTF_TYPE_SAFE_RCU definition
perhaps isn't actually necessary? As of commit afeebf9f57a49 ("bpf:
Undo strict enforcement for walking untagged fields"), if a trusted
pointer (in this case being struct task_struct obtained via
bpf_get_current_task_btf()) is dereferenced within a RCU read-side
critical section, then the pointer that is yielded as a result of the
walk/dereference operation is a PTR_TO_BTF_ID. It is neither trusted
or untrusted and therefore carries the same level of semantics as a
dereferenced pointer before any trust status for pointers was
introduced within the BPF verifier.

Have I misunderstood something here?

> > Why is it that we need to explicitly add it to such lists so that
> > they're considered to be trusted and cannot simply perform the
> > bpf_rcu_read_lock/unlock() dance from within the BPF program? Also,
> > should we not add the field to BTF_TYPE_SAFE_RCU_OR_NULL() instead of
> > BTF_TYPE_SAFE_RCU(), as struct fs_struct could perhaps be NULL in some
> > circumstances?
> 
> I recommend doing some git log / git blame digging. All of this
> information was captured in prior discussions. For example, in the patch
> [0] which added these structs.
> 
> [0]: https://lore.kernel.org/bpf/20230303041446.3630-7-alexei.starovoitov@gmail.com/
> 
> > Are you OK with me carrying this recommended patch to the mailing
> > list?
> 
> Of course

Based on what I've mentioned above, perhaps sending through a patch no
longer is necessary?

/M

