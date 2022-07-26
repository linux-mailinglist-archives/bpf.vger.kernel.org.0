Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54009581579
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiGZOhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGZOhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 10:37:20 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1741166
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 07:37:17 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oGLgO-0003q6-Ks; Tue, 26 Jul 2022 16:37:12 +0200
Received: from [2a01:118f:505:3400:57f9:d43a:5622:24a8] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oGLgO-000Omw-Bz; Tue, 26 Jul 2022 16:37:12 +0200
Subject: Re: [PATCH bpf-next v2 0/2] Fix test_probe_user on s390x
To:     Jiri Olsa <olsajiri@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20220726134008.256968-1-iii@linux.ibm.com>
 <Yt/2yTe3CSKApQui@krava>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b84d15d7-ba21-8b21-3338-9092ef237090@iogearbox.net>
Date:   Tue, 26 Jul 2022 16:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <Yt/2yTe3CSKApQui@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26613/Tue Jul 26 09:56:56 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/26/22 4:14 PM, Jiri Olsa wrote:
> On Tue, Jul 26, 2022 at 03:40:06PM +0200, Ilya Leoshkevich wrote:
>> Hi,
>>
>> This is a fix for [1]: test_probe_user fails on s390x, because it hooks
>> only connect(), but not socketcall(SYS_CONNECT).
>>
>> Patch 1 adds this quirk to BPF_KSYSCALL documentation.
>> Patch 2 fixes the test by attaching a prog to socketcall().
>>
>> Best regards,
>> Ilya
>>
>> [1] https://lore.kernel.org/bpf/06631b122b9bd6258139a36b971bba3e79543503.camel@linux.ibm.com/
>>
>> v1: https://lore.kernel.org/bpf/20220723020344.21699-1-iii@linux.ibm.com/
>> v1 -> v2: Add CONFIG_ prefix to CLONE_BACKWARDS* symbols (Jiri).
>>            Change the type of prog_names to make checkpatch happy.
>>            Use prog_count everywhere (Jiri).
>>            #ifdef out handle_sys_socketcall() on non-s390x (Jiri).
> 
> LGTM
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 

Applied, thanks Ilya!
