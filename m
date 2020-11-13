Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E42B23C2
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKMS2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 13:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKMS2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 13:28:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96897C0617A6
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 10:28:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l1so10997689wrb.9
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 10:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ng2VvXg7vNgUseRrMkMXXM0qsKkjJ84iIXJLcjxcu38=;
        b=FVGsLbXP42Ja2KvJ+ArlS6vyZbaEwBpcVH4K0t0qpSfpD+Yi6gRw5Oj+1pGJxsyprf
         KeX3ljBJlp9gE4lF5dOvntv7B/VMifX9EVDWBn54VnW4SYc54SH7UzPTrACryAKVysCK
         0CWLiAZA76MujIkb1WO9eVG+pcaZzCKuKnSfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ng2VvXg7vNgUseRrMkMXXM0qsKkjJ84iIXJLcjxcu38=;
        b=phYz62yo0dRy0ae0yT2KmirMAsNRHJOGNQKwOfmdbqF/zsmD+BQF4KlTGFVXlNYJI6
         EzLxcELUntsLf4sWc5XzEgVVG/QcGGy+nE1XpUfzEHssNCQSw/uIa9b+zuFEu4m/QR9b
         6riVzKW/qZ3IAAKWLc1aRebsKtirkZdkOUdJ6XhoU3Q/19FI1S53OhWYgoWc/nijURXp
         UgVh2U07yYhdAFJ/tPvyL4BvFaoAUHVwY0862OtvfyzHfDXAM7c4cy9cZDAA1zY4r/Io
         gXZD9PPkaEboKrmY6zfKPXBvBEnNDglYSOTnlkuJlr8MQ/UpdoxsIfGYlIX4gVBnSbhr
         mtVw==
X-Gm-Message-State: AOAM531HoeTP6WPZdnHhn/RfyWvtBMUqtvg17iDsQjKQB3iY1s0Swf9E
        ydNfnt1IM9ziQknp8J0IYfuCZQ==
X-Google-Smtp-Source: ABdhPJy84uz9MZNSChglFhbjANXAAUrOKCoo4+CnNGfwPoFkV7hAkgCD05sbKtueWmDy0M9IROhQig==
X-Received: by 2002:adf:e544:: with SMTP id z4mr5089010wrm.83.1605292133214;
        Fri, 13 Nov 2020 10:28:53 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id o205sm11138131wma.25.2020.11.13.10.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 10:28:52 -0800 (PST)
Message-ID: <4c446d3f19dd644eb520ae29a4d0b91a7ea3b956.camel@chromium.org>
Subject: Re: [PATCH] bpf: Expose bpf_sk_storage_* to iterator programs
From:   Florent Revest <revest@chromium.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, andrii@kernel.org, kpsingh@chromium.org,
        jackmanb@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Fri, 13 Nov 2020 19:28:51 +0100
In-Reply-To: <20201112215742.mzznj7py3fmnl5ia@kafai-mbp>
References: <20201112200914.2726327-1-revest@chromium.org>
         <20201112215742.mzznj7py3fmnl5ia@kafai-mbp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-11-12 at 13:57 -0800, Martin KaFai Lau wrote:
> Test(s) is needed.  e.g. iterating a bpf_sk_storage_map and also
> calling bpf_sk_storage_get/delete.
> 
> I would expect to see another test/example showing how it works end-
> to-end to solve the problem you have in hand.
> This patch probably belongs to a longer series.

Fair point, I'll get that done, thank you!

> BTW, I am also enabling bpf_sk_storage_(get|delete) for
> FENTRY/FEXIT/RAW_TP but I think the conflict should be manageable.
> https://patchwork.ozlabs.org/project/netdev/patch/20201112211313.2587383-1-kafai@fb.com/

Thanks for the heads up, should be no problem :) 

