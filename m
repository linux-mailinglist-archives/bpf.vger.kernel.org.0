Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0826E84E4
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 00:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjDSW13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjDSW1F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 18:27:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771BCC19;
        Wed, 19 Apr 2023 15:25:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1FCE0219D8;
        Wed, 19 Apr 2023 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681943023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vY8XN3Sn3K1YcDvAR1zsIPMfvzeTloMrq3UeYNL0QaE=;
        b=W4RZg/5wedj4o/nehxu1JkvbBXwjUR1CQtUu+DigmwIBHJc4x1KAwp8WVeqFwpsMTjB9wK
        xjh4KzW3dLI4MVyVZsKpUjxoMAtTkz6TT8yuuF3jYQ1ltg81qSh2zmij51XuTCiJ2Oyqvw
        8aUfEclQ2AS4kRhDjtRdTwnWh8LpKK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681943023;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vY8XN3Sn3K1YcDvAR1zsIPMfvzeTloMrq3UeYNL0QaE=;
        b=Ih4T4Lt0LjXvm5m12QXGbyk8agAG49M4S2b0KrSwIKidzJ7CpEqgDlrPyBnwvw38+2ChNU
        7trsWXwVU6dURqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFD311390E;
        Wed, 19 Apr 2023 22:23:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uRZcIOtpQGSUUgAAMHmgww
        (envelope-from <tonyj@suse.de>); Wed, 19 Apr 2023 22:23:39 +0000
Date:   Wed, 19 Apr 2023 15:23:36 -0700
From:   tonyj@suse.de
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin@isovalent.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        David Miller <davem@davemloft.net>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <ZEBp6C9zqDnM1PfT@suse.de>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <87leiw11yz.fsf@toke.dk>
 <ZD/IcBvVxtFtOhUC@syu-laptop.lan>
 <CAEf4BzbxfvR4Ji1q4wJCFHOxQgFzHr8t7TMK1VJj9sJ+a0srVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbxfvR4Ji1q4wJCFHOxQgFzHr8t7TMK1VJj9sJ+a0srVQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 19, 2023 at 12:42:39PM -0700, Andrii Nakryiko wrote:

> I won't claim anything for perf, maybe Arnaldo can clarify, but I
> suspect that perf is also meant to be relatively independent from
> specific kernel and work on wide variety of kernels.

Supposedly it is though I've never been able to convince myself to
decouple (and ship the latest perf) for SLE. One reason is documented 
userspace functionality that has no backing kernel support which for 
an Enterprise distro opens us up to bug reports.

For a while Vince was maintaining a page documenting breakage in the 
perf_event ABI but last I checked it ended at V4.0.  Not sure if he 
just stopped updating, or that's where breakage ended :)

I know how Fedora maintains perf but I keep meaning to look at how
RHEL maintains it.  As Michal said our code base is V5.14 for SLE15*
and due to the frequent code-refactoring in perf, backporting perf
userspace fixes for SLE is a real chore unless we agressively maintain
forward porting ("forklifting").

Tony

-- 
Tony Jones
SUSE Kernel Performance Team
