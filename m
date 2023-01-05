Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B565E337
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 04:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjAEDGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 22:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjAEDGN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 22:06:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E62F785
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 19:06:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v23so38491427pju.3
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9Tuo0qNTyZgf1ATED4aKR2Ttfe1T7uwRLEUwK2gh+Q=;
        b=nZTHEtPvYXJTy8WOQcCmlBEDlbd96E/VUeSby9I3NwG4nmM4DNVKPpk1jmgXASPuNw
         4rJWf/JJiVgW+DkwOkfP1mdOnJOH6m+DI+wv/VwaL3/5di4yBmaz6QyjOBh1t296Vayq
         hnsAecr/IBBEq2/kBVFEPWHM1fIOwcMz6H8tOzEZXh9KhcmEz50xNw9XriRwCWjEa8Zd
         AEeuM9jxfSFO1kmiTpQuNa4lxuUofhLTZ7Ue2ncp//+C6pARwtMSrrf0otPGQbSeKvUt
         WgHK6+vra+DUfW6o38POin2ks7ShzzrMjPdS8zxOSx8koyd5jXpdDy63ijaMHIOrPdSv
         CR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9Tuo0qNTyZgf1ATED4aKR2Ttfe1T7uwRLEUwK2gh+Q=;
        b=xBkTeo7Z0ZfcrtfJBY0oVxfPdpK2MR6WkmTLA97+5CTnFCp2XNAmAmks7flYUuc8lX
         v1SgG9v1tugp1nI0qklsYOy4Nwi5QamDo/U+q225x8suHSTWIGjI3mf45ADh9xvXIliy
         5dOz58gks8MVqNs4LlpFUzUEwpiqAlAllrX/kHEbShHzFQ+xLp7KVhFqGNIjsjFsv0Oq
         0CzMvlDC1CnGnJXxqO1+/OUmCxkKjQnGLBpa+CCW/l+KH0CC71w00MjUiE9HwQ1pbGAr
         Ouqt4HEtMkL0C9Ttu3mNk2k+Jh2jT+U4YHlgCT03ljtR4lQL22pwt/6FluK3gDaMlVLs
         8Q3Q==
X-Gm-Message-State: AFqh2kpArwtF+B1BdUpB3Ac9bHq1JLJW4BWdXwp5wdmJGU7yFzxdrqoL
        Dkm/P7qq+u9eECXobC1pZtG5Vtj9a0s=
X-Google-Smtp-Source: AMrXdXsL0z+ZsVUQzdeRkOF9Dc1xM0Qu0XupBurijaXUqtTyAAlwfteITQ3SmG01RLbOHUmFkELm0Q==
X-Received: by 2002:a17:902:ccce:b0:189:e577:c83e with SMTP id z14-20020a170902ccce00b00189e577c83emr60418950ple.36.1672887971704;
        Wed, 04 Jan 2023 19:06:11 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b0018913417ba2sm22339207pln.130.2023.01.04.19.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 19:06:10 -0800 (PST)
Date:   Wed, 4 Jan 2023 19:06:07 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Fix partial dynptr stack slot
 reads/writes
Message-ID: <20230105030607.hnaxgzejx4uwpby5@macbook-pro-6.dhcp.thefacebook.com>
References: <20230101083403.332783-1-memxor@gmail.com>
 <20230101083403.332783-4-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101083403.332783-4-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 01, 2023 at 02:03:57PM +0530, Kumar Kartikeya Dwivedi wrote:
> Currently, while reads are disallowed for dynptr stack slots, writes are
> not. Reads don't work from both direct access and helpers, while writes
> do work in both cases, but have the effect of overwriting the slot_type.

Unrelated to this patch set, but disallowing reads from dynptr slots
seems like unnecessary restriction.
We allow reads from spilled slots and conceptually dynptr slots should
fall in is_spilled_reg() category in check_stack_read_*().

We already can do:
d = bpf_rdonly_cast(dynptr, bpf_core_type_id_kernel(struct bpf_dynptr_kern))
d->size;
and there is really no need to add bpf_dynptr* accessors either as helpers or as kfuncs.
All accessors can simply be 'static inline' pure bpf functions in bpf_helpers.h.
Automatic inlining and zero kernel side maintenance.

With verifier allowing reads into dynptr we can also enable bpf_cast_to_kern_ctx()
to convert struct bpf_dynptr to struct bpf_dynptr_kern and enable
even faster reads.
