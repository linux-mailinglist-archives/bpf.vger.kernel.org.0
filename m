Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D155B15C8
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 09:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIHHhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 03:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiIHHhr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 03:37:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986E2C6B59;
        Thu,  8 Sep 2022 00:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 216C6B81D3E;
        Thu,  8 Sep 2022 07:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A7AC433D6;
        Thu,  8 Sep 2022 07:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662622663;
        bh=Kgnw67caXr7OXb4RBMxKrFzSTNau+fuH0+I6zQkV1TQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=IbsA4bqGYWrGg5qR6o8g/WNrG6ZJm3iOEW2B3VqBwVWlNpWqahDdXBgppU4EVNl/2
         jc4kqszFb5yLlgnhU3tM48iJtbziXeB8l/iYPOmoE6asheetxECpKbCMfAnUbpYtX+
         gtk3iDEyL7Kis/uoBwZcQWpJUrGNT7r1zV/KhRPDJ3zFR9Jejkc38VRTp4E+lnzPxz
         IKW9ZDZQl4S7oYuivusITD22zLX0rYIOREvc/emiiLJEpw5Ld0/PdyCk2YCphh+wR4
         hXUJU29zKBQ8Q9wpxIHPsurmSXEvIOsHRo0xwDHNBCDNmjiVYLIoRgcrDOQHtQ8q44
         2y6FHYzBT5grA==
Date:   Thu, 8 Sep 2022 08:37:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <YxmbwRkJB3yJ58TM@google.com>
References: <20220809134752.1488608-1-lee@kernel.org>
 <YxmbPqKZMEXHL6sI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxmbPqKZMEXHL6sI@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 08 Sep 2022, Lee Jones wrote:

> On Tue, 09 Aug 2022, Lee Jones wrote:
> 
> > The documentation for find_vpid() clearly states:
> > 
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
> > Cc: bpf@vger.kernel.org
> > Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> > 
> > v1 => v2:
> >   * Commit log update - description - no code differences
> > 
> > v2 => v3:
> >   * Commit log update - spelling of find_vpid() - no code differences
> 
> Did anyone get a chance to look at this please?
> 
> Would you like a [RESEND]?

Scrap that.  I've just seen the last replies to v2.

Leave it with me.

-- 
Lee Jones [李琼斯]
