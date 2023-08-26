Return-Path: <bpf+bounces-8757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA07898B2
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9161C20904
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38474100CC;
	Sat, 26 Aug 2023 18:31:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DFA53
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 18:31:47 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D91711
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 11:31:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991c786369cso246950866b.1
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693074705; x=1693679505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+UJQr2hCnxXecSS9bbNuxh3r6VB0zAAGeKLbxHDvwWA=;
        b=ZY5x4YYYN9qpVOkqEpCIIfBo8tMBylGbu2z1Y05QhqEA3NApF64DwJLl82S0tTm2LT
         CKi167PjJYVP115gLmohDrJDVF3xM19nwPko0FDBWQVIXVo3wZUm0FMAhyp4t4qW9VLG
         u2I4IX9i5SG/odnmr5vFItV86o9D6MtP0sRRNm2py+J3Rmccu/CLbijC9Y7Pis4R51SX
         GeW8LMy5u2YTQ8rzsLAlVNnJFm0hQhQrHCmAJ5I6baKNjOpdizuAlCFWVR16Wlg4ugXQ
         TWFEqZ891YNe9423wNzEpLrPZ+5Fdb5QSqqPINakdEfToW3J2N6WHAezlJWBt4Dkm95p
         aCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693074705; x=1693679505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UJQr2hCnxXecSS9bbNuxh3r6VB0zAAGeKLbxHDvwWA=;
        b=Y1dbxiBMup6AEQ8m4Qutj0NVab+rYs08FKliYYM33r0TXPOYMdhzx1c7AZ3oRQqQov
         9yhIuHp2XXcwUNtlTU/9UnJm7sHv9+h2iW6zvDb6U5SgQisPN0w+rukkneb5BpP4bOCB
         NpKcs7t1pAgoJpgszvY5s5uZI5BN1aSpoQpbE054b4JwIneMjXuMdWHuyYmQ3+DckcXc
         m0hzmRNnBGP/3ShcqslNpkhtylShX8xOLcvis4G1Q02JyUMAD0nvTRC7oy0rnW6QQtT3
         ppdvvt5RSqJufpx2zneDr7HzXx+q3aPVEQgsEN3QVxq262FFjq+PaLxQwumgJ2ZCObyJ
         8y2g==
X-Gm-Message-State: AOJu0YwQIsPUigMmV7yrlkOfGWrI71esMdgSdO/ohCGcAnhOFByKyFY1
	0oOZncJKRb138XWtk4/DT0o=
X-Google-Smtp-Source: AGHT+IECbG3m5ZTwBp8m0310WyiPwYIcaK3SXszCxf7bpYqK78t1mfuk+rPCWQCD2WsFl8PK4JmYNA==
X-Received: by 2002:a17:906:2009:b0:99b:dd38:864d with SMTP id 9-20020a170906200900b0099bdd38864dmr15776429ejo.23.1693074704819;
        Sat, 26 Aug 2023 11:31:44 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id fj9-20020a1709069c8900b00992e265495csm2474479ejc.212.2023.08.26.11.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 11:31:44 -0700 (PDT)
Date: Sat, 26 Aug 2023 20:31:43 +0200
From: Nam Cao <namcaov@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
	bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
Message-ID: <ZOpFD3W3RfiqOoWn@nam-dell>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <87v8d19aun.fsf@all.your.base.are.belong.to.us>
 <ZOpAjkTtA4jYtuIa@nam-dell>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOpAjkTtA4jYtuIa@nam-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 08:12:30PM +0200, Nam Cao wrote:
> On Sat, Aug 26, 2023 at 03:44:48PM +0200, Björn Töpel wrote:
> > Björn Töpel <bjorn@kernel.org> writes:
> > 
> > > I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
> > > selftests on bpf-next 9e3b47abeb8f.
> > >
> > > I'm able to reproduce the hang by multiple runs of:
> > >  | ./test_progs -a link_api -a linked_list
> > > I'm currently investigating that.
> > 
> > +Guo for uprobe
> > 
> > This was an interesting bug. The hang is an ebreak (RISC-V breakpoint),
> > that puts the kernel into an infinite loop.
> > 
> > To reproduce, simply run the BPF selftest:
> > ./test_progs -v -a link_api -a linked_list
> > 
> > First the link_api test is being run, which exercises the uprobe
> > functionality. The link_api test completes, and test_progs will still
> > have the uprobe active/enabled. Next the linked_list test triggered a
> > WARN_ON (which is implemented via ebreak as well).
> > 
> > Now, handle_break() is entered, and the uprobe_breakpoint_handler()
> > returns true exiting the handle_break(), which returns to the WARN
> > ebreak, and we have merry-go-round.
> > 
> > Lucky for the RISC-V folks, the BPF memory handler had a WARN that
> > surfaced the bug! ;-)
> 
> Thanks for the analysis.
> 
> I couldn't reproduce the problem, so I am just taking a guess here. The problem
> is bebcause uprobes didn't find a probe point at that ebreak instruction. However,
> it also doesn't think a ebreak instruction is there, then it got confused and just
> return back to the ebreak instruction, then everything repeats.
> 
> The reason why uprobes didn't think there is a ebreak instruction is because
> is_trap_insn() only returns true if it is a 32-bit ebreak, or 16-bit c.ebreak if
> C extension is available, not both. So a 32-bit ebreak is not correctly recognized
> as a trap instruction.

I feel like I wasn't very clear with this: I was talking about handle_swbp() in
kernel/events/uprobes.c. In this function, the call to find_active_uprobe() should
return false. Then uprobes check if the trap instruction is still there by
calling is_trap_insn(), who correctly says "no". So uprobes assume it is safe to
just comeback to that address. If is_trap_insn() correctly returns true, then
uprobes would know that this is a ebreak, but not a probe, and handle thing correctly.

Best regards,
Nam

