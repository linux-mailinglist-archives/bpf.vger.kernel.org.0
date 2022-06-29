Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E055FC7A
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 11:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiF2JxY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiF2JxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 05:53:23 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA14617E2C
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 02:53:21 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o6UNl-000Bmq-CW; Wed, 29 Jun 2022 11:53:13 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1o6UNl-000GD0-6J; Wed, 29 Jun 2022 11:53:13 +0200
Subject: Re: [PATCH v2 bpf-next 01/15] libbpf: move xsk.{c,h} into
 selftests/bpf
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, kernel-team@fb.com,
        Magnus Karlsson <magnus.karlsson@gmail.com>
References: <20220627211527.2245459-1-andrii@kernel.org>
 <20220627211527.2245459-2-andrii@kernel.org> <YrweLB7omwEe/cR1@boxer>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <014b5bf0-61b5-3510-0468-515c762247e1@iogearbox.net>
Date:   Wed, 29 Jun 2022 11:53:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YrweLB7omwEe/cR1@boxer>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26588/Wed Jun 29 10:21:17 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Maciej,

On 6/29/22 11:41 AM, Maciej Fijalkowski wrote:
> On Mon, Jun 27, 2022 at 02:15:13PM -0700, Andrii Nakryiko wrote:
>> Remove deprecated xsk APIs from libbpf. But given we have selftests
>> relying on this, move those files (with minimal adjustments to make them
>> compilable) under selftests/bpf.
>>
>> We also remove all the removed APIs from libbpf.map, while overall
>> keeping version inheritance chain, as most APIs are backwards
>> compatible so there is no need to reassign them as LIBBPF_1.0.0 versions.
> 
> Hey Andrii,
> 
> First of all, great that you are moving this over to selftests where we
> can use this as the base for our upcoming control path tests. However,
> during some of our selftests work we have found a bug in the xsk part of
> libbpf that you're moving here. What is the way forward to fixing this
> from your perspective? Should we wait once this set lands so that we would
> fix this in the xsk.c file in selftests/bpf? Or would you pick the bugfix
> before doing the move?

Just to answer this question, fwiw, the set has been applied yesterday to bpf-next
tree [0], so from an upstream PoV, please send a relative fix for xsk.c file in
selftests/bpf/.

Thanks,
Daniel

   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=f36600634282a519e1b0abea609acdc8731515d7
