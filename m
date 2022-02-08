Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F408C4AE233
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 20:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385816AbiBHTZ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 14:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349608AbiBHTZ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 14:25:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B89C0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 11:25:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x65so130052pfx.12
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 11:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bkiN1fO1Jj7X33CerX7arM3H01YbpO9MqQnVJP7o0MQ=;
        b=ZB2Q8Lsbn9NY3pm1ps/Tah/5/K+/57A4xwDlgAYZ0XwOcSaOTHBbhDmaE0hOrUVZUK
         vEf1+sVBCO1ac1AXfhY7ewJOl0yn4jZbw4v+6xTfn/E0Z4E2B6xxLw8bDgXkfj0xDF6+
         5y7t7DQxEL6627Lw2IJZlrEmx2fLGLyG216iZaOTxQL9c6cCo4ZNx5volS/GjNrgAnBp
         Mg99ls7qwh1d7zKD05r/uqO7nGyncnfr7si1MPXUbP7HxJQLCfVOKk9jIAcudvZvg/2e
         P3lAxCkjuXBHPxmo+A79f1Jzz2CRHYi4AHtU912UmPNpMXQADRPSPHGM3bPNja2Uz2c2
         UIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bkiN1fO1Jj7X33CerX7arM3H01YbpO9MqQnVJP7o0MQ=;
        b=gxeR9C5sCeBdTOOh19IroLCbqvDt6Yn+oCaeNxqAMCUEwoHDmyHrbzseDvbTaeA1jV
         IDkVF4rCuUIT3TOKZ/YDDtrNt5zlAO3aJJ8d57qzriPb30HXDcm0rg8qAzqVZYhTkOGj
         OAL/8vAk0AeUsRILpUDP22GrmgwdsRC+7lEr2tgIRF/1tjCDkw6evbUN5/nJfT2Mzv5L
         +Vbr8ERnSxRbrMWUmPqVv0JgX/gvcfPJHMUIeG5SukRa340T1S7QP3Q2uDcAhwIfC8ap
         htbfc3S3twWjFYJCp7t0gqqy8MXGJgdqrx81hZ1XtjonngOGYtNqz8355X+I6XLo9Lkt
         nHAw==
X-Gm-Message-State: AOAM5311JCBVqX6s+NKCzJvx1rdiN67msHtlt2NQvHBh9hgdzT+vZusG
        px2X5LOeBIo/HmFBPTlyEFw=
X-Google-Smtp-Source: ABdhPJw3PbgUCZExQorqDINqQbVBB7ScWDHq/2V1re4rqv4O6Zw75LyZPX4ICwgQ9ZxT8301viv02A==
X-Received: by 2002:a65:6681:: with SMTP id b1mr4681511pgw.221.1644348324908;
        Tue, 08 Feb 2022 11:25:24 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:72b2])
        by smtp.gmail.com with ESMTPSA id l12sm17350767pfc.182.2022.02.08.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:25:24 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:25:22 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 14/14] arm64: add a comment that warns that
 orig_x0 should not be moved
Message-ID: <20220208192522.risaxa7debgxx5kz@ast-mbp.dhcp.thefacebook.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
 <20220208051635.2160304-15-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208051635.2160304-15-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 08, 2022 at 06:16:35AM +0100, Ilya Leoshkevich wrote:
> orig_x0's location is used by libbpf tracing macros, therefore it
> should not be moved.
> 
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/arm64/include/asm/ptrace.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 41b332c054ab..7e34c3737839 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -185,6 +185,10 @@ struct pt_regs {
>  			u64 pstate;
>  		};
>  	};
> +	/*
> +	 * orig_x0 is not exposed via struct user_pt_regs, but its location is
> +	 * assumed by libbpf's tracing macros, so it should not be moved.
> +	 */

In other words this comment is saying that the layout is ABI.
That's not the case. orig_x0 here and equivalent on s390 can be moved.
It will break bpf progs written without CO-RE and that is expected.
Non CO-RE programs often do all kinds of bpf_probe_read_kernel and
will be breaking when kernel layout is changing.
I suggest to drop this patch and patch 12.
