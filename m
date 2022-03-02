Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3614CB186
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiCBVoQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbiCBVoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:44:15 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E159A7E
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 13:43:30 -0800 (PST)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nPWkl-0006lM-Og; Wed, 02 Mar 2022 22:43:23 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nPWkl-000VHp-Jz; Wed, 02 Mar 2022 22:43:23 +0100
Subject: Re: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
To:     Delyan Kratunov <delyank@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <cover.1646188795.git.delyank@fb.com>
 <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <364c8325-ea90-f8f6-d95b-09c9b0b4589e@iogearbox.net>
Date:   Wed, 2 Mar 2022 22:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26469/Wed Mar  2 10:27:25 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Delyan,

On 3/2/22 3:48 AM, Delyan Kratunov wrote:
> In symmetry with bpf_object__open_skeleton(),
> bpf_object__open_subskeleton() performs the actual walking and linking
> of symbols described by bpf_sym_skeleton objects.
> 
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>   tools/lib/bpf/libbpf.c   | 76 ++++++++++++++++++++++++++++++++++++++++
>   tools/lib/bpf/libbpf.h   | 21 +++++++++++
>   tools/lib/bpf/libbpf.map |  2 ++
>   3 files changed, 99 insertions(+)
> 

Triggers CI failure with:

 > build_kernel - Building kernel

   libbpf.c: In function ‘bpf_object__open_subskeleton’:
   libbpf.c:11779:27: error: ‘i’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   11779 |      sym->section, s->syms[i].name);
         |                           ^
   cc1: all warnings being treated as errors
   make[5]: *** [/tmp/runner/work/bpf/bpf/tools/build/Makefile.build:96: /tmp/runner/work/bpf/bpf/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o] Error 1
   make[4]: *** [Makefile:157: /tmp/runner/work/bpf/bpf/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
   make[3]: *** [Makefile:55: /tmp/runner/work/bpf/bpf/tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
   make[3]: *** Waiting for unfinished jobs....
   make[2]: *** [Makefile:72: bpf/resolve_btfids] Error 2
   make[1]: *** [Makefile:1334: tools/bpf/resolve_btfids] Error 2
   make[1]: *** Waiting for unfinished jobs....
   make: *** [Makefile:350: __build_one_by_one] Error 2
   Error: Process completed with exit code 2.

Thanks,
Daniel
