Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806843FF532
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 22:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346217AbhIBU54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 16:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbhIBU54 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 16:57:56 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D292C061575;
        Thu,  2 Sep 2021 13:56:57 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id x5so3210972ill.3;
        Thu, 02 Sep 2021 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=E1S+5jcQWtYE5x5qrFpgfYh9OaMNAx9YRcmdcbIaK6o=;
        b=ChEuHje9Z9mTGPnt9v3KD+WXVDNxocrqhat7qwkCyKtXkS5EXxCbtVyjH7Sv2chiVx
         M7rbQ1HftU4Ydq+ZrvmH6scvsgFryZn2S30Yy7bZWJoEQmDDQhvfI2F80ZhnEqFKrqPy
         XSeFVKHEE6QFQQGwl5p6EIstrbIcof9ecDt8BDjRBdEwRT2e1mgarqMjCcAY5EgmcToh
         edXrdheQ2WAZON0iKD5CGUDTw1DvkWg7y7SGFPbl6VBRBcsx8thDnAL9bKoEN8YI977s
         1gidKOMrNOMO63X0NGAL6Jgf2EC3PLhrnHcgsRxpHMtzMxcdMdsNSCs7scfufrsAmBOb
         ngSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=E1S+5jcQWtYE5x5qrFpgfYh9OaMNAx9YRcmdcbIaK6o=;
        b=FPhFJqFZXBafH1TH8E9WQGIEWqOKmWfuTlrJHUkX3wIeiG7ESiwcsMDvEIVINaWOxs
         aiyDsgOBzQMza0tWB+Lb/hy4IVsAMVbQoJEaA9UhhLd0XZ+U50+TTOOCN+GJ5FarrBqV
         fq9zMFeB0wOQiND0ls3+FrHVP0H2ZTr7CQvfgt2jYb09gcnzpg20zbBRc/TdKhbzxzrN
         7xooDIu4ucg9Oeh++5kPgBO+Yo5dVSHCpjtgwvkNKZk2ABNDQPRxvh6xzcI9nhM/Qs42
         7bm3PrGBOWiY1CaCFM4YlNzP0h6WAXT/um6ne1ouR/+GcqbFjT5AxO2193d+ph4gybSO
         snRA==
X-Gm-Message-State: AOAM533sQBEYVjmxQOy0SAMbgJNUKl6wF+Q7uuBKpQsP6mAWIsUCYPYd
        rJ08J+fbi2YLQ13TbMSa97A=
X-Google-Smtp-Source: ABdhPJxnzpCc8Kz1ZhInbesLw1eMGFRroGaGqN2turdSPsmyR5bFQdHxNOXyj0nhfJ/ntaxMCyr4tQ==
X-Received: by 2002:a92:c70e:: with SMTP id a14mr60918ilp.299.1630616216688;
        Thu, 02 Sep 2021 13:56:56 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id j6sm1601683iom.5.2021.09.02.13.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:56:56 -0700 (PDT)
Date:   Thu, 02 Sep 2021 13:56:47 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        kjain@linux.ibm.com, kernel-team@fb.com,
        Song Liu <songliubraving@fb.com>
Message-ID: <61313a8fda896_2c56f208bb@john-XPS-13-9370.notmuch>
In-Reply-To: <20210902165706.2812867-3-songliubraving@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
Subject: RE: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu wrote:
> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
> branch trace from hardware (e.g. Intel LBR). To use the feature, the
> user need to create perf_event with proper branch_record filtering
> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---

[...]

>  
> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
> +{
> +#ifndef CONFIG_X86
> +	return -ENOENT;
> +#else
> +	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
> +	u32 entry_cnt = size / br_entry_size;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (!buf || (size % br_entry_size != 0))
> +		return -EINVAL;

LGTM, but why fail if buffer is slightly larger than expected? I guess its a slightly
buggy program that would do this, but not actually harmful right?

Acked-by: John Fastabend <john.fastabend@gmail.com>
