Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142B54B3202
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 01:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbiBLAaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 19:30:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiBLAaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 19:30:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6DD7E
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 16:30:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 571082113D;
        Sat, 12 Feb 2022 00:30:11 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABC9A13C5E;
        Sat, 12 Feb 2022 00:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t69xIZL/BmJPDgAAMHmgww
        (envelope-from <mrostecki@opensuse.org>); Sat, 12 Feb 2022 00:30:10 +0000
Message-ID: <2b39d482-f31c-783f-2104-07a972dae5f3@opensuse.org>
Date:   Sat, 12 Feb 2022 00:30:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Question about LSM with eBPF
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>
References: <885e8924a6704f5181c8d774e0a8f74c@huawei.com>
From:   Michal Rostecki <mrostecki@opensuse.org>
In-Reply-To: <885e8924a6704f5181c8d774e0a8f74c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/11/22 11:57, Roberto Sassu wrote:
> Hi
> 
> I'm working on an LSM implemented with eBPF. I have a
> question about persistence. Is it possible to keep the
> attached LSM running without the user space process
> that attached it?
> 
> Thanks
> 
> Roberto
> 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Zhong Ronghua
> 

Hi Roberto,

Yes, it's possible if you pin the program in BPFFS.

If you are using libbpf, you can use the bpf_program__pin function:

https://github.com/libbpf/libbpf/blob/master/src/libbpf.h#L349-L359

If you are using libbpf-rs:

https://docs.rs/libbpf-rs/0.16.0/libbpf_rs/struct.Program.html#method.pin

If you are using Aya:

https://docs.rs/aya/0.10.6/aya/programs/enum.Program.html#method.pin

Cheers,
Michal
