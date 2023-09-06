Return-Path: <bpf+bounces-9303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E117932EB
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6863281213
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BEB634;
	Wed,  6 Sep 2023 00:37:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04262B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 00:37:52 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B7199
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 17:37:51 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so2643817fac.0
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 17:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693960670; x=1694565470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UL3LP0CDawDmJXmHRXETuCcemt9X5dmnfgWDk+vFqtg=;
        b=r/kLGgjrCuRLvbdvi2019FLLXcfxANfF3I0XMOi9g3QvMFlC7eVNAHqg0oZ2owT7TD
         WkIa/70aZ9shmX+zgEgDP/uV38jWMLqhCDrdhkmQlQSdz1NLYsn1FpGS7PM1KfKoRI9S
         u3Ddgpk6h9ZX/zQrRfhlnX63KNxPFKuAbU4mZ+LjvH25fpqEDco2IwQcUJj1IFI94kxu
         z9tTFo8xKayxRKu1kWbHPwlEFHy/72HsC/t4+vxYqKfDIhWHoqJ23JZFBu3HmjtdM/hy
         lXr2MqclazyMRamRGVTociGbLxLEHqjGqM1LKaZj9lfIMgARgtmLViJ9jgEJsNfQTDzV
         mPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693960670; x=1694565470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL3LP0CDawDmJXmHRXETuCcemt9X5dmnfgWDk+vFqtg=;
        b=hpQ9NoLWFxQrEEMYC578lI8viyieIA952w8gUH+KK+V0iIzcDxOwQd7IUBU6aKrN4+
         tZ/aWHDty8T0dAPX+nJq1P4w2Ev15s7KR4FY64SU/rGpgon+MgIrWGKKqF4SvBcXQVRr
         AqLt4w5JyU5Og/VOP7zSyd1lbGl6GjW3830bpoKulgT6/KrKaYgBhBJ6H+IQwBLtP2k8
         l69IlMidYkvEXZxmBtiXbk9BTRuCJy5ZJRb93Z7emFJ2dwobJ4s9DJnLpWTgYgKffM3C
         PPQoZizu2ZPIvw6xUjF3pAk0YdFjzXzcOFNA7QS5fbAWzl9LZ0zBAjz4rXxVA9ria7FY
         +7GA==
X-Gm-Message-State: AOJu0Yzovi4V8B6VSp/bOACuMu7IsVKmPxGA91vbx1VyrhGIDAMsnDKf
	Nzbw6KmBKumlTryVCJxvETs=
X-Google-Smtp-Source: AGHT+IHD21gypIZAJTG2JgGL5rIE2kUwi8Ra/cHZud9irrvPKMfAOvFpjXhcCAgYUkzXU6D26xtiqQ==
X-Received: by 2002:a05:6358:93a6:b0:134:cbff:c5a4 with SMTP id h38-20020a05635893a600b00134cbffc5a4mr1565838rwb.18.1693960670238;
        Tue, 05 Sep 2023 17:37:50 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:d4aa])
        by smtp.gmail.com with ESMTPSA id dw24-20020a17090b095800b00265c742a262sm9797065pjb.4.2023.09.05.17.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 17:37:49 -0700 (PDT)
Date: Tue, 5 Sep 2023 17:37:47 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: Mark OBJ_RELEASE argument as
 MEM_RCU when possible
Message-ID: <20230906003747.xcdmin6s5ct4c7j2@MacBook-Pro-8.local>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152816.2000760-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827152816.2000760-1-yonghong.song@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 27, 2023 at 08:28:16AM -0700, Yonghong Song wrote:
> In previous selftests/bpf patch, we have
>   p = bpf_percpu_obj_new(struct val_t);
>   if (!p)
>           goto out;
> 
>   p1 = bpf_kptr_xchg(&e->pc, p);
>   if (p1) {
>           /* race condition */
>           bpf_percpu_obj_drop(p1);
>   }
> 
>   p = e->pc;
>   if (!p)
>           goto out;
> 
> After bpf_kptr_xchg(), we need to re-read e->pc into 'p'.
> This is due to that the second argument of bpf_kptr_xchg() is marked
> OBJ_RELEASE and it will be marked as invalid after the call.
> So after bpf_kptr_xchg(), 'p' is an unknown scalar,
> and the bpf program needs to reread from the map value.
> 
> This patch checks if the 'p' has type MEM_ALLOC and MEM_PERCPU,
> and if 'p' is RCU protected. If this is the case, 'p' can be marked
> as MEM_RCU. MEM_ALLOC needs to be removed since 'p' is not
> an owning reference any more. Such a change makes re-read
> from the map value unnecessary.
> 
> Note that re-reading 'e->pc' after bpf_kptr_xchg() might get
> a different value from 'p' if immediately before 'p = e->pc',
> another cpu may do another bpf_kptr_xchg() and swap in another value
> into 'e->pc'. If this is the case, then 'p = e->pc' may
> get either 'p' or another value, and race condition already exists.
> So removing direct re-reading seems fine too.
...
> +		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj_id) {
> +			u32 ref_obj_id = meta.ref_obj_id;
> +			bool in_rcu = in_rcu_cs(env);
> +			struct bpf_func_state *state;
> +			struct bpf_reg_state *reg;
> +
> +			err = release_reference_state(cur_func(env), ref_obj_id);
> +			if (!err) {
> +				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> +					if (reg->ref_obj_id == ref_obj_id) {
> +						if (in_rcu && (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
> +							reg->ref_obj_id = 0;
> +							reg->type &= ~MEM_ALLOC;
> +							reg->type |= MEM_RCU;
> +						} else {
> +							mark_reg_invalid(env, reg);
> +						}
> +					}
> +				}));
> +			}
>  		} else if (meta.ref_obj_id) {
>  			err = release_reference(env, meta.ref_obj_id);

I think this open coded version of release_reference() can be safely folded into release_reference().
If it's safe to do for kptr_xchg() then it's safe to do for all KF_RELEASE kfuncs too
that call release_reference().
bpf_percpu_obj_drop() is the only such kfunc and converting its arg1
from MEM_ALLOC | MEM_PERCPU to MEM_RCU | MEM_PERCPU should be equally valid,
since bpf_percpu_obj_drop() is doing bpf_mem_free_rcu.

I'm planning to apply the whole set. Above nit can be a follow up.

