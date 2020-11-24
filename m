Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7132C1E70
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 07:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgKXGkE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 01:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbgKXGkD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 01:40:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF7C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 22:40:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so17475449pfg.12
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 22:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DkuEKxOrBgHumxzBzNasPG6aS//bYurF/zUFfZbHLlg=;
        b=n0EiF3NB/OIkU3m0MMgG006lrcRIbUjwpx6Lfy5f6uR93fFVfCh+Eri2mF4YoJTawQ
         WdgiRf13HiSPffVVK41kZMGynLW8wXNwSD7pWu3X/nwTU1eRmDR0FMQEI/SmaUQpl9mo
         7biRVqKLV9Ya+BdstVw3kYjysYxkc8GpmU5Y4M/HFqckyl93gvEmQCZWKN3xbOCcqSk3
         qBDWlhIkj41lsIZcoG5gs4N+ZtAP3KX5OasVffqM8mc4fBUw9xyIPbYIJOOmOtPpChRx
         irZEDv+VOVBhrtlDlkFpvx6P1gsdJl2eeikdF6VLvhpYFKSXjvElKhLjwz3LkO+8Dfwj
         Dkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DkuEKxOrBgHumxzBzNasPG6aS//bYurF/zUFfZbHLlg=;
        b=cCC093ID66/hXkC7phSDlXobYGMhWAUmBtqh72LC1m9B2r1NiKiN5lKhu02xOomZD7
         OPt6Usdd7yGRWy919tJ7WW996taNdegKG0ZuJumAefIlM/eNx3rkiphhDGBVjqXDO2wQ
         dQRm71gpVh25qlJ2yc/38r6WuM128hwPAcJoUlcDp0s2K/bdIsV+idmyq1EaK3zBsUi/
         ImUHrGRF9Ci56ytuzLpfHP1wDvvWWnDm+2wWXRmJK92Gfny+O12FG3Tnp0YvpOWeHURZ
         m6kh05lUO2XbeVmIhANWigWztVEMI8s/29GuYW+zY1SnpkCEPVGBSHsY9eOoLah9dK5i
         9FRw==
X-Gm-Message-State: AOAM533h9XVl+Q8G8q8b+cRDJLs8WKfYAeOXQcrd6WDzYp1jUJ7lqTEm
        OY2jnN8rAIUw4T53ZY9i3sE=
X-Google-Smtp-Source: ABdhPJw1k5RcFV//9L640iksl8hrT4ORnzSbyiJOxK7kDpAwGDZN1LqD2sS+fTid8dZ2D6gQP7WNCw==
X-Received: by 2002:a62:ddcb:0:b029:197:faf2:e8b4 with SMTP id w194-20020a62ddcb0000b0290197faf2e8b4mr2919748pff.75.1606200003226;
        Mon, 23 Nov 2020 22:40:03 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:2397])
        by smtp.gmail.com with ESMTPSA id s18sm14137582pfc.5.2020.11.23.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 22:40:02 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:40:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 6/7] bpf: Add instructions for atomic_cmpxchg and friends
Message-ID: <20201124064000.5wd4ngq7ydb63chl@ast-mbp>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-7-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123173202.1335708-7-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 05:32:01PM +0000, Brendan Jackman wrote:
> These are the operations that implement atomic exchange and
> compare-exchange.
> 
> They are peculiarly named because of the presence of the separate
> FETCH field that tells you whether the instruction writes the value
> back to the src register. Neither operation is supported without
> BPF_FETCH:
> 
> - BPF_CMPSET without BPF_FETCH (i.e. an atomic compare-and-set
>   without knowing whether the write was successfully) isn't implemented
>   by the kernel, x86, or ARM. It would be a burden on the JIT and it's
>   hard to imagine a use for this operation, so it's not supported.
> 
> - BPF_SET without BPF_FETCH would be bpf_set, which has pretty
>   limited use: all it really lets you do is atomically set 64-bit
>   values on 32-bit CPUs. It doesn't imply any barriers.

...

> -			if (insn->imm & BPF_FETCH) {
> +			switch (insn->imm) {
> +			case BPF_SET | BPF_FETCH:
> +				/* src_reg = atomic_chg(*(u32/u64*)(dst_reg + off), src_reg); */
> +				EMIT1(0x87);
> +				break;
> +			case BPF_CMPSET | BPF_FETCH:
> +				/* r0 = atomic_cmpxchg(*(u32/u64*)(dst_reg + off), r0, src_reg); */
> +				EMIT2(0x0F, 0xB1);
> +				break;
...
>  /* atomic op type fields (stored in immediate) */
> +#define BPF_SET		0xe0	/* atomic write */
> +#define BPF_CMPSET	0xf0	/* atomic compare-and-write */
> +
>  #define BPF_FETCH	0x01	/* fetch previous value into src reg */

I think SET in the name looks odd.
I understand that you picked this name so that SET|FETCH together would form
more meaningful combination of words, but we're not planning to support SET
alone. There is no such instruction in a cpu. If we ever do test_and_set it
would be something different.
How about the following instead:
+#define BPF_XCHG	0xe1	/* atomic exchange */
+#define BPF_CMPXCHG	0xf1	/* atomic compare exchange */
In other words get that fetch bit right away into the encoding.
Then the switch statement above could be:
+			switch (insn->imm) {
+			case BPF_XCHG:
+				/* src_reg = atomic_chg(*(u32/u64*)(dst_reg + off), src_reg); */
+				EMIT1(0x87);
...
+			case BPF_ADD | BPF_FETCH:
...
+			case BPF_ADD:
