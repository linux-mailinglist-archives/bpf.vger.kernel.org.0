Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53D950872F
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 13:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378145AbiDTLls (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378203AbiDTLlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 07:41:46 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742741FA2
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 04:38:59 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23KBccxD031880;
        Wed, 20 Apr 2022 20:38:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Wed, 20 Apr 2022 20:38:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23KBccoa031877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Apr 2022 20:38:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <909c72b6-83f9-69a0-af80-d9cb3bc2bd0e@I-love.SAKURA.ne.jp>
Date:   Wed, 20 Apr 2022 20:38:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: How to disassemble a BPF program?
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <4ed4a01e-3d1e-bf1e-803a-608df187bde5@I-love.SAKURA.ne.jp>
In-Reply-To: <4ed4a01e-3d1e-bf1e-803a-608df187bde5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ping?

Since how to fix this "current top five crasher" bug depends on how a kernel
socket is created via BPF program, this bug wants help from BPF developers.

On 2022/04/12 20:04, Tetsuo Handa wrote:
> Hello.
> 
> I'm not a BPF user, but I want to know what a BPF program stored in
> "static const char program[2053] =" at
> https://lkml.kernel.org/r/c389e47f-8f82-fd62-8c1d-d9481d2f71ff@I-love.SAKURA.ne.jp
> is doing so that I can parse syzkaller-generated BPF programs like C programs.
> 
> Do you have a utility for this purpose?
> 
> Regards.
