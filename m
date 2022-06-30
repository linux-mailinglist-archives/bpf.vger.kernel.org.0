Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD15624AA
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiF3U5k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiF3U5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 16:57:39 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C44D15D
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 13:57:38 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o71EH-00008W-G5; Thu, 30 Jun 2022 22:57:37 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1o71EH-000Qru-CI; Thu, 30 Jun 2022 22:57:37 +0200
Subject: Re: test_kmod.sh fails with constant blinding
To:     Yauheni Kaliuta <ykaliuta@redhat.com>, bpf <bpf@vger.kernel.org>
References: <CANoWsw=eP+kYHvT+AUwY=8D=QDrwHz=1_6he8vz0t+Tc1PVVBQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6e86e8c4-4eaf-3e4e-ee72-035a215b48d3@iogearbox.net>
Date:   Thu, 30 Jun 2022 22:57:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANoWsw=eP+kYHvT+AUwY=8D=QDrwHz=1_6he8vz0t+Tc1PVVBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26589/Thu Jun 30 10:08:14 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/30/22 3:19 PM, Yauheni Kaliuta wrote:
> Hi!
> 
> test_kmod.sh fails for hardened 2 check with
> 
>   test_bpf: #964 Staggered jumps: JMP_JA FAIL to select_runtime err=-524
> 
> (-ERANGE during constant blinding)
> 
> Did I miss something?

That could be expected if one of bpf_adj_delta_to_imm() / bpf_adj_delta_to_off()
fails given the targets go out of range.

How do the generated insn look?

Thanks,
Daniel
