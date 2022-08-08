Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4958258C991
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiHHNfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbiHHNfn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 09:35:43 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF0DBC1E;
        Mon,  8 Aug 2022 06:35:41 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oL2uv-00017f-1Q; Mon, 08 Aug 2022 15:35:37 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oL2uu-000SMb-N5; Mon, 08 Aug 2022 15:35:36 +0200
Subject: Re: [PATCH v3 0/8] tools: fix compilation failure caused by
 init_disassemble_info API changes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Andres Freund <andres@anarazel.de>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Ben Hutchings <benh@debian.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de> <YufK0qnvVWCAFGEH@kernel.org>
 <ce9140c7-dd4b-0c4e-db7c-d25022cfe739@isovalent.com>
 <YugVTQ7CoqXRTNBY@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <988ee9d1-7bf5-b4c1-db6f-9195e82c8cb3@iogearbox.net>
Date:   Mon, 8 Aug 2022 15:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YugVTQ7CoqXRTNBY@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26621/Mon Aug  8 09:52:38 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/1/22 8:02 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 01, 2022 at 04:15:19PM +0100, Quentin Monnet escreveu:
>> On 01/08/2022 13:45, Arnaldo Carvalho de Melo wrote:
>>> Em Sun, Jul 31, 2022 at 06:38:26PM -0700, Andres Freund escreveu:
>>>> binutils changed the signature of init_disassemble_info(), which now causes
>>>> compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
>>>> binutils commit:
>>>> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
>>>>
>>>> I first fixed this without introducing the compat header, as suggested by
>>>> Quentin, but I thought the amount of repeated boilerplate was a bit too
>>>> much. So instead I introduced a compat header to wrap the API changes. Even
>>>> tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
>>>> looks nicer this way.
>>>>
>>>> I'm not regular contributor, so it very well might be my procedures are a
>>>> bit off...
>>>>
>>>> I am not sure I added the right [number of] people to CC?
>>>
>>> I think its ok
>>>   
>>>> WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
>>>
>>> I think its related to libbfd, and it comes from a long time ago, trying
>>> to find the cset adding that...
>>>
>>>> nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
>>>> in feature/Makefile and why -ldl isn't needed in the other places. But...
>>>>
>>>> V2:
>>>> - split patches further, so that tools/bpf and tools/perf part are entirely
>>>>    separate
>>>
>>> Cool, thanks, I'll process the first 4 patches, then at some point the
>>> bpftool bits can be merged, alternatively I can process those as well if
>>> the bpftool maintainers are ok with it.
>>>
>>> I'll just wait a bit to see if Jiri and others have something to say.
>>>
>>> - Arnaldo
>>
>> Thanks for this work! For the series:
>>
>> Acked-by: Quentin Monnet <quentin@isovalent.com>
>>
>> For what it's worth, it would make sense to me that these patches remain
>> together (so, through Arnaldo's tree), given that both the perf and
>> bpftool parts depend on dis-asm-compat.h being available.
> 
> Ok, so I'm tentatively adding it to my local tree to do some tests, if
> someone disagrees, please holler.

Ack, sgtm. Please route these fixes via your tree. Thanks Arnaldo!
