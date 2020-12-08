Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E819D2D2340
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 06:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLHFc3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 00:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgLHFc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 00:32:29 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82CDC061749;
        Mon,  7 Dec 2020 21:31:48 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s75so15168265oih.1;
        Mon, 07 Dec 2020 21:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=F/C3M7PpJplaz2NlfMsMr7Z2jIBADqhdF6BrYFQrE2U=;
        b=uPiDefoQYkKUSYVjpVcGFbjGGdgwvk2tmiacvGTPf1f1XKPLLEnQVTwTCx8tWNScnC
         5j6c5sfjBEHrnhNhCj80/FWk0MTp670DUW5Dv4G2IUCx3Yd324y+YBTw3C7sot2KNTxS
         eCd3u/BKvQq6Lpsj9pg4Rx9/ID1ezkPBxSBAbr8Jo3UhV8nfB4LGtur/M6evKWpsYeYr
         Kta/pLzpmNREVmoWhp6gm736Rm4VmhVwhQGYxgwokNPamv1ZXQjxZyDMm48/vCgeZrty
         wSK63DtyX5nZNX5tTgWgFTkRVDrwHvF2voN8metmYSxDRY2JPRc2BNn9ZyShUI48DnYx
         jpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=F/C3M7PpJplaz2NlfMsMr7Z2jIBADqhdF6BrYFQrE2U=;
        b=Yj3+PodwHv4IHqN6pEM54QjgYmla+7zdSq5uCsHEPb4Cvl24ck0M70n8Ym7PhGiwEM
         vzu1lhXtqtk0n0+tKMP4cnBS3UMjgWFPhyMDHzbSKL7O2i78fvjezgJK40lHBrReqlJ7
         PUTf0bC1sXMiQ6WDPT1Q3RgnJ3aiaTsn9xYWSiaEe43ePJY9m13B58ff4F/d+OiI6h+F
         gBeirQPdsfhEjYLHUkz2lKm7t+NTTxmAfAAXsIVTjy2pbJBiXtNwoNTqovKdePnu96Yl
         RITqXEgIIYSL55XKgvsfFmtVgdORhVpWK2Qb1jOBl93xr0O8JbKJsqsyQy+JxvfHGw4U
         K6og==
X-Gm-Message-State: AOAM5324hFs+SPHM4q2CLyBpS9jqpRLl8Hhgtm9JNWLKOGg3PlsW+BwK
        0K4Z0pOSaCCF7ZK1lEUH8Tc=
X-Google-Smtp-Source: ABdhPJx81dPrD6uJgJG8T7kA9bYfspa122kKDg8FYUgX72z8Wkl9JIPiXbCZyYapxK4XUnxjFnoHoQ==
X-Received: by 2002:aca:2411:: with SMTP id n17mr1539117oic.43.1607405508392;
        Mon, 07 Dec 2020 21:31:48 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id k30sm2930191ool.34.2020.12.07.21.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 21:31:47 -0800 (PST)
Date:   Mon, 07 Dec 2020 21:31:40 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5fcf0fbcc8aa8_9ab320853@john-XPS-13-9370.notmuch>
In-Reply-To: <20201207160734.2345502-7-jackmanb@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-7-jackmanb@google.com>
Subject: RE: [PATCH bpf-next v4 06/11] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> The BPF_FETCH field can be set in bpf_insn.imm, for BPF_ATOMIC
> instructions, in order to have the previous value of the
> atomically-modified memory location loaded into the src register
> after an atomic op is carried out.
> 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

I like Yonghong suggestion 

 #define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)               \
     BPF_ATOMIC(SIZE, DST, SRC, OFF, BPF_ADD | BPF_FETCH)

otherwise LGTM. One observation to consider below.

Acked-by: John Fastabend <john.fastabend@gmail.com>

>  arch/x86/net/bpf_jit_comp.c    |  4 ++++
>  include/linux/filter.h         |  1 +
>  include/uapi/linux/bpf.h       |  3 +++
>  kernel/bpf/core.c              | 13 +++++++++++++
>  kernel/bpf/disasm.c            |  7 +++++++
>  kernel/bpf/verifier.c          | 33 ++++++++++++++++++++++++---------
>  tools/include/linux/filter.h   | 11 +++++++++++
>  tools/include/uapi/linux/bpf.h |  3 +++
>  8 files changed, 66 insertions(+), 9 deletions(-)

[...]

> @@ -3652,8 +3656,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>  		return err;
>  
>  	/* check whether we can write into the same memory */
> -	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> +	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> +			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> +	if (err)
> +		return err;
> +
> +	if (!(insn->imm & BPF_FETCH))
> +		return 0;
> +
> +	/* check and record load of old value into src reg  */
> +	err = check_reg_arg(env, insn->src_reg, DST_OP);

This will mark the reg unknown. I think this is fine here. Might be nice
to carry bounds through though if possible

> +	if (err)
> +		return err;
> +
> +	return 0;
>  }
>  
