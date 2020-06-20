Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB72021CC
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 08:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgFTGEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 02:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgFTGEw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 02:04:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEDCC06174E
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 23:04:51 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y5so13702068iob.12
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Y/tGRAMZ13s3vYUb6hbdRvpajhhqrYoN7qhO7d0pY3k=;
        b=Z6pyXhzj9V8Ru9YpSRR1n+ah0l6LNz0n8r7CIYiXkkOkVDDsS1LMs/r7lS0dEEKC6q
         jQPWBx69JJru/SwYagA4DmmfNRArRv0KEh+TIpiGhOSat0JzrPXi3+jKqIOY+BgbctZA
         s0muLSfsaL9R7w/I2Q+JEux3ly/mcTl3MQsDuj5o7YjeXJQ6oxOaCa3Y1VOZIssTE1Zb
         i6h6W623ouAfLw9/358DBqeGaKqjRwQPYkfOUmIa6Lm+pKPyedqRwfn0R9Xm6rrP9YVB
         /apek/WnN9MuBXw+194F1w5TgnOU6iIIQrIXWUnEB3PlXz3YPIU2vCwYtPd6XGIUzgaR
         g0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Y/tGRAMZ13s3vYUb6hbdRvpajhhqrYoN7qhO7d0pY3k=;
        b=tkGowVuGVBaFvX7RBxvZJmSIELeBW9z14oTCUPd14qPxu8SC/yvMWBw2M2CWuydofl
         1bYwwOCh7uUn8V+jd2ouGkRe7U0QAum9onuPY2hH5SLWVZNCCNCq9hljqPisPPZMaIDw
         Gvlm2to2J5Jriz1A7NSlrkIZppbkTpq0S5MAhS14C37cA6c/fYP7+TVQtRGequB65XEP
         q5l+ukoDfZYBeetWfvA29Ffw8LdIsBCCPOdZyyFvpzG9dTxYNNpiZ9hvCwnydwVnt+U5
         FkkclW+ObRPZi2otedGUKm2DOcGiEoNAZAQnMrBPXeZEkZaDvtxM+4DP7lhGVcOEK6mN
         XN4w==
X-Gm-Message-State: AOAM531lt/hdWE5qa5O5bQJsFak6ayeB13UipI6P0NP8B98HkFw7akAi
        CqZpkGuXk13KL8L924IkvsA=
X-Google-Smtp-Source: ABdhPJwO8E09QuDrLmO2Ri3ICHAlOBBXHAHH1BtV3/NY01UfvXTJ6yLlWmJtttD5hZXrgjTC5b0UbA==
X-Received: by 2002:a02:94e6:: with SMTP id x93mr7208688jah.116.1592633091099;
        Fri, 19 Jun 2020 23:04:51 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id v14sm4622577ioj.46.2020.06.19.23.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 23:04:50 -0700 (PDT)
Date:   Fri, 19 Jun 2020 23:04:41 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, andriin@fb.com, kernel-team@fb.com
Message-ID: <5eeda6f98d9e8_38742acbd4fa45b8ab@john-XPS-13-9370.notmuch>
In-Reply-To: <6e12d5c3e8a3d552925913ef73a695dd1bb27800.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
 <6e12d5c3e8a3d552925913ef73a695dd1bb27800.1592600985.git.rdna@fb.com>
Subject: RE: [PATCH v2 bpf-next 1/5] bpf: Switch btf_parse_vmlinux to
 btf_find_by_name_kind
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov wrote:
> btf_parse_vmlinux() implements manual search for struct bpf_ctx_convert
> since at the time of implementing btf_find_by_name_kind() was not
> available.
> 
> Later btf_find_by_name_kind() was introduced in 27ae7997a661 ("bpf:
> Introduce BPF_PROG_TYPE_STRUCT_OPS"). It provides similar search
> functionality and can be leveraged in btf_parse_vmlinux(). Do it.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
