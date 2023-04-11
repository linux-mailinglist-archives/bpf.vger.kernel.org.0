Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0146DE2A3
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDKRfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDKRfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:35:11 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D96D5B81;
        Tue, 11 Apr 2023 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=9ycQhMAP8bYuSeQBFYr21ByNHZMBYNV4KYFk5ii2JBk=; b=XBv5tjhMDhhsbCSCOI1Dp4ly+K
        6PNv65eFtmKV2RcE0jUNPkq8KHWuN/svKV4Ps/AOBxwQbEPKHqNWw8k8/rIacSw5PicQ2tz7OXlRa
        zm0EIiA5bUXIbqJXAuyoWmCrkqAn3BTe4zf6xmlUL6mVURGroj/sMJsYf+bYf1X3iWiZnGvX5hMaD
        Jq2FpuxlVPElAH/LlHmYMcluX4i66ertxw9sRCEC2EaZw9kXmnZYZg7EvDFWXjiFlfb1U2A2cyb8m
        OKIZ76CwNIDqKnmQQvj6t+u9TgWpuITrMLXnzdVyKp01vtudA5rBvADHm9/mENVb2c/CGmU+/Bf06
        WKDoXhXw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pmHtW-0007ES-TX; Tue, 11 Apr 2023 19:35:02 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pmHtW-000Qov-JE; Tue, 11 Apr 2023 19:35:02 +0200
Subject: Re: [PATCH bpf-next] tools headers: Remove s390 ptrace.h in
 check-headers.sh
To:     Jiri Olsa <olsajiri@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <1680834090-2322-1-git-send-email-yangtiezhu@loongson.cn>
 <ZC/wA2NoO7yI/xNm@krava>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0f77e29c-e384-1d67-a99c-91e6091ec7db@iogearbox.net>
Date:   Tue, 11 Apr 2023 19:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ZC/wA2NoO7yI/xNm@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26872/Tue Apr 11 09:26:30 2023)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/7/23 12:27 PM, Jiri Olsa wrote:
> On Fri, Apr 07, 2023 at 10:21:30AM +0800, Tiezhu Yang wrote:
>> After commit 1f265d2aea0d ("selftests/bpf: Remove not used headers"),
>> tools/arch/s390/include/uapi/asm/ptrace.h has been removed, so remove
>> it in check-headers.sh too, otherwise we can see the following build
>> warning:
>>
>>    diff: tools/arch/s390/include/uapi/asm/ptrace.h: No such file or directory
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202304050029.38NdbQPf-lkp@intel.com/
>> Fixes: 1f265d2aea0d ("selftests/bpf: Remove not used headers")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> not sure this should go through Arnaldo's tree instead,
> either way is fine with me

Agree, perf tree is better given the script is located there, so:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
