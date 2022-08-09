Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF30158D405
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiHIGuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIGup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 02:50:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E9C1E;
        Mon,  8 Aug 2022 23:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1E49B811B1;
        Tue,  9 Aug 2022 06:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D44DC433D6;
        Tue,  9 Aug 2022 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660027842;
        bh=4XRLYBkHIeanHtUx9JVZ94kPXzXpTAAOY2sRWbNULrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzdOYdAMDF/AQjiflW2UwPuPZqVu1Dgu1O4LLZxKUD1focGf0nQsrWClKfvzSOxvd
         RkkhTQ1q56hslpBnFppSsSTmYCZaI6ZCiPN1NBUUG9WUbwsHb32L+2VrDj+rFpRdQb
         LX3lZ/t+zvQ53haySi69n7ykmZIsdhXmtlcxNOCwRwplZ9CQQI68so3WytzM1Yx1oN
         G4i2YRPWHY0T6JrfHfJo6WII3vG8KnkJK42o3t9BygFuYbV7FC/cjaizp9ptccsi5n
         cjUMqcVDOp1BOY0rOO8UbGlJxgD+jhKa3FJl1GFv0rtTv8rrWEypDvcpI7T2E5Oo3u
         FheD1yfF9/E6w==
Date:   Tue, 9 Aug 2022 07:50:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <YvIDu0zU7eDUGEYq@google.com>
References: <20220803134821.425334-1-lee@kernel.org>
 <YuqT17dTbHK521pC@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuqT17dTbHK521pC@krava>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 03 Aug 2022, Jiri Olsa wrote:

> On Wed, Aug 03, 2022 at 02:48:21PM +0100, Lee Jones wrote:
> > The documentation for find_pid() clearly states:
> 
> nit: typo find_vpid

Sorry missed this.

Will fix.

> >   "Must be called with the tasklist_lock or rcu_read_lock() held."
> > 
> > Presently we do neither.
> > 
> > Let's use find_get_pid() which searches for the vpid, then takes a
> > reference to it preventing early free, all within the safety of
> > rcu_read_lock().  Once we have our reference we can safely make use of
> > it up until the point it is put.
> > 
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks.

-- 
Lee Jones [李琼斯]
