Return-Path: <bpf+bounces-5621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3DC75CA35
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8C328232B
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB2F27F0D;
	Fri, 21 Jul 2023 14:38:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267A27F05
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 14:38:27 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB7A30CA
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:38:25 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3DAABC1522BD
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689950298; bh=HpH6Ovzj/f5ZEBkCB4O/zfGwHgPgzEXhr2LhhwWrJ/k=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=nBxHp+nv8DcAbFPk2QODGhZMRsC/dP1pGnkpYy4HtcllMYyoh5z7yf/ODw+zUue5D
	 E6xc39XDog4BPuMZdTx/R91Z3SPd82LINYt0OYEG22ujzgpKCBUNqqorcn2vJjxE4V
	 JeU6yIM7at7PmYpTQsr3pNmPLXFuzP8eFU5p4K0E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 21 07:38:18 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 20A0DC14F73E;
	Fri, 21 Jul 2023 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689950298; bh=HpH6Ovzj/f5ZEBkCB4O/zfGwHgPgzEXhr2LhhwWrJ/k=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=nBxHp+nv8DcAbFPk2QODGhZMRsC/dP1pGnkpYy4HtcllMYyoh5z7yf/ODw+zUue5D
	 E6xc39XDog4BPuMZdTx/R91Z3SPd82LINYt0OYEG22ujzgpKCBUNqqorcn2vJjxE4V
	 JeU6yIM7at7PmYpTQsr3pNmPLXFuzP8eFU5p4K0E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3C24AC151B15
 for <bpf@ietfa.amsl.com>; Fri, 21 Jul 2023 07:38:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.096
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=isovalent.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VxmzJUjiVhTm for <bpf@ietfa.amsl.com>;
 Fri, 21 Jul 2023 07:38:13 -0700 (PDT)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CCBBEC14EB17
 for <bpf@ietf.org>; Fri, 21 Jul 2023 07:37:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51e5da802afso2737293a12.3
 for <bpf@ietf.org>; Fri, 21 Jul 2023 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=isovalent.com; s=google; t=1689950251; x=1690555051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XOLceJdmZjVccNbb2nj2ibCXQEfpBWAoSO8sAmi9c8M=;
 b=DJwtb4ZWgnp7VIGznz3E7/UYa5pONWuvHsf6cO1ZZBtuh9CqPjSi3nsonf1rSn9iCn
 HybM6FBVd/qZMNhf/0Iaq5jI0hxKGEwBEkkjARAhZf17t6UJVxS689956xNuhnmx+nIU
 7jjmsyy+0A/DM0VepnDYoY4k65h/MHfz3Ko3rTh+VWpH/pbSv8Sw2eXj00UQ2ztyxVW0
 Tgevqo0Ydc8yzxYVYZUaFSkMFzxmcr2d9QGdEUzrayEYmCWbCeDpfX/n8ghDop6GOrQY
 T/ZIDz9i3CZyIUKDZ/8z5UhkKE+vHissdM6FJHSoteStKjcXGcKlg8AXFo+tMViCZsBz
 isbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689950251; x=1690555051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XOLceJdmZjVccNbb2nj2ibCXQEfpBWAoSO8sAmi9c8M=;
 b=edEIh8QZmIHd1w+Nk34HPAY2vMKV+SdDHyK/Q1b+0APaPG3ggNLuEre+qJ7KAGgJPI
 Ab2/DGEfzkeVgrGyW30tYSSQSs34h9q6x+7Fnn3YLGwSZqdu7uJOu4im07LDXlM/Bygl
 j07dO6JC1mqTABvoao2kA5Cg7iuwm9LL6Z5Cnc5X7zarG1CikrKBYRpjSm3rjBAPKl3K
 RXtzMik2nD2+qLFRVtJ7XCWL/A4E2fIYu+io8ZGiBr4v8KNZSL9mFpial7Og/j/3YP6K
 hlq4t9CUArdJF1e7nZZZ6nwSDSfUVK9kLjM319S1XIa9KsFKgTR4s14WycSagpVg1wt2
 dN9g==
X-Gm-Message-State: ABy/qLYLbWJYfz8ANM6mbgcW7kSuHHzsYUG5F01ob4duYqjOO8hWe++a
 S8KjSs3u01tT/wc5FN7sfsKFuA==
X-Google-Smtp-Source: APBJJlGD6S3kjcxugnLx7RTmaMg1N+G4jctCJIca10RMoMXWJrhCSiZvOJlAcG/heDu34bIYXIKtQA==
X-Received: by 2002:a17:906:538a:b0:997:caf0:9945 with SMTP id
 g10-20020a170906538a00b00997caf09945mr1661920ejo.12.1689950251239; 
 Fri, 21 Jul 2023 07:37:31 -0700 (PDT)
Received: from [192.168.245.158] ([109.190.253.14])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a1709064acf00b00992025654c4sm2226730ejt.182.2023.07.21.07.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 07:37:30 -0700 (PDT)
Message-ID: <1ea8511c-e860-bd2c-3c1e-51ab16314530@isovalent.com>
Date: Fri, 21 Jul 2023 15:36:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 bpf@ietf.org, Daniel Borkmann <daniel@iogearbox.net>,
 Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230720000103.99949-1-yhs@fb.com>
 <20230720000147.105988-1-yhs@fb.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230720000147.105988-1-yhs@fb.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/aOn_nwp-MGCobIZyfFDj3HkLZmA>
Subject: Re: [Bpf] [PATCH bpf-next v3 08/17] bpf: Add kernel/bpftool asm
 support for new instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-07-19 17:01 UTC-0700 ~ Yonghong Song <yhs@fb.com>
> Add asm support for new instructions so kernel verifier and bpftool
> xlated insn dumps can have proper asm syntax for new instructions.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

