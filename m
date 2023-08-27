Return-Path: <bpf+bounces-8809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F078A157
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 22:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D66D280E8F
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B251427B;
	Sun, 27 Aug 2023 20:15:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A932111A3
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 20:15:42 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C94107
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 13:15:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5009d4a4897so3859821e87.0
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693167338; x=1693772138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SrKEJGHd7TFgfnwuuBL555hEAHUEGfveeoECEz3v1Ms=;
        b=prJAmeeaHjuu+lnder/uGA+ufTDAYPx6+HBktkYuoJm+bCfJkiRiV66tab0gmZL7JW
         FXheMG8bkfZ/qVB0NFdrSt2xMBvzL/BGnIPpqxPWUyvAuxU3cISvSkjoZn1cugFRZtBy
         t6NLQ4oGsqcJMi+TwHZBQQJ9/KAp33vDzxP/11ath2TRCkIC/nc4U5uwxSnBeC7fMVaA
         bwYTbZ2YZYoRH4bilkguWQ0aMdTySIZDNKBrmd/j3ynLElKwXXnY0W3NYbmfTS6tLI7K
         Qz+obSnQ8si/iZsoUroKDzbq2oiLurTV7LQRZCpkN8B6c98XUq6+0gsPdDsTeJLt+iyB
         fEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693167338; x=1693772138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrKEJGHd7TFgfnwuuBL555hEAHUEGfveeoECEz3v1Ms=;
        b=lan1xI+7eMJi1xqzyasOXfr3/NAMehmisr2v2mHruSZF696bzoK4K89SvFpVeWIKRM
         LanIywi19vcsqlqxnOnGi5crZmsoeSs3M3uvbECAm+8Q/f1lj0qRj+Snhf/Dx4EU040m
         w4+Za1MLIotl+ZSXmVxkNkmOxkKdvu6ljQy8OYJxrwBLPIb1N8BwUK2ClY05VrEYzbuC
         li+N20d5bInaFXfzesng62gEFMTkoNvCPhWCKj8Qu83BL7n8RJa81YLHt0OIY7NIkTkS
         CZPD4zGb32CKOH5e309NSowc2m4VF89AO78YWk3BZmLlNVNCXnDjcxb7saKJqql5NYKv
         vNuQ==
X-Gm-Message-State: AOJu0YzDxJh5bm+Z6FzQ+5/l4usICmeQqJg0mXKp4RpDO6cNR4/7wyco
	wDj5kGE3xIL58AJOoKEmFWQ=
X-Google-Smtp-Source: AGHT+IGQ7wjtuWvg9Wkb9joTEwQ1eh1wDuqLsIKGCZVMBRyKXURHrDrpqQdFveAyVKtXPfnzQ4cjyw==
X-Received: by 2002:a05:6512:224e:b0:4fd:c84f:30c9 with SMTP id i14-20020a056512224e00b004fdc84f30c9mr20202851lfu.47.1693167338131;
        Sun, 27 Aug 2023 13:15:38 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id v21-20020aa7d655000000b0051e22660835sm3654885edr.46.2023.08.27.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 13:15:37 -0700 (PDT)
Date: Sun, 27 Aug 2023 22:15:36 +0200
From: Nam Cao <namcaov@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
	bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
Message-ID: <ZOuu6IF2Cf6OaJzg@nam-dell>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <87v8d19aun.fsf@all.your.base.are.belong.to.us>
 <ZOpAjkTtA4jYtuIa@nam-dell>
 <87cyz8sy4y.fsf@all.your.base.are.belong.to.us>
 <ZOsKukBz8i+h4Y8j@nam-dell>
 <87y1hw7t5p.fsf@all.your.base.are.belong.to.us>
 <ZOsZtH+5P0/R6kvd@nam-dell>
 <87jztgwaur.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jztgwaur.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 27, 2023 at 09:20:44PM +0200, Björn Töpel wrote:
> Nam Cao <namcaov@gmail.com> writes:
> 
> > On Sun, Aug 27, 2023 at 11:04:34AM +0200, Björn Töpel wrote:
> >> Nam Cao <namcaov@gmail.com> writes:
> >> 
> >> > On Sun, Aug 27, 2023 at 10:11:25AM +0200, Björn Töpel wrote:
> >> >> The default implementation of is_trap_insn() which RISC-V is using calls
> >> >> is_swbp_insn(), which is doing what your patch does. Your patch does not
> >> >> address the issue.
> >> >
> >> > is_swbp_insn() does this:
> >> >
> >> >         #ifdef CONFIG_RISCV_ISA_C
> >> >                 return (*insn & 0xffff) == UPROBE_SWBP_INSN;
> >> >         #else
> >> >                 return *insn == UPROBE_SWBP_INSN;
> >> >         #endif
> >> >
> >> > ...so it doesn't even check for 32-bit ebreak if C extension is on. My patch
> >> > is not the same.
> >> 
> >> Ah, was too quick.
> >> 
> >> AFAIU uprobes *always* uses c.ebreak when CONFIG_RISCV_ISA_C is set, and
> >> ebreak otherwise. That's the reason is_swbp_insn() is implemented like
> >> that.
> >
> > That's what I understand too.
> >
> >> If that's not the case, there's a another bug, that your patches
> >> addresses.
> >
> > I think it's a bug regardless. is_trap_insn() is used by uprobes to figure out
> > if there is an instruction that generates trap exception, not just instructions
> > that are "SWBP". The reason is because when there is a trap, but uprobes doesn't
> > see a probe installed here, it needs is_trap_insn() to figure out if the trap
> > is generated by ebreak from something else, or because the probe is just removed.
> > In the latter case, uprobes will return back, because probe has already been removed,
> > so it should be safe to do so. That's why I think the incorrect is_swbp_insn()
> > would cause a hang, because uprobes incorrectly thinks there is no ebreak there,
> > so it should be okay to go back, but there actually is.
> >
> > So, from my understanding, if uprobes encounter a 32-bit ebreak for any reason,
> > the kernel would hang. I think your patch is a great addition nonetheless, but I
> > am guessing that it only masks the problem by preventing uprobes from seeing the
> > 32-bit ebreak in the specific test, not really solve it. So, if there is a 32-bit
> > ebreak in userspace, the bug still causes the kernel to hang.
> >
> > I am still quite confident of my logic, so I would be very suprised if my fix
> > doesn't solve the reported hang. Do you mind testing my patch? My potato of a
> > laptop unfortunately cannot run the test :(
> 
> Maybe I wasn't clear, sorry for that! I did take the patch for a spin,
> and it did not solve this particular problem.
> 
> When we're taking a trap from *kernel*mode, we should never deal with
> uprobes at all. Have a look at uprobe_pre_sstep_notifier(), this
> function returns 1, which then means that the trap handler exit
> premature.
> 
> The code you're referring to (called from uprobe_notify_resume()), and
> will never be entered, because we're not exiting the trap to
> userland. Have a look in kernel/entry/common.c (search for
> e.g. TIF_UPROBE).

Ah right, uprobe_notify_resume() is not called if we do not return to user
space. My bad, I thought it is called. Thanks for the discussion, now why I can
see my patch is irrelevant, and your patch is the correct fix for the reported
problem.

Best regards,
Nam

