Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8DD54E5F2
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbiFPPYd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiFPPYc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 11:24:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81102BB2F
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 08:24:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n28so2664576edb.9
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 08:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=mwJ8Wif5giUGYYc0iQvQdlGVGAgX9MBCDm879J1dkNc=;
        b=nJ4wrp4d4giRvsrz2tGN8jwNlWhC5HjRRxJEO/nwdUun42CgqUM6hf2Ud8uDsGHUnk
         GLFzkD8VJS2sCII3YtD+ojKZNGfCaQitOycarXUiKWk3ptdV+bEkNOAQE1e+C9m7JNFI
         itDefWllMyMiKUviPAMfYkdLOkGAeg3s5SbcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=mwJ8Wif5giUGYYc0iQvQdlGVGAgX9MBCDm879J1dkNc=;
        b=mrfWFOfICUbUIO4TQN5i0vM0ov8ML1v0Ae09dNViKv44C9Lxvff+lff8i3qMa67SpV
         FMb9o7tj+AxNy4PfBLN4pMjKcNX+RVn8ehpjMccEpKO1FnKLd9qR9k16xUw0YyIub7dN
         tU6sdT1RuxiBcAUQw/HYABzpsywrHIeUHM5X0hEEmlNEj7OwePW0S84orVRwuiKMFV6f
         UtUbOhgkCjH/x1yoeLHxT0/m86h7Lf7+XO64BsvIDrLuAsywbYw8GNiCffp08edI348c
         i3ods3RxMEM5BGaeMePiRuS06txRY2q0kCxhi2wo6vh+f6qJQYLexTpD3lwqG/0S7RwH
         apjQ==
X-Gm-Message-State: AJIora/G0jVjBkh45X5uKZx0mpWvnmLQtfzR+pOC466YHvDRzyQvbIlt
        WElz8/WN6FiBDjyKu5EbEZyIcw==
X-Google-Smtp-Source: AGRyM1svNK7krKHYzVECv6ofebO2N8FKcYsnD5iwmDlXTHiG1tYjn/etfFY3EqYSLABQJjMMNBQdTg==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr7090713edb.273.1655393069330;
        Thu, 16 Jun 2022 08:24:29 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b0042bcf1e0060sm1928928edq.65.2022.06.16.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:24:29 -0700 (PDT)
References: <20220615151721.404596-1-jakub@cloudflare.com>
 <20220615151721.404596-3-jakub@cloudflare.com>
 <e88f66e7-3bfd-1563-8a74-26f0ac19bfe0@iogearbox.net>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test tail call counting
 with bpf2bpf and data on stack
Date:   Thu, 16 Jun 2022 17:23:39 +0200
In-reply-to: <e88f66e7-3bfd-1563-8a74-26f0ac19bfe0@iogearbox.net>
Message-ID: <87bkusws0j.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 16, 2022 at 04:41 PM +02, Daniel Borkmann wrote:

[...]

> Looks like this fails CI with:
>
>   progs/tailcall_bpf2bpf6.c:17:40: error: unknown attribute 'always_unused' ignored [-Werror,-Wunknown-attributes]
>   int classifier_0(struct __sk_buff *skb __unused)
>                                          ^~~~~~~~
>   progs/tailcall_bpf2bpf6.c:5:33: note: expanded from macro '__unused'
>   #define __unused __attribute__((always_unused))
>                                   ^~~~~~~~~~~~~
>   1 error generated.
>   make: *** [Makefile:509: /tmp/runner/work/bpf/bpf/tools/testing/selftests/bpf/tailcall_bpf2bpf6.o] Error 1
>   make: *** Waiting for unfinished jobs....
>   Error: Process completed with exit code 2.

I will switch to __attribute__((unused)) and ignore what checkpatch
says. Will respin. Thanks!
