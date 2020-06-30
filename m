Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440E920FBEF
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgF3Snx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3Snx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 14:43:53 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD45C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:43:53 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v6so8443221iob.4
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FtijOVvWXQEmMAcNyk4ApbPVWfKn9kEsv1OMgmFw7rY=;
        b=keakmDDcDnj3Jr9iAzd3NSyLSQO0OExvvkm2FdqF3jYByUZADDFxoD5tBU24ALdk6S
         VEw8GLYct2HG5GgRf279wSbN2mBZyEvCz7qJrpHZEkVlAMgh8wkyGveefA6d8xpVekH+
         6ejIxmNwTLybhRdJSYnAW1po9ni3nlM9PuNW6XCTNfC7IieoV6pjtzLQkyuOkL7k6Udy
         s3KYH7CbWZ2dMu5iJMm4ez1hynycyESm6pSh1oYNcMFUSaHQ/VayvNJLvhpQnGZGFNMk
         uha67IRXdrWAk98gdSRj4kODJZf/gevf03GpVVrXWd/bJn4v/6UO2wirnowLS/rtkm8/
         hN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FtijOVvWXQEmMAcNyk4ApbPVWfKn9kEsv1OMgmFw7rY=;
        b=MKUY22FHdUrgmZP36QPYvrIBfp1nNnv9RFwlBRRnKBGETMeObOPDn9uYSweDSY2DBK
         7jPrIMSmnwRgqyN9UF1qlPP3ufMyVzmEFxrpyS6DmUH57TbFyOeGGD32nL8ckFqUJK95
         oV7MY5RAD7pvNBoiLl/gjEM1IKX7h3hRivcCB+FH94GPxxVVN8Eb70AqM4biJoFezRXj
         ZY7aP5GgZhK1NjbFq3wjs4FI34LYB/86nMgnqJpL9HJ0PJ31L8h2rgspvjD5i9IQ23VN
         dmXeR4bPIPe9wUfTpC7JI73fSqiX5nHCDqo5MXq9nJ3+uSBpeWUy0bUHyg1vb8J0WJl2
         2FUQ==
X-Gm-Message-State: AOAM530Q7JOK28H+eyYapcwEkpFe6yL/4KvWFm1P4o6P5/qWf8aGOAMl
        tBXQIwsEc/RT/CpbwVtqjGo=
X-Google-Smtp-Source: ABdhPJwicgrE2oLXn3FT/ZnIfNzItWcLDVti1ebGctR+SPMX3lurVH2YECUPEsamUNmjfPblc292Hw==
X-Received: by 2002:a6b:9355:: with SMTP id v82mr21683188iod.92.1593542632774;
        Tue, 30 Jun 2020 11:43:52 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id a20sm2127016ila.5.2020.06.30.11.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:43:52 -0700 (PDT)
Date:   Tue, 30 Jun 2020 11:43:44 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Message-ID: <5efb87e073155_3792b063d0145b486@john-XPS-13-9370.notmuch>
In-Reply-To: <20200630171241.2523875-1-yhs@fb.com>
References: <20200630171240.2523628-1-yhs@fb.com>
 <20200630171241.2523875-1-yhs@fb.com>
Subject: RE: [PATCH bpf 2/2] bpf: add tests for PTR_TO_BTF_ID vs. null
 comparison
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> Add two tests for PTR_TO_BTF_ID vs. null ptr comparison,
> one for PTR_TO_BTF_ID in the ctx structure and the
> other for PTR_TO_BTF_ID after one level pointer chasing.
> In both cases, the test ensures condition is not
> removed.
> 
> For example, for this test
>  struct bpf_fentry_test_t {
>      struct bpf_fentry_test_t *a;
>  };
>  int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>  {
>      if (arg == 0)
>          test7_result = 1;
>      return 0;
>  }
> Before the previous verifier change, we have xlated codes:
>   int test7(long long unsigned int * ctx):
>   ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>      0: (79) r1 = *(u64 *)(r1 +0)
>   ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>      1: (b4) w0 = 0
>      2: (95) exit
> After the previous verifier change, we have:
>   int test7(long long unsigned int * ctx):
>   ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>      0: (79) r1 = *(u64 *)(r1 +0)
>   ; if (arg == 0)
>      1: (55) if r1 != 0x0 goto pc+4
>   ; test7_result = 1;
>      2: (18) r1 = map[id:6][0]+48
>      4: (b7) r2 = 1
>      5: (7b) *(u64 *)(r1 +0) = r2
>   ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>      6: (b4) w0 = 0
>      7: (95) exit
> 
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Wenbo Zhang <ethercflow@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Thanks.

Acked-by: John Fastabend <john.fastabend@gmail.com>
