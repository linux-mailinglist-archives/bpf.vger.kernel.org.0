Return-Path: <bpf+bounces-5938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F247635DF
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD1A281E18
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC62C132;
	Wed, 26 Jul 2023 12:08:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8289C12D
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 12:08:26 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BBB1739
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 05:08:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bcfe28909so13682966b.3
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690373303; x=1690978103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J8f8xfrf9CO1UwpWhwva0oZFFF0z+1JGQgE5+04wLko=;
        b=7JuuMn+MBz5hYgANnpD4bEvks7OS3SHktyfwoRDMJGaRJlR3i5MAAhEZmypTHWIyuU
         btCWNmq9Pv4hGz6MJnqT3RauPr/grcWGwTB97C6LgE8o9CtC2Y21vI9abDbmnyujE3B1
         SKSpzgGkPEygRPQL2ui5iDwCvJf1pkbNHd6P3Id6TJx4JZNE7Nud8vnGeUaNqyo3JyCk
         /ZFQy6M1+WbOk/TQ3KyIHuXV9luoiFEHsx0HgDqJfy/DpzF+mOAcqlG9+LGe4B+F9Ibk
         /pdicgMTjiM1I4r4q0huPczbjkFjt6LeDFcFoxmPkfcH8Ae2whA8RGg8k3WF9greqpmJ
         SO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373303; x=1690978103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8f8xfrf9CO1UwpWhwva0oZFFF0z+1JGQgE5+04wLko=;
        b=QnFGfZnLZynid14GhklFAG2arKrMuzejj8I43FDh9ePWibOa4qwnijLIBPhbXvPC8G
         GS6NXo6ZLve0Vly1m5FrbFeIxOmJ9m1QrROxu15TKFGGYJxvuRMGElqpLRmi6MXcxHgd
         kHy4xXhqRkcmiLKjT7RjUeLW7MwNdPuuc8H2LpU2mX6JXTFv+bB8jyC6IU+WPfmQXm1S
         0ruzAhsbqNmItXo8muDgS/M4b0Mohcr5MYaohwdS8THuAru0ik9f7FpIg4oVCfCIlqQ4
         xZoXc1c3ALMeRfqftzzIzHgBeAfoJtWUD+WCeDJsdawsQrK1x7tySiVMLZZa4wMznzuV
         DZIA==
X-Gm-Message-State: ABy/qLZKBjjRzR9eDaQM6/N6taCDfEATBLeA2rV5Q/kNeArR17AtDpuS
	ubpudwX3ic6mrFltC9liDnJL0A==
X-Google-Smtp-Source: APBJJlFfOkPz2EQQoFKz5CJOLmVEaFKbVA+ian4eCyKk+BO4Er+9/WwSwumtYgFBv5QV1xjXsi5Nrg==
X-Received: by 2002:a17:906:7690:b0:982:487c:7508 with SMTP id o16-20020a170906769000b00982487c7508mr1508512ejm.38.1690373302686;
        Wed, 26 Jul 2023 05:08:22 -0700 (PDT)
Received: from google.com (107.187.32.34.bc.googleusercontent.com. [34.32.187.107])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906960800b0099316c56db9sm9438817ejx.127.2023.07.26.05.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:08:22 -0700 (PDT)
Date: Wed, 26 Jul 2023 12:08:17 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 0/4] bpf: Add detection of kfuncs.
Message-ID: <ZMEMseIyJH9ctdKA@google.com>
References: <20230317201920.62030-1-alexei.starovoitov@gmail.com>
 <ZMA0SFhEDRp0UFGc@google.com>
 <CAADnVQLkB4dkdje5hq9ZLW0fgiDhEWU0DW67zRtJzLOKTRGhbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLkB4dkdje5hq9ZLW0fgiDhEWU0DW67zRtJzLOKTRGhbQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 02:00:40PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 25, 2023 at 1:45 PM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > Hey Alexei/Andrii,
> >
> > On Fri, Mar 17, 2023 at 01:19:16PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Allow BPF programs detect at load time whether particular kfunc exists.
> >
> > So, I'm running a GCC built 6.3.7 Linux kernel and I'm attempting to
> > detect whether a specific kfunc i.e. bpf_rcu_read_lock/unlock() exists
> > using the bpf_ksym_exists() macro. However, I'm running into several
> > BPF verifier constraints that I'm not entirely sure how to work around
> > on the aforementioned Linux kernel version, and hence why I'm reaching
> > out for some guidance.
> >
> > The first BPF verifier constraint that I'm running into is that prior
> > to commit 58aa2afbb1e6 ("bpf: Allow ld_imm64 instruction to point to
> > kfunc"), it seems that the ld_imm64 instruction with BPF_PSEUDO_BTF_ID
> > can only hold a ksym address for the kind KIND_VAR. However, when
> > attempting to use the kfuncs bpf_rcu_read_lock/unlock() from a BPF
> > program, the kind associated with the BPF_PSEUDO_BTF_ID is actually
> > KIND_FUNC, and therefore trips over this BPF verifier.
> >
> > The code within the example BPF program is along the lines of the
> > following:
> > ```
> > ...
> > void bpf_rcu_read_lock(void) __ksym __weak;
> > void bpf_rcu_read_unlock(void) __ksym __weak;
> > ...
> > if (bpf_ksym_exists(bpf_rcu_read_lock)) {
> >    bpf_rcu_read_lock();
> > }
> > ...
> > if (bpf_ksym_exists(bpf_rcu_read_unlock)) {
> >    bpf_rcu_read_unlock();
> > }
> > ...
> > ```
> >
> > The BPF verifier error message that is generated on a 6.3.7 Linux
> > kernel when attempting to load a BPF program that makes use of the
> > above approach is as follows:
> >    * "pseudo btf_id {BTF_ID} in ldimm64 isn't KIND_VAR"
> >
> > The second BPF verifier constraint comes from attempting to work
> > around the first BPF verifier constraint that I've mentioned
> > above. This is trivially by dropping the conditionals that contain the
> > bpf_ksym_exists() check and unconditionally calling the kfuncs
> > bpf_rcu_read_lock/unlock().
> >
> > The code within the example BPF program is along the lines of the
> > following:
> > ```
> > ...
> > void bpf_rcu_read_lock(void) __ksym __weak;
> > void bpf_rcu_read_unlock(void) __ksym __weak;
> > ...
> > bpf_rcu_read_lock();
> > ...
> > bpf_rcu_read_unlock();
> > ...
> > ```
> >
> > However, in this case the BPF verifier error message that is generated
> > on a 6.3.7 Linux kernel is as follows:
> >    * "no vmlinux btf rcu tag support for kfunc bpf_rcu_read_lock"
> >
> > This approach would be suboptimal anyway as the BPF program would fail
> > to load on older Linux kernels complaining that the kfunc is
> > referenced but couldn't be resolved.
> >
> > Having said this, what's the best way to resolve this on a 6.3.7 Linux
> > kernel? The first BPF program I mentioned above making use of the
> > bpf_ksym_exists() macro works on a 6.4 Linux kernel with commit
> > 58aa2afbb1e6 ("bpf: Allow ld_imm64 instruction to point to kfunc")
> > applied. Also, the first BPF program I mentioned above works on a
> > 6.1.* Linux kernel...
> 
> Backport of that commit to 6.3.x is probably the only way.

Ah, that's very unfortunate. Should we consider sending this patch
series to linux-stable so that it can be considered for 6.3.x?

/M

