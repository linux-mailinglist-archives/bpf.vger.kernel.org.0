Return-Path: <bpf+bounces-8775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A348F789CB1
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 11:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE37D1C209AA
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F640612E;
	Sun, 27 Aug 2023 09:39:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D97B17E4
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 09:39:06 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A8A110
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 02:39:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff882397ecso3419690e87.3
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693129142; x=1693733942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DuIriem81nzRehAv+dIheh/q19YUwVhfdgY3JITm7p4=;
        b=f3lSYfat1xc+E0DiMIwo06EcY9tEwjZnpZXPEX8BjKoIbXe4LH1kplzBr7lcrRPR3D
         1sAvk8we8Le95ycbX+4lOFkD/6Hptvzt3F+0djra4Sq7mcJoSejp9DaMOSzkCHISeE6v
         EZ5EpoJ+0HBJ+C/9QY0K5WB5U2IBVIZ2J02fq4FgZK86gl12cedjZUx9r4el36wIEYZE
         kH3xN4BrbOyAonEpDn472wptkRnsIS6vTDsnI+y+rHO+EvEdJvpoRoi1AJXB7JU4sUzx
         QhrOMQkZlnpcajlG2oi62dRmnyL4rz8oSaEB8/5i7jOj9XUDLLLYqJrb5k8WDetFK2uw
         8r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693129142; x=1693733942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuIriem81nzRehAv+dIheh/q19YUwVhfdgY3JITm7p4=;
        b=W8kU9TO9wloeA2r4nXbOaGUkxhfQ0AlU5RXxd7bSfagHLgTUGfD8v6p1uvXgPZNoQB
         +CcupKDDATQj9OKhLwy/7vI/LoTtk19mg5NvffsSmXqBYmw3J4ONVbf6AAa8l7fXZ98y
         4rYc0xaB75ULE57H5duz3L4p3t7w4ZdztZnhYT7kmO/xH+5tGKV+BjAdmtLYqP4RkmDc
         PRrlnnfDGWP/T9XuBagAoD0yV/NZc2hfQ3Tt1lfs2CxtqFcFx4OZMM1tdBEnCzPzHgw5
         d6q95Lk7TAjp0/Zrmmk4kVvHsZ3j8zgVaqaU4mdbiC368RCj8adviF8JzDdtTZo/D7YM
         D8UQ==
X-Gm-Message-State: AOJu0Yyp3eEL2JsNjNZhJgfKpsesMlArK2NLh/t6kDVWdaLm4RZHlB8X
	TBwPPIoxImRkKzzY1hV4Ieg=
X-Google-Smtp-Source: AGHT+IEu4KedotAalNoGEFOjHUv8834Pj0IVdvHm0sooQIXz6DlODmHRjfdqI70WK+Y0LxJZUrqHxA==
X-Received: by 2002:a05:6512:32cc:b0:4fb:90c6:c31a with SMTP id f12-20020a05651232cc00b004fb90c6c31amr20053257lfg.14.1693129141642;
        Sun, 27 Aug 2023 02:39:01 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id v19-20020aa7d9d3000000b005256771db39sm3109860eds.58.2023.08.27.02.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 02:39:00 -0700 (PDT)
Date: Sun, 27 Aug 2023 11:39:00 +0200
From: Nam Cao <namcaov@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
	bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
Message-ID: <ZOsZtH+5P0/R6kvd@nam-dell>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <87v8d19aun.fsf@all.your.base.are.belong.to.us>
 <ZOpAjkTtA4jYtuIa@nam-dell>
 <87cyz8sy4y.fsf@all.your.base.are.belong.to.us>
 <ZOsKukBz8i+h4Y8j@nam-dell>
 <87y1hw7t5p.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1hw7t5p.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 27, 2023 at 11:04:34AM +0200, Björn Töpel wrote:
> Nam Cao <namcaov@gmail.com> writes:
> 
> > On Sun, Aug 27, 2023 at 10:11:25AM +0200, Björn Töpel wrote:
> >> The default implementation of is_trap_insn() which RISC-V is using calls
> >> is_swbp_insn(), which is doing what your patch does. Your patch does not
> >> address the issue.
> >
> > is_swbp_insn() does this:
> >
> >         #ifdef CONFIG_RISCV_ISA_C
> >                 return (*insn & 0xffff) == UPROBE_SWBP_INSN;
> >         #else
> >                 return *insn == UPROBE_SWBP_INSN;
> >         #endif
> >
> > ...so it doesn't even check for 32-bit ebreak if C extension is on. My patch
> > is not the same.
> 
> Ah, was too quick.
> 
> AFAIU uprobes *always* uses c.ebreak when CONFIG_RISCV_ISA_C is set, and
> ebreak otherwise. That's the reason is_swbp_insn() is implemented like
> that.

That's what I understand too.

> If that's not the case, there's a another bug, that your patches
> addresses.

I think it's a bug regardless. is_trap_insn() is used by uprobes to figure out
if there is an instruction that generates trap exception, not just instructions
that are "SWBP". The reason is because when there is a trap, but uprobes doesn't
see a probe installed here, it needs is_trap_insn() to figure out if the trap
is generated by ebreak from something else, or because the probe is just removed.
In the latter case, uprobes will return back, because probe has already been removed,
so it should be safe to do so. That's why I think the incorrect is_swbp_insn()
would cause a hang, because uprobes incorrectly thinks there is no ebreak there,
so it should be okay to go back, but there actually is.

So, from my understanding, if uprobes encounter a 32-bit ebreak for any reason,
the kernel would hang. I think your patch is a great addition nonetheless, but I
am guessing that it only masks the problem by preventing uprobes from seeing the
32-bit ebreak in the specific test, not really solve it. So, if there is a 32-bit
ebreak in userspace, the bug still causes the kernel to hang.

I am still quite confident of my logic, so I would be very suprised if my fix
doesn't solve the reported hang. Do you mind testing my patch? My potato of a
laptop unfortunately cannot run the test :(

Best regards,
Nam

