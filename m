Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033EC4DAA8D
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 07:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352836AbiCPGSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbiCPGSo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 02:18:44 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3D3701C
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 23:17:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h63so1226700iof.12
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 23:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=73Jw8dBrV6CThchpLZBZWuU5Om36ScocMTunWCuFxX4=;
        b=Z67nPPzHrC3KLefMNI0TLkwsi3ib+kRN+qQ7eWGZKZcgteV3GveMGt43MU2fgshOd9
         lnPx6Uy+TR46yFWuUcjnOW0LukTnV4hMSab7+L80W5+EWgZS0otIlGL8DOt+nQGzBSVw
         /eGZ2hGFZEHC2N2HnEYrzBjyaW548kjl8O0VhyOteCdM4LcubiSR7bZz8sDFDSOt01xK
         6TovUUwdXPwljgnm3He7Kv6IAIt8TWfkOMpiVyCu74ARYjsn2wnWLkB2u7BF/Se/Mk5n
         bFmph7lSCxpKmiCfl1mBcM3X7L6YsSL5S0ekSHVJIE/W4lQ4frTx7V255Vb2vAHxVdU2
         XznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=73Jw8dBrV6CThchpLZBZWuU5Om36ScocMTunWCuFxX4=;
        b=pCHxNeAuN3sSxuLi02nteukivxNNeA8F349uwQUEOZi7HvZwhUFpUv4r0/ZUTrJ1p1
         ljO5STjBbaTenEXvU9cMQ7rVDOmgN2u3SytN+tDeNjBiNVTWNiNVmtTuMStOLcaQd2l4
         vCSROwm/3pQFTcQ1EdpZLB47BcYTUiXKeMc0E1Vd3X/4bQgXbT9I0q81kCxcXfLInUBL
         uRdgDR4cafncNV6VhySUdUMqHzSLg1QGOAYTnJfZaFLIj5bMEhDoglPevAvFSZIQkoTv
         h2+lgEf3YI9mlk4Jk0/19wEItr9FBaeX8XzpyriwAV9/kdJVr/wgzjDn0BLd5Ug2LgVr
         Noyw==
X-Gm-Message-State: AOAM533qlQyqQRmE6LQAkIctWMPDA2QlDNUUQVYhnka0bNnuMAWSxukz
        5cA3IhRhZHlYj4vS1vMEwjU=
X-Google-Smtp-Source: ABdhPJy78FfQENktjOcdS9o2/5QCGE9n2z27bGHADbl9k3GGQ8HNIJxVHeaCT+zEMCG4qCzEKfoOgw==
X-Received: by 2002:a05:6638:258f:b0:31a:1c77:f6ef with SMTP id s15-20020a056638258f00b0031a1c77f6efmr3621664jat.25.1647411450321;
        Tue, 15 Mar 2022 23:17:30 -0700 (PDT)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id d16-20020a05660225d000b00645c8db7767sm585318iop.35.2022.03.15.23.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 23:17:30 -0700 (PDT)
Date:   Tue, 15 Mar 2022 23:17:23 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Message-ID: <623180f35efff_1761208fd@john.notmuch>
In-Reply-To: <20220316014847.2256135-1-kafai@fb.com>
References: <20220316014841.2255248-1-kafai@fb.com>
 <20220316014847.2256135-1-kafai@fb.com>
Subject: RE: [PATCH bpf-next 1/3] bpf: selftests: Add helpers to directly use
 the capget and capset syscall
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau wrote:
> After upgrading to the newer libcap (>= 2.60),
> the libcap commit aca076443591 ("Make cap_t operations thread safe.")
> added a "__u8 mutex;" to the "struct _cap_struct".  It caused a few byte
> shift that breaks the assumption made in the "struct libcap" definition
> in test_verifier.c.
> 
> The bpf selftest usage only needs to enable and disable the effective
> caps of the running task.  It is easier to directly syscall the
> capget and capset instead.  It can also remove the libcap
> library dependency.
> 
> The cap_helpers.{c,h} is added.  One __u64 is used for all CAP_*
> bits instead of two __u32.
> 
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  tools/testing/selftests/bpf/cap_helpers.c | 68 +++++++++++++++++++++++
>  tools/testing/selftests/bpf/cap_helpers.h | 10 ++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/cap_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/cap_helpers.h
> 
> diff --git a/tools/testing/selftests/bpf/cap_helpers.c b/tools/testing/selftests/bpf/cap_helpers.c
> new file mode 100644
> index 000000000000..e83eab902657
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/cap_helpers.c

LGTM

Acked-by: John Fastabend <john.fastabend@gmail.com>
