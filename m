Return-Path: <bpf+bounces-596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B1470435B
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 04:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5491C20C9F
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FA23C6;
	Tue, 16 May 2023 02:22:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23023A2
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 02:22:36 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C67C30C4
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:22:35 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7595561f2f0so74023585a.2
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684203754; x=1686795754;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKWXYh0P4ws+PILqAEFm7TB7CANAMF4fj5rVWS+JKfs=;
        b=Q9nHA5IAL9JANM5GQgcEa9P6A/Q747QGQJau/10kIlWHF/oG79YFdFPQA1M70CqOeM
         OKjEqV9hhoXp/yAuW4EiMmRBTmEi5FUX+NvesON3zpB/gvPNGxgBV6ksEU+YW3Fdly9D
         aVehXKpPKV5Mjh8ekpZCZQVOglvZs5lG1VbpBAI5ZpYlvRU4Si0vM4OsajbUAkTVFDnt
         PdXY0ctGUYj2kproJMVwwPAq/3fAAMeZUqvFy8XiivrYatk7SHFyXUXdN2rNKAGSB+Lk
         z4/xMzCuoOEBwp+KbVEx8vLuWDnOjcjwCyHj2Rvjes7PA+wE54DpSyiRAJuAhCZ0in6R
         oYMQ==
X-Gm-Message-State: AC+VfDxXZ1TVk5QSNxqSy6SsnIPbQ/Ovv7h7fg5KU+OyTMnWCQiObBHb
	cKhZMjLGkHNdl19SsxSiVLI=
X-Google-Smtp-Source: ACHHUZ79LH6PXsvjKLJiNePkp5a94CKdjGtk/pQt0qfUsLwvYoILZPa1euUD+uQQJsE9R+Vxvf+CvQ==
X-Received: by 2002:a05:6214:5183:b0:623:75d1:fbd0 with SMTP id kl3-20020a056214518300b0062375d1fbd0mr2489098qvb.44.1684203753972;
        Mon, 15 May 2023 19:22:33 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:b147])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a15d500b007579f89c0ccsm275880qkm.29.2023.05.15.19.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 19:22:33 -0700 (PDT)
Date: Mon, 15 May 2023 21:22:30 -0500
From: David Vernet <void@manifault.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCHv4 bpf-next 10/10] bpf: Move kernel test kfuncs to
 bpf_testmod
Message-ID: <20230516022230.GA3834@maniforge>
References: <20230515133756.1658301-1-jolsa@kernel.org>
 <20230515133756.1658301-11-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515133756.1658301-11-jolsa@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 03:37:56PM +0200, Jiri Olsa wrote:
> Moving kernel test kfuncs into bpf_testmod kernel module, and adding
> necessary init calls and BTF IDs records.
> 
> We need to keep following structs in kernel:
>   struct prog_test_ref_kfunc
>   struct prog_test_member (embedded in prog_test_ref_kfunc)
> 
> The reason is because they need to be marked as rcu safe (check test
> prog mark_ref_as_untrusted_or_null) and such objects are being required
> to be defined only in kernel at the moment (see rcu_safe_kptr check
> in kernel).
> 
> We need to keep also dtor functions for both objects in kernel:
>   bpf_kfunc_call_test_release
>   bpf_kfunc_call_memb_release
> 
> We also keep the copy of these struct in bpf_testmod_kfunc.h, because
> other test functions use them. This is unfortunate, but this is just
> temporary solution until we are able to these structs them to bpf_testmod
> completely.
> 
> As suggested by David adding bpf_testmod.ko make dependency for
> bpf programs, so they are rebuilt if we change the bpf_testmod.ko
> module.
> 
> Also adding missing __bpf_kfunc to bpf_kfunc_call_test4 functions.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: David Vernet <void@manifault.com>

