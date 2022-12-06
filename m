Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB40164426B
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 12:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiLFLtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 06:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiLFLtS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 06:49:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921B1A800
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 03:49:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C012616D0
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 11:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47190C433C1;
        Tue,  6 Dec 2022 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670327355;
        bh=6xLzCvg1B8HFg8s1xAAVFQq9nR0ipzLSaqS6z7gaW8Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Usay63OHrAkpKrJcqTWtgXGnSeTTVom277D+tQDiTwlbEiB2eINhSTwLW0qumWOXm
         bHhM2iTboAeFdYxgFBO7aK3LoqEe4aNac07/Ro7Axk/keo8o4qz/IPaXxsJ/rDeMqO
         sEUwo19eNuurijTDW6Ct490b/KiU7W72yL2EnTBPHLTte8oImxq+U2YqK3c+OXxjpJ
         /tbuoVglXqPqDRv1MLcC2HLn1wqgQGOpN8lEbG+SpAuKNkPvOMZGIhydo5ImYuTTh3
         EDsckUb0ixwmsRmnAW8YfmH8+nqichpXQAkD3uSDV0ev+cfyo+vH/xDAVG5kj5rqSL
         oPMi0Tg87jR6A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 785C482E375; Tue,  6 Dec 2022 12:49:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Bring test_offload.py back to life
In-Reply-To: <20221206011052.3099563-1-sdf@google.com>
References: <20221206011052.3099563-1-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 06 Dec 2022 12:49:12 +0100
Message-ID: <87o7sgu4zr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> Commit ccc3f56918f6 ("selftests/bpf: convert remaining legacy map
> definitions") converted sample_map_ret0.c to modern BTF map format.
> However, it doesn't looks like iproute2 part that attaches XDP
> supports this format.

It does if it's linked against libbpf; what distro are you on that
doesn't do that?

-Toke
