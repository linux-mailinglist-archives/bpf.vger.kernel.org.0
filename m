Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C71F52C890
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 02:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiESAWY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 20:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiESAWV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 20:22:21 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC075958F
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 17:22:20 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5CC5B240029
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 02:22:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652919739; bh=1KNa+jm+fsenHMWQe2O+ARYuJ8QT/zd+IDNvXLiv2qk=;
        h=Date:From:To:Cc:Subject:From;
        b=oXScjHOJGEWZuYAMXzW5KYx16rNayh97TShlAhlsp2KQmY8fxgq4QtP6rvo2JnLrg
         sFMWoHbQcOMjDjimud0i67QNpEt1W7G9RIiron3lWU2TfZLWlcbXbp46OtEWmZ0yyh
         /thxvoil/qLJvv9LXkMPrvOxTz8FdEd7YAcvFsLeft/9y12i3DU4TA2VkWyOThS4DC
         sw8G/pu/tJLzPbQt0K+6Nw4/JlcE9G4qWJo2pX6pAuhHSsF0ViHErlaprFAINYIxQb
         z4RlUhhi1gKlvBVthmPq4tHnexOtitDDqgkcvucPX7ExVv2v+EwQFa7HYS8kFCAbTL
         4YqGxkHzEiD2g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L3Vt003z9z9rxG;
        Thu, 19 May 2022 02:22:15 +0200 (CEST)
Date:   Thu, 19 May 2022 00:22:12 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: Re: [PATCH bpf-next v2 00/12] libbpf: Textual representation of enums
Message-ID: <20220519002212.lpjeg5x5goql7crq@muellerd-fedora-MJ0AC3F3>
References: <20220519001815.1944959-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519001815.1944959-1-deso@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 12:18:03AM +0000, Daniel Müller wrote:
> This patch set introduces the means for querying a textual representation of
> the following BPF related enum types:
> - enum bpf_map_type
> - enum bpf_prog_type
> - enum bpf_attach_type
> - enum bpf_link_type
> 
> To make that possible, we introduce a new public function for each of the types:
> libbpf_bpf_<type>_type_str.
> 
> Having a way to query a textual representation has been asked for in the past
> (by systemd, among others). Such representations can generally be useful in
> tracing and logging contexts, among others. At this point, at least one client,
> bpftool, maintains such a mapping manually, which is prone to get out of date as
> new enum variants are introduced. libbpf is arguably best situated to keep this
> list complete and up-to-date. This patch series adds BTF based tests to ensure
> that exhaustiveness is upheld moving forward.
> 
> The libbpf provided textual representation can be inferred from the
> corresponding enum variant name by removing the prefix and lowercasing the
> remainder. E.g., BPF_PROG_TYPE_SOCKET_FILTER -> socket_filter. Unfortunately,
> bpftool does not use such a programmatic approach for some of the
> bpf_attach_type variants. We decided changing its behavior to work with libbpf
> representations. However, for user inputs, specifically, we do keep support for
> the traditionally used names around (please see patch "bpftool: Use
> libbpf_bpf_attach_type_str").
> 
> The patch series is structured as follows:
> - for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_type,
>   bpf_link_type}:
>   - we first introduce the corresponding public libbpf API function
>   - we then add BTF based self-tests
>   - we lastly adjust bpftool to use the libbpf provided functionality
> 
> Changelog:
> v1 -> v2:
> - adjusted bpftool to work with algorithmically determined attach types as
>   libbpf now uses (just removed prefix from enum name and lowercased the rest)
>   - adjusted tests, man page, and completion script to work with the new names
>   - renamed bpf_attach_type_str -> bpf_attach_type_input_str
>   - for input: added special cases that accept the traditionally used strings as
>     well
> - changed 'char const *' -> 'const char *'

I forgot to add the following: this patch set will need another revision in
order to integrate with Andrii's
https://patchwork.kernel.org/project/netdevbpf/patch/20220518185915.3529475-3-andrii@kernel.org/
once merged. This revision is mostly send out to get more feedback for the
changes to bpftool, which are rather significant.

Thanks,
Daniel
