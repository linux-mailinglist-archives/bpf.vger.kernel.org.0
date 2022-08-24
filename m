Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB835A0086
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiHXRij (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 13:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXRii (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 13:38:38 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674A75CFF;
        Wed, 24 Aug 2022 10:38:37 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oQuKp-0003SH-1M; Wed, 24 Aug 2022 19:38:35 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oQuKo-000WoJ-Kg; Wed, 24 Aug 2022 19:38:34 +0200
Subject: Re: [PATCH v3 0/4] bpf: Add user-space-publisher ringbuffer map type
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org
Cc:     kernel-team@fb.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        joannelkoong@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20220818221212.464487-1-void@manifault.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <81eff27a-652b-4b55-7a4a-31c421b7f0bb@iogearbox.net>
Date:   Wed, 24 Aug 2022 19:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220818221212.464487-1-void@manifault.com>
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

Hey David,

On 8/19/22 12:12 AM, David Vernet wrote:
> This patch set defines a new map type, BPF_MAP_TYPE_USER_RINGBUF, which
> provides single-user-space-producer / single-kernel-consumer semantics over
> a ringbuffer.  Along with the new map type, a helper function called
> bpf_user_ringbuf_drain() is added which allows a BPF program to specify a
> callback with the following signature, to which samples are posted by the
> helper:

Looks like this series fail BPF CI, ptal:

https://github.com/kernel-patches/bpf/runs/7996821883?check_suite_focus=true

   [...]
   bpftool_checks - Running bpftool checks...
   Comparing /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h (bpf_map_type) and /tmp/work/bpf/bpf/tools/bpf/bpftool/map.c (do_help() TYPE): {'user_ringbuf'}
   Comparing /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h (bpf_map_type) and /tmp/work/bpf/bpf/tools/bpf/bpftool/Documentation/bpftool-map.rst (TYPE): {'user_ringbuf'}
   bpftool checks returned 1.
   [...]
