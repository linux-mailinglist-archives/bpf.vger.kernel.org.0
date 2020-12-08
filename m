Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0532D22EF
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 06:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgLHFOd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 00:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgLHFOd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 00:14:33 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30A5C061749;
        Mon,  7 Dec 2020 21:13:46 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l200so18176594oig.9;
        Mon, 07 Dec 2020 21:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sadeGNSRFPIoFTYVcdnZgjQ48y5NGBk9I5/A99DQWxI=;
        b=cpVQ2N3UgmfVIMaW6R2J3zD6cpcTbxMKt3p989Si/sfb4z4ZV7G7BW8MahYbrh9NXv
         vWP0ADO22BMuB+0IzKhtV78tueAQETXob4RzsVu9nPlYCgHY5T4nWRZNW8O+nnYHIrzv
         xvcaaUka8DfQzoK26lm2xSO9IUCOoIX5UNeLzuxLO0CZrlmTRzTvAQrlABeNmO97Z9TS
         AH7ZVil+/KwsPA5SXsijirdQWsh5E4YG7fAwMp8Crcxgn5o0KIbLdQpozumJWUFDBqmT
         qsLt/ejhpH23deonD4c1081rIQXY8l1IH1e7Lh+x+cEJ/EtBYeUQ8qPhYV+ggL5g8pSV
         jNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sadeGNSRFPIoFTYVcdnZgjQ48y5NGBk9I5/A99DQWxI=;
        b=EhSmINKde7lSdtTfhZQKAqftnrgm/M737GSJkanJfQgWbaSlMfXierN3r/jjNoHRbv
         9N5wT23Wb14bMcYaW5gU/LFvq2OcXOyLkkJoz5Zv/w0oR0BLdKOioUkAq9NkdvsoEgNm
         wEEeY2OQSgbLmrUuylzZM5bRr/nbvsScWA9gV6EfPb2icID6JX/JgZTzJPOLigTsojTl
         jQCcd9tFuAbMzqTgjdQ+5hWpzQlvWQJR0PlBaZTUhh4ApvDIPTJylqYDvXm4CrtUmCWJ
         41b0XpudlLcot9n14whBVqLFWca40ZOV4nTCFPL34lorM0+CbeWrxNz50x07MwNu+9YL
         nVZw==
X-Gm-Message-State: AOAM531J0nY1I/wbQCSAajHZvnq/YDiiGXIaIm5GLrptaU3+2eBZ7q6R
        /Sdz1ZXjBz4szq1/5Q/is7Y=
X-Google-Smtp-Source: ABdhPJwvgYPuGDuISfyb1O2jLRFnr7KA0IUoNzmcX4++qlC6Wglm7ptMgEUFuTZNZAPknczARLNy4Q==
X-Received: by 2002:aca:f456:: with SMTP id s83mr1505805oih.58.1607404426497;
        Mon, 07 Dec 2020 21:13:46 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id v5sm3131017oob.40.2020.12.07.21.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 21:13:45 -0800 (PST)
Date:   Mon, 07 Dec 2020 21:13:40 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5fcf0b8413fe_9ab3208ce@john-XPS-13-9370.notmuch>
In-Reply-To: <20201207160734.2345502-6-jackmanb@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-6-jackmanb@google.com>
Subject: RE: [PATCH bpf-next v4 05/11] bpf: Move BPF_STX reserved field check
 into BPF_STX verifier code
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> I can't find a reason why this code is in resolve_pseudo_ldimm64;
> since I'll be modifying it in a subsequent commit, tidy it up.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  kernel/bpf/verifier.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Acked-by: John Fastabend <john.fastabend@gmail.com>
