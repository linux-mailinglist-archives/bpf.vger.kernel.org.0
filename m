Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C674C69B10B
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 17:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBQQgN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 11:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBQQgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 11:36:12 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C9273E;
        Fri, 17 Feb 2023 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Gdyv0sz3iT3aR1Tw+q96FRim+vKlFcBoswmtm8cac7s=; b=jI1aFWf8eQ8rZPQQ+c7kq1tee9
        ++p9oEkPbQNBkqioh8+54XwH0116L4IWG9lIwjKcZPHLAXRWRqXxheXERKzRpjTA8CKbkdhP+R2CH
        E7lE/0YWNBp6nOhiv+nj0JTr0mg4fDacUpAv+uzAti+6a13Fl5FGlInKBrHLSxmtgvcnk9Dbik6pA
        0BWBW2GJXLptsweViDwtAdkOpFcdFTGavF4owIHjSORoyIa1OnqXZ/B1ueYfTqNHoh/ZaKpsLJlNH
        DcYp8yuzCz0e2G4WZpzDjhyjzBoa9U85x84WH+oJL0xRUp2jjqKkg2vt2B+sb9rZppiWSgg+85aSb
        PSSkALFA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pT3iP-000IhI-0Z; Fri, 17 Feb 2023 17:36:05 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pT3iO-0007l7-O1; Fri, 17 Feb 2023 17:36:04 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove not used headers
To:     Stanislav Fomichev <sdf@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
References: <1676533861-27508-1-git-send-email-yangtiezhu@loongson.cn>
 <Y+52auqAlfPy/cNS@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a07641f4-5d92-94c0-9ca6-963c27869fc8@iogearbox.net>
Date:   Fri, 17 Feb 2023 17:36:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <Y+52auqAlfPy/cNS@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26815/Fri Feb 17 09:41:01 2023)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/23 7:31 PM, Stanislav Fomichev wrote:
> On 02/16, Tiezhu Yang wrote:
>> The following three uapi headers:
> 
>>      tools/arch/arm64/include/uapi/asm/bpf_perf_event.h
>>      tools/arch/s390/include/uapi/asm/bpf_perf_event.h
>>      tools/arch/s390/include/uapi/asm/ptrace.h
> 
>> were introduced in commit 618e165b2a8e ("selftests/bpf: sync kernel headers
>> and introduce arch support in Makefile"), they are not used any more after
>> commit 720f228e8d31 ("bpf: fix broken BPF selftest build"), so remove them.
> 
> Let's maybe CC Arnaldo to make sure it doesn't affect perf? BPF build
> bots are happy it seems.
> 
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   tools/arch/arm64/include/uapi/asm/bpf_perf_event.h |   9 -
>>   tools/arch/s390/include/uapi/asm/bpf_perf_event.h  |   9 -
>>   tools/arch/s390/include/uapi/asm/ptrace.h          | 458 ---------------------
>>   3 files changed, 476 deletions(-)
>>   delete mode 100644 tools/arch/arm64/include/uapi/asm/bpf_perf_event.h
>>   delete mode 100644 tools/arch/s390/include/uapi/asm/bpf_perf_event.h
>>   delete mode 100644 tools/arch/s390/include/uapi/asm/ptrace.h

Lgtm, I think test_verifier.c was the only user via ...

   - include/uapi/linux/bpf_perf_event.h
     -> include/uapi/asm/bpf_perf_event.h
        -> arch/*/include/uapi/asm/bpf_perf_event.h

... but we're actually pulling in the arch includes instead of the tooling
arch include. So these look indeed unused.
