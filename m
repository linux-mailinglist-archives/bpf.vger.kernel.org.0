Return-Path: <bpf+bounces-5713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10AE75F649
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E2D1C20B77
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED58BFD;
	Mon, 24 Jul 2023 12:27:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE97498
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 12:27:34 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F4110CB;
	Mon, 24 Jul 2023 05:27:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so40999905e9.1;
        Mon, 24 Jul 2023 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690201648; x=1690806448;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWM93a9xu6qm4bqV/ft0sQuj37BqnW4nnz/nyihWvyk=;
        b=qO7HYU0kl3lmlv91vLm2frzUvgIIcr/xv62HYg7vRMOsA1rTV4UhDhHJJNY/UNXSk7
         Oyi+xR1ONajaFHBdjsY59qfuIrsEDNEAazUdOxkHqpwgo3S6YmmTHrQWTyxnxNnc+g0L
         hFn0Rg8R+Dmahmdg6llDxzFXBoN3nYT+gE4DJ+XpEM0kPFc1g0Ybnf7JInOg5vigE1Hh
         DVbpXQt9I5Eamy1WuJUut768365Of4jeJsu9Qt0MGPqPA2ANeTZ2lJo9aeECHfhGhjK8
         qLZjtzNdhWHcOLrYRMTzYuHl18I5nhOawkZPfqJwB2ekPZWV8gkwdLtkLJMKIAqBB3sB
         3bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690201648; x=1690806448;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SWM93a9xu6qm4bqV/ft0sQuj37BqnW4nnz/nyihWvyk=;
        b=fvDAUT5C1fxe/Aph9Rb2aixvzzce7RkdsaUDXrsY9iWOHdybFgiEkaVy7mdqHnie49
         KcgWFl+LkyMT5ZQBIQ3wpF8u8TFbb5m9hIVLaq2DmL3V9dLF0VnOJdS00kjvZVVACjXK
         yx/Why35SYSMmWl4ZeMQ6gAtapjApac/9NXFqOfiKMscMxV8UKHBRNxkLTrOzJVr0Hnb
         W5Anl1RsR0ktjpGu6JWdk6d9TjgbA9HVI5D+gKV70a5Zj3OAx9wdOgu7DUhKdg1C7djZ
         UPZBv9OIANnDDTwmbFqgpP+v8VQK1Lxxa4OPSLLoYpHxpDiykDox1S1KUrUPqr+bPsId
         btJA==
X-Gm-Message-State: ABy/qLYq2lQ6JXVGFUQSg56iVYvmYZyN3svIddp5fk+OqdCeaNfCr4jb
	EnF6JCKhwRQQYnTMVm0Pi4j4Kkf8g3s=
X-Google-Smtp-Source: APBJJlFfX4JupHVdcocdDdxAtai6IVeZqCcBHiRZQ08wzVfXyG/pYCDFjufiN62ne4tPmWbdTZmFdA==
X-Received: by 2002:a5d:69c3:0:b0:315:96ca:dcab with SMTP id s3-20020a5d69c3000000b0031596cadcabmr8418583wrw.35.1690201648414;
        Mon, 24 Jul 2023 05:27:28 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id n8-20020adfe348000000b00315af025098sm12840340wrj.46.2023.07.24.05.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 05:27:27 -0700 (PDT)
Message-ID: <bcf97046-e336-712a-ac68-7fd194f2953e@gmail.com>
Date: Mon, 24 Jul 2023 13:27:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Youling Tang <tangyouling@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 "bpf@vger.kernel.org >> bpf" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: LoongArch: Add BPF JIT support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Static analysis with clang scan build on arch/loongarch/net/bpf_jit.h 
has detected a potential issue with the following commit:

commit 5dc615520c4dfb358245680f1904bad61116648e
Author: Tiezhu Yang <yangtiezhu@loongson.cn>
Date:   Wed Oct 12 16:36:20 2022 +0800

     LoongArch: Add BPF JIT support

This issue is as follows:

arch/loongarch/net/bpf_jit.h:153:23: warning: Logical disjunction always 
evaluates to true: imm_51_31 != 0 || imm_51_31 != 0x1fffff. 
[incorrectLogicOperator]
    if (imm_51_31 != 0 || imm_51_31 != 0x1fffff) {


The statement seems to be always true. I suspect it should it be instead:

    if (imm_51_31 != 0 && imm_51_31 != 0x1fffff) {

regards,

Colin

