Return-Path: <bpf+bounces-7945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68D77EEB0
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 03:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC966281A1B
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29209391;
	Thu, 17 Aug 2023 01:25:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067CC379
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:25:22 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BA52723
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:25:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdbbede5d4so49019365ad.2
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692235521; x=1692840321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkJ4quWFUm8pE25VpW61E6HiOTZPWFcdQL7hxgwaZn8=;
        b=LUHul00UrPj5t2esaC3HBOOSwSQJKDqim1hgKPkBBOxOyXNOGftPRb5FSRjJfhc4rU
         a0xRBkOy4XGAmyTF4JaXOwSGOo4NUL1fdH9bXJHbE6+rcZKEb9FgvHbYaGkJZBY69wPx
         ckR+CUF6dRcVlC5qmLeWyyJyLRaIDGHlBpdsvB8JmuL9cPzj4PXc4/a/P/YqJAv+BQVV
         WXbOeqe71DkYBCvQCj+esDNJ5DmFG53HRllleBgg1KnUwGxj5ApvZ4Xtlo+hcQlUQHCM
         nodcsOjuQS32JtUnNH2kAE0Gfbm4XaUIVbZGKJrF9sVpACLwCasKBxNYa5Q9swUS5f45
         BmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692235521; x=1692840321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkJ4quWFUm8pE25VpW61E6HiOTZPWFcdQL7hxgwaZn8=;
        b=Wdko4JsCuLTsUxk03ea+o5ZlwjL1hQiOho+jfRUGQzlMZfcyzbfQFVbwQo4hoVplDN
         lmvRBekFGQxDsuoXc6TTzw0HpsY67IY87ouLia4ooNuBDM8Vu5O5jslouh+FJqRSPACc
         uLEoNMd8qzZlkcAGjtMMI+0DwkgzGDfw8i4zEm/IV1H06l+oYdcOsMVA/nYs/PuxiUpK
         EB9oyajMqXuefoHGVb5KOiK98gmjVCACpcgWROWZ9ESQdlQE3Ca4hmeaHOoi9yDtMevI
         6w1CWfTnMWcW0F7tJZU2+n/crBFtSgFCeV99+8AmvYWgQ+xqzlq4J183Fp/cpmS9AUxj
         Ap+Q==
X-Gm-Message-State: AOJu0YxtBbV1Fvfcjkrs8UQPqmshCmXZ2L0sanSQ6/16CKmBtv+HdESV
	ssDa1kcdA1wikqHCm3DLf8gAQubCg1s=
X-Google-Smtp-Source: AGHT+IHBRHqTwDzgrSLWeVoYjq+b5LsQCs9zYuwLN8gBBmhPSH7+L5VjEebfwWMWgHDNYplXwgg3oQ==
X-Received: by 2002:a17:902:e544:b0:1bc:8249:2533 with SMTP id n4-20020a170902e54400b001bc82492533mr4411773plf.42.1692235521251;
        Wed, 16 Aug 2023 18:25:21 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2000])
        by smtp.gmail.com with ESMTPSA id jf12-20020a170903268c00b001bc56c1a384sm7418371plb.277.2023.08.16.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 18:25:20 -0700 (PDT)
Date: Wed, 16 Aug 2023 18:25:18 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	sdf@google.com, yonghong.song@linux.dev, sinquersw@gmail.com,
	kuifeng@meta.com
Subject: Re: [RFC bpf-next v3 4/5] bpf: Add a new dynptr type for
 CGRUP_SOCKOPT.
Message-ID: <20230817012518.erfkm4tgdm3isnks@MacBook-Pro-8.local>
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-5-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815174712.660956-5-thinker.li@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 10:47:11AM -0700, thinker.li@gmail.com wrote:
>  
> +BTF_SET8_START(cgroup_common_btf_ids)
> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_copy_to, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_alloc, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_install, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_release, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_from, KF_SLEEPABLE)
> +BTF_SET8_END(cgroup_common_btf_ids)

These shouldn't be sockopt specific.
If we want dynptr to represent a pointer to a user contiguous user memory
we should use generic kfunc that do so.

I suspect a single new kfunc: bpf_dynptr_from_user_mem() would do.
New dynptr type can be hidden in the kernel and all existing
kfuncs dynptr_slice, dynptr_data, dynptr_write could be made to work
with user memory.

But I think we have to step back. Why do we need this whole thing in the first place?
_why_ sockopt bpf progs needs to read and write user memory?

Yes there is one page limit, but what is the use case to actually read and write
beyond that? iptables sockopt was mentioned, but I don't think bpf prog can do
anything useful with iptables binary blobs. They are hard enough for kernel to parse.

