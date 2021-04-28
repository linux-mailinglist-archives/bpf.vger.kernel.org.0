Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7936D5F1
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhD1Kty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 06:49:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:47648 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbhD1Ktx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 06:49:53 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lbhki-0000Q7-Ae; Wed, 28 Apr 2021 12:49:08 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lbhki-000SS2-6u; Wed, 28 Apr 2021 12:49:08 +0200
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for bpf_skb_change_head
To:     Jussi Maki <joamaki@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <20210427135550.807355-1-joamaki@gmail.com>
 <20210427135550.807355-2-joamaki@gmail.com>
 <CAEf4BzZ8iQ=ewupN0COpV78k+fhGvPZ4NHcqckZcQcmV=A6QXw@mail.gmail.com>
 <CAHn8xckARwp_yK477xTvzFCwU9oBwAoZ4D2erg6HRmoe5in3Xg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5f7259ab-05a5-1e30-a87e-6ae5672c50f1@iogearbox.net>
Date:   Wed, 28 Apr 2021 12:49:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHn8xckARwp_yK477xTvzFCwU9oBwAoZ4D2erg6HRmoe5in3Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26153/Tue Apr 27 13:09:27 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/28/21 12:39 PM, Jussi Maki wrote:
> On Tue, Apr 27, 2021 at 11:41 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>> ...
>>> +test_tc_peer_user
>>
>> can we make it into a reasonable test inside test_progs? that way it
>> will be executed regularly
> 
> There doesn't seem to be any tests yet for redirect_peer in test_progs and I'd
> like this test to live next to them. Would it make sense to rework
> test_tc_redirect.sh
> into the test_progs framework?
> 
> What's your thoughts on this Daniel?

Yes, please, that would be awesome to have test_tc_redirect.sh reworked to
run as part of test_progs! :) Then it will be covered by CI [0].

Thanks,
Daniel

   [0] https://travis-ci.com/github/kernel-patches/bpf/pull_requests
