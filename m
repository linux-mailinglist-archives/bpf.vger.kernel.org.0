Return-Path: <bpf+bounces-8772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250A789C27
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 10:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E2D1C20946
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805781361;
	Sun, 27 Aug 2023 08:35:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21480B
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 08:35:14 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA8132
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 01:35:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso2899348a12.3
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693125308; x=1693730108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pfh0V8WhEptAH1pn8Pk3597byPb09Pv5kSzHshUdaBo=;
        b=cbRdxoIMaJz2PkjxawPLw9pVmr2jEZKyfO4dY60quz2U1GTHh+P5GfeK/ZVl7TlGWy
         YZ4SruqLYLmjSfmGpyH1c8NJverayKeP9Y4nkS3SnK15iOzv6wbOxJtnoD2zkyFIC5H0
         hgBYkKalKqlly0ipTibr0DnoLVBYTDH084loVDv3Y9wTH3BUoE+YHYlZ0PdV/NE8QaSQ
         WrpSS/bXQ3EXw4eb6A3MQoU3rXZsM0YgqIkUmLgr8Nz5AqmirTWIOOhKGOOy9QOXNFXV
         hCEXYfRZLyirfoUUOyT9htTnTOOJUGnCG3mhSRWRl0Yij9VXAVCYileAwoJEnQGiXkd5
         nsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693125308; x=1693730108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfh0V8WhEptAH1pn8Pk3597byPb09Pv5kSzHshUdaBo=;
        b=LhMXKokm8jMwwwJYBEIFKUOLdLTKhMHwYl9O+x3WpatGR0/yYeY1L1JDHyd5yh9Aex
         GPHusWVlXxMUxVU5ee6N/MCseAsJRfZ2cC6cEYQ2v6wVxU3R755oM8o8U1c3fBgn8YIf
         u6RzhHOktvtPa2u8g86Rs7v7dSRQJsgWxs/MOBe4qCe+CRg1oPTDr/Fs2XGWNplCmrDM
         SDUNr0Aauh0rjPkDDj9lzWJKRUFkoDIurad/0fbxSApsFz/JHrVn27XFWdjZ0wiMfk9A
         nb315fgYYqUedClFchiG4gOzYkFvjozRX9mQ5VxhFDlmnAN7Z39/+6HTKGGSp+lYL2mZ
         EGzg==
X-Gm-Message-State: AOJu0Yw3WwHJiqhtp8hP/HdHcNgMHcOW7SrUlZnFWKJJ+8N/nePE1h+g
	90CAEp5vTv7rTIQBobRzOLI=
X-Google-Smtp-Source: AGHT+IHaD0JIxtZTAf/gJRwrHt4bQrwDnUeo/LrlrJRrtALXFVYcVoMZZSHHY1ck0JEZW5W2L/xtGA==
X-Received: by 2002:a17:906:53d9:b0:9a1:aa7b:482e with SMTP id p25-20020a17090653d900b009a1aa7b482emr11934040ejo.26.1693125308328;
        Sun, 27 Aug 2023 01:35:08 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id v15-20020a1709064e8f00b00991e2b5a27dsm3169792eju.37.2023.08.27.01.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 01:35:07 -0700 (PDT)
Date: Sun, 27 Aug 2023 10:35:06 +0200
From: Nam Cao <namcaov@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
	bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
Message-ID: <ZOsKukBz8i+h4Y8j@nam-dell>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <87v8d19aun.fsf@all.your.base.are.belong.to.us>
 <ZOpAjkTtA4jYtuIa@nam-dell>
 <87cyz8sy4y.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyz8sy4y.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 27, 2023 at 10:11:25AM +0200, Björn Töpel wrote:
> The default implementation of is_trap_insn() which RISC-V is using calls
> is_swbp_insn(), which is doing what your patch does. Your patch does not
> address the issue.

is_swbp_insn() does this:

        #ifdef CONFIG_RISCV_ISA_C
                return (*insn & 0xffff) == UPROBE_SWBP_INSN;
        #else
                return *insn == UPROBE_SWBP_INSN;
        #endif

...so it doesn't even check for 32-bit ebreak if C extension is on. My patch
is not the same.

But okay, if it doesn't solve the problem, then I must be wrong somewhere.
 
> We're taking an ebreak trap from kernel space. In this case we should
> never look for a userland (uprobe) handler at all, only the kprobe
> handlers should be considered.
> 
> In this case, the TIF_UPROBE is incorrectly set, and incorrectly (not)
> handled in the "common entry" exit path, which takes us to the infinite
> loop.

This change makes a lot of sense, no reason to check for uprobes if exception
comes from the kernel.

Best regards,
Nam

