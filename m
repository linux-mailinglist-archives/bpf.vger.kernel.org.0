Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2259F82D
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiHXKuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiHXKux (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 06:50:53 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE265255BF
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 03:50:46 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oQny1-000CNE-Lp; Wed, 24 Aug 2022 12:50:37 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oQny1-0008WA-83; Wed, 24 Aug 2022 12:50:37 +0200
Subject: Re: [PATCH bpf-next,v2] selftests/bpf: add lwt ip encap tests to
 test_progs
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org
References: <20220822130820.1252010-1-eyal.birger@gmail.com>
 <3d69a390-f503-e3b8-78ab-b74f5d32e84d@iogearbox.net>
 <CAHsH6GvHZJtgfaKcpeyuut9ChbO5EmY27XpjJPyr73ZVbSuktQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <171beda2-c826-d9b0-b953-5da098f9a3e7@iogearbox.net>
Date:   Wed, 24 Aug 2022 12:50:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHsH6GvHZJtgfaKcpeyuut9ChbO5EmY27XpjJPyr73ZVbSuktQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26637/Wed Aug 24 09:53:01 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/24/22 1:10 AM, Eyal Birger wrote:
> Hi Daniel,
> 
> On Wed, Aug 24, 2022 at 1:43 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 8/22/22 3:08 PM, Eyal Birger wrote:
>>> Port test_lwt_ip_encap.sh tests onto test_progs.
>>>
>>> In addition, this commit adds "egress_md" tests which test a similar
>>> flow as egress tests only they use gre devices in collect_md mode
>>> for encapsulation and set the tunnel key using bpf_set_tunnel_key().
>>>
>>> This introduces minor changes to test_lwt_ip_encap.{sh,c} for consistency
>>> with the new tests:
>>>
>>> - GRE key must exist as bpf_set_tunnel_key() explicitly sets the
>>>     TUNNEL_KEY flag
>>>
>>> - Source address for GRE traffic is set to IP*_5 instead of IP*_1 since
>>>     GRE traffic is sent via veth5 so its address is selected when using
>>>     bpf_set_tunnel_key()
>>>
>>> Note: currently these programs use the legacy section name convention
>>> as iproute2 lwt configuration does not support providing function names.
>>>
>>> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
>> [...]
>>
>> Thanks for following up. Is there now anything that test_lwt_ip_encap.c
>> doesn't cover over test_lwt_ip_encap.sh? If not, I'd vote for removing
>> the latter given the port is then covered in CI via test_progs.
> 
> The .c version includes all tests in the .sh and two more.
> At least when I tried using vmtest the .sh version seems broken.
> 
> I can resubmit with an additional patch removing it, or send a follow
> up patch as you prefer.

+1, could you squash the removal into the single patch and submit as a v3?

Thanks a lot,
Daniel
