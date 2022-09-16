Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B0A5BB3AB
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 22:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIPUuG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 16:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiIPUuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 16:50:04 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A6A2EF0F
        for <bpf@vger.kernel.org>; Fri, 16 Sep 2022 13:50:03 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oZIHh-000C6o-82; Fri, 16 Sep 2022 22:50:01 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oZIHh-000EGl-2G; Fri, 16 Sep 2022 22:50:01 +0200
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: add veristat tool for
 mass-verifying BPF object files
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com
References: <20220909193053.577111-1-andrii@kernel.org>
 <20220909193053.577111-4-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <eec6aefd-00a5-b9c5-18df-2a52eefc89b3@iogearbox.net>
Date:   Fri, 16 Sep 2022 22:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220909193053.577111-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26660/Fri Sep 16 09:57:04 2022)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/9/22 9:30 PM, Andrii Nakryiko wrote:
> Add a small tool, veristat, that allows mass-verification of
> a set of *libbpf-compatible* BPF ELF object files. For each such object
> file, veristat will attempt to verify each BPF program *individually*.
> Regardless of success or failure, it parses BPF verifier stats and
> outputs them in human-readable table format. In the future we can also
> add CSV and JSON output for more scriptable post-processing, if necessary.
> 
> veristat allows to specify a set of stats that should be output and
> ordering between multiple objects and files (e.g., so that one can
> easily order by total instructions processed, instead of default file
> name, prog name, verdict, total instructions order).
> 
> This tool should be useful for validating various BPF verifier changes
> or even validating different kernel versions for regressions.
[...]

Git was complaining about two locations w/ whitespace issues, so fixed up
while applying. Thanks!
