Return-Path: <bpf+bounces-9363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6879434C
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 20:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EB92815C3
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 18:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA323111A3;
	Wed,  6 Sep 2023 18:51:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5396AB1
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 18:51:19 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6B1738
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 11:51:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso971895ad.1
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694026275; x=1694631075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQpveLuX0FUvjuwD4dGyYyZDS0eYrWbcLN2fWSij0iA=;
        b=Lh0njkiDXqesDcF9F0sgQ8qNf8dF/hxEm1Qdu+MbfJRZz9LqnrbQ/QRx95daGo5wz8
         Lu7g9/4LSvLtckW/TrKwjJg3kN9T0OHkikwlOVni9hqMCVKyI4OSx79sm3ujH43Sznap
         zTQwgb47CUqcj9injRxBRFpVi82H5CnN6bGIW+AFr14hpCF8p7vPAI+2eQ5YC9qjUIPf
         19CjCDdDpOS5uLWQOW0j1Pih7yUl00SPyCYO0/F/ZKAZEELVhd9To9fN/7l6KejyoDc/
         CIT5Lun9q24BWjth30peIQVlTNOo/7iQk9QJOA6dR94XFdtdZ4hfQL13J1Vdxku3qHv2
         iUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026275; x=1694631075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQpveLuX0FUvjuwD4dGyYyZDS0eYrWbcLN2fWSij0iA=;
        b=j9/Bch8vMnr6LsiI0Y1LJ+68Qa2OwP+aRjhwjqoMzhu1Gs1e385WH8IHf/P43JgrUv
         gXbpI/YuaRaZye77cV0c995WRUllO8R8z8zSXQYQWBMvGVaTAETkSu/2Z/iOAbcR8kbA
         oxOM0ny19NNj+ZHvjQZifXQMjh76RSRFJzbYade9R7YZ7ayegUJL46NcqHhrs4tV5F5f
         hrpBA33yLefDUrIbSnyxhhlL+D6pi6cMITnv0ihVrtuZFi3qNQvxgJWAX/i3Hc0EOuEg
         C50muACuwh2T2Cw3BGHOIusQkyiswd7lAX3pCfhAO1ER/cNQiWpV1aJiiZNNbsVgliw4
         Rj9Q==
X-Gm-Message-State: AOJu0YxJtwX9WcidzI5Fmd1dv32ecTYGCfvnX53cnj2jZFEk/qleAkpL
	FmVMYta2BwW38EThBgh09iD5XA==
X-Google-Smtp-Source: AGHT+IHUCKPBvm+y4ZSnJx6E4oEoYCsWpR9RPBg93vTI0YIyf1mDbs5Z8RbtKmorODld7KsvQCj4Fg==
X-Received: by 2002:a17:902:dad2:b0:1c3:5f05:922a with SMTP id q18-20020a170902dad200b001c35f05922amr2910308plx.60.1694026274955;
        Wed, 06 Sep 2023 11:51:14 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001befac3b3cbsm11407084plq.290.2023.09.06.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:51:14 -0700 (PDT)
Date: Wed, 6 Sep 2023 11:51:05 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, jrtc27@jrtc27.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	bpf@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, rostedt@goodmis.org,
	Ard Biesheuvel <ardb@kernel.org>, anup@brainfault.org,
	atishp@atishpatra.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	bjorn@kernel.org, luke.r.nels@gmail.com, xi.wang@gmail.com,
	namcaov@gmail.com
Subject: Re: [PATCH 00/10] RISC-V: Refactor instructions
Message-ID: <ZPjKGd7VstwIKDV5@ghost>
References: <ZN5OJO/xOWUjLK2w@ghost>
 <mhng-7d609dde-ad47-42ed-a47b-6206e719020a@palmer-ri-x1c9a>
 <20230818-63347af7195b7385c146778d@orel>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-63347af7195b7385c146778d@orel>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 09:30:32AM +0200, Andrew Jones wrote:
> On Thu, Aug 17, 2023 at 10:52:22AM -0700, Palmer Dabbelt wrote:
> > On Thu, 17 Aug 2023 09:43:16 PDT (-0700), Charlie Jenkins wrote:
> ...
> > > It seems to me that it will be significantly more challenging to use
> > > riscv-opcodes than it would for people to just hand create the macros
> > > that they need.
> > 
> > Ya, riscv-opcodes is pretty custy.  We stopped using it elsewhere ages ago.
> 
> Ah, pity I didn't know the history of it or I wouldn't have suggested it,
> wasting Charlie's time (sorry, Charlie!). So everywhere that needs
> encodings are manually scraping them from the PDFs? Or maybe we can write
> our own parser which converts adoc/wavedrom files[1] to Linux C?
> 
> [1] https://github.com/riscv/riscv-isa-manual/tree/main/src/images/wavedrom

The problem with the wavedrom files is that there are no standard for
how each instruction is identified. The title of of the adoc gives some
insight and there is generally a funct3 or specific opcode that is
associated with the instruction but it would be kind of messy to write a
script to parse that. I think manually constructing the instructions is
fine. When somebody wants to add a new instruction they probably will
not need to add very many at a time, so it should be only a couple of
lines that they will be able to test.

> 
> Thanks,
> drew

