Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5046F0873
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbjD0PgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjD0PgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 11:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DDDFF;
        Thu, 27 Apr 2023 08:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 239A061865;
        Thu, 27 Apr 2023 15:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2CBC433D2;
        Thu, 27 Apr 2023 15:36:03 +0000 (UTC)
Date:   Thu, 27 Apr 2023 11:36:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention
 mechanism
Message-ID: <20230427113602.0e49c0d1@gandalf.local.home>
In-Reply-To: <CALOAHbDRSNvihv5n0jJpAsK3onezRRipO78RG3rAf3LGgkzYHg@mail.gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
        <20230417154737.12740-6-laoar.shao@gmail.com>
        <20230427092628.21fd23e4@gandalf.local.home>
        <CALOAHbBX1C-eg93Hf3xPLsdsaBzoGn1pHh9jb3Z_-T-7HD60wA@mail.gmail.com>
        <20230427111842.2e40fe3c@gandalf.local.home>
        <CALOAHbDRSNvihv5n0jJpAsK3onezRRipO78RG3rAf3LGgkzYHg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 Apr 2023 23:23:31 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > But I thought you can run a bpf_prog from another bpf_prog. So you don't
> > want to prevent it. You need other logic to detect if it was not suppose to
> > recurs.
> >  
> 
> If so, we have to keep the prog->active to prevent it, then I'm not
> sure if it is worth adding test_recursion_*().

I thought that the whole point of this exercise was because the
migrate_disable() itself could be traced (or call something that can), and
that's outside of prog->active protection. Which the test_recursion_*()
code was created for.

-- Steve
