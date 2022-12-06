Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2E644E18
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 22:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiLFVmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 16:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFVmH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 16:42:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F319FF5
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 13:42:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so16070373pjo.3
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 13:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IThyXVWQL04WcybIsJ2Ce/hS3UgFy+Ge/JU2XKYhTPk=;
        b=bK+Ig6GjnbvK4GAZ+1I83duQIxgIx6dMee2Jy0Iov7Lh2dzvFU3axc196oKmxZ4+nl
         ZkkR8ia0eIy5orQgfWytWPf/Z+/Q/JPDgZXUZd8Pz7Trlr8rm+k5Zj4h2hv8+3STYM+p
         WjhZ1k21soeZoij4t2GXAGtXInBZo6glYJoDYHyvlJTE7zFiG2JhpFKdIx+B1D5Eprdd
         B4QR2/3MJBlJ6wvUZ9wGv2rcnOmpwKbUCJ40MMxIrk901po8kxztDIsfzN7Eke3ScbN5
         P39yG97bFkZIG1QUAYYQCRLdQq6nf8o6i/AkDUxtBNkTR9XcOHYyYzsGKBHwDvXWNksB
         yr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IThyXVWQL04WcybIsJ2Ce/hS3UgFy+Ge/JU2XKYhTPk=;
        b=HS8lq72L0UCIuVwneuEgd4fqhBTPwUrGebrclavzOzrKInYQeqGfuDDfXGGhqQGnAH
         qi3fIUV/JRbIHxoRwEIZju/uktrxnRhVtMnvBLc5QVlk6Z6dJyOPrbFevyS8wjy3Ngqs
         Pg6xJ7XmVc7uWIkE/u1E6ayczODGx8/MPdZixLxo0lo1EiyZjh4SKSRkG/qlVfEcA2Rn
         joyBK0HZKq5GYnBJSrY4gNdadrPhEOhfFPv8yL3E9hV4YIH3rMZ5riolwuKgr9tPpYPv
         gRXVpM3y5nB6BX4PgaIYzdhXA7PQcFXzjcm9GNBkMn4F0Dde4mjmqzi/iquzP53Kdq3L
         JlCQ==
X-Gm-Message-State: ANoB5pkHj0SyQAHD6ajli3h2emKah0W3E8ZjsngB9+7hfpzX6iEz4Rg+
        JpFBdHOdY938XNAPCZdyOCM=
X-Google-Smtp-Source: AA0mqf6HtBDr8yeqFYneCR9aRC8wYh9hv7kL4Rp+GILT4ZOqVGU0QLnff24tYCFhkcD/sxf2+9FwYw==
X-Received: by 2002:a17:903:230d:b0:189:69cf:9e9d with SMTP id d13-20020a170903230d00b0018969cf9e9dmr56860305plh.43.1670362925775;
        Tue, 06 Dec 2022 13:42:05 -0800 (PST)
Received: from localhost ([129.95.247.247])
        by smtp.gmail.com with ESMTPSA id d9-20020aa797a9000000b00576489088c7sm6485747pfq.37.2022.12.06.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:42:05 -0800 (PST)
Date:   Tue, 06 Dec 2022 13:42:03 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <638fb72bec402_8a9120872@john.notmuch>
In-Reply-To: <20221202051030.3100390-2-andrii@kernel.org>
References: <20221202051030.3100390-1-andrii@kernel.org>
 <20221202051030.3100390-2-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 1/3] bpf: decouple prune and jump points
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> BPF verifier marks some instructions as prune points. Currently these
> prune points serve two purposes.
> 
> It's a point where verifier tries to find previously verified state and
> check current state's equivalence to short circuit verification for
> current code path.
> 
> But also currently it's a point where jump history, used for precision
> backtracking, is updated. This is done so that non-linear flow of
> execution could be properly backtracked.
> 
> Such coupling is coincidental and unnecessary. Some prune points are not
> part of some non-linear jump path, so don't need update of jump history.
> On the other hand, not all instructions which have to be recorded in
> jump history necessarily are good prune points.
> 
> This patch splits prune and jump points into independent flags.
> Currently all prune points are marked as jump points to minimize amount
> of changes in this patch, but next patch will perform some optimization
> of prune vs jmp point placement.
> 
> No functional changes are intended.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: John Fastabend <john.fastabend@gmail.com>

> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/verifier.c        | 57 +++++++++++++++++++++++++++---------
>  2 files changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b5090e89cb3f..9870d1d0df01 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -452,6 +452,7 @@ struct bpf_insn_aux_data {
>  	/* below fields are initialized once */
>  	unsigned int orig_idx; /* original instruction index */
>  	bool prune_point;
> +	bool jmp_point;

Random thought we might want to make these flags in the future so you
can have,

   type = BPF_PRUNE_POINT | BPF_JMP_POINT | BPF_ITERATOR_POINT

and so on without a bunch of bools.

>  };
>  
