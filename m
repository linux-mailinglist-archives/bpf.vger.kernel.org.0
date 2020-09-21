Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFED2730E5
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIURdm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIURdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 13:33:42 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A4C061755
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 10:33:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u13so9671332pgh.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=diL+saZZT2WaZgHN/vk47RMvlQkVvwHiLmBQ13UEX0c=;
        b=leD8pL2ttdmg64xZuhIgElngYr71B7yvI/e3fSe0QZQs3+XwToW97rEFVgqHNQ6dlP
         uhxVRByU/LzFh6sNYBY5FgY/Xou1Fp95XR2NAuvBmyuuPXL8k4STILfs6vXvTovriN7b
         hD2vOkeQEU0YxDUao8nKEQ8oL0Er9ujTsEWxLSaOvfAtcnLfUJ/qklagOUb4pyVNV4FK
         JOkctTeqtEB/roYnpjnVfsFSVsIkYacbdPOV2XaKStpv62SW3P9VRtceLbdlElm/Sezl
         cGOirlhyCdx6l6AdHQAl4v0yNPOrAAj2VhAtetTR9159mM/Cp5TrURVk8Vyr50IGknB9
         WrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=diL+saZZT2WaZgHN/vk47RMvlQkVvwHiLmBQ13UEX0c=;
        b=o4wweu3d2vgpoWmeEj+5ygYn+SQ1E2jHWa0u/1ea1pdow757/EjlyMsWfNGLgOcIOI
         SCVwdfIoFuKJhoOaGStg0SdHTkdprxPOdmoRXzN9Xi5rEz59CjspYWWKCZ0MQIAvpbBj
         +LPxto+HYI5iA//dq7Vgzs9B3pfDMY53YOtIuFbpxfrBRqBoZ9Q3NI5xi08IOsYePhPE
         8YDt5KHbNrEGVpT9KrEBzqr5yjoxeZmAI0k9dKlIYHqSxsvAn56f3bBTMfuWrCr1ysSQ
         DhadoBKwShuJrkoGngc3pe5rWcUXl6s8N0aDyU35xyymfsXlvmrm2JpzKvfFzha/vnxp
         yNDA==
X-Gm-Message-State: AOAM531ajccy53/2wd6A7SNSiima5xTSQ+0Q3n/jV7PWgA+7pW0sQzB5
        hWhQWs64I9efwjXBSLCTDTQ=
X-Google-Smtp-Source: ABdhPJzSWb1iZNcFpmWw1PsfzZ1Z2k3LwGpUq+mhnNzjXgeKFCbydaei7JE28ujhNxUsf9L77jP1DA==
X-Received: by 2002:a17:902:34f:b029:d1:e5e7:bdcf with SMTP id 73-20020a170902034fb02900d1e5e7bdcfmr976238pld.47.1600709622026;
        Mon, 21 Sep 2020 10:33:42 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id q4sm12672112pfs.193.2020.09.21.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:33:41 -0700 (PDT)
Date:   Mon, 21 Sep 2020 10:33:35 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Xin Hao <xhao@linux.alibaba.com>, ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, andriin@fb.com,
        xhao@linux.alibaba.com, bpf@vger.kernel.org
Message-ID: <5f68e3ef27b9d_17370208e2@john-XPS-13-9370.notmuch>
In-Reply-To: <20200920144547.56771-4-xhao@linux.alibaba.com>
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
 <20200920144547.56771-4-xhao@linux.alibaba.com>
Subject: RE: [bpf-next 3/3] samples/bpf: Add soft irq execution time
 statistics
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Xin Hao wrote:
> This patch is aimed to count the execution time of
> each soft irq and it supports log2 histogram display.
> 
> Soft irq counts:
>      us	             : count    distribution
> 
>      0 -> 1	     : 151      |****************************************|
>      2 -> 3          : 86       |**********************                  |
>      4 -> 7          : 59       |***************                         |
>      8 -> 15         : 20       |*****                                   |
>     16 -> 31         : 3        |			                 |
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Couple nits otherwise LGTM.

> ---

[...]

> +
> +typedef struct key {
> +	u32 pid;
> +	u32 cpu;
> +} irqkey_t;
> +
> +typedef struct val {
> +	u64 ts;
> +	u32 vec;
> +} val_t;
> +
> +typedef struct delta_irq {
> +	u64 delta;
> +    u32 value;

should be a tab

> +} delta_irq_t;
> +
> +struct bpf_map_def SEC("maps") start = {
> +	.type = BPF_MAP_TYPE_HASH,
> +	.key_size = sizeof(irqkey_t),
> +	.value_size = sizeof(val_t),
> +	.max_entries = 1000,
> +};

Seems more common to use the style,

struct {
	__uint(type, ...);
	__uint(max_entries,...);
	...

} start SEC{".maps");

> +
> +struct soft_irq {
> +	u64 pad;
> +    u32 vec;

spaces -> tabs, probably run ./contrib/scripts/checkpatch on the rest and
cleanup the other cases as well.

[...]
