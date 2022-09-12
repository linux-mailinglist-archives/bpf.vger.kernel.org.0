Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF665B5CF9
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiILPOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiILPOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 11:14:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC3A2E68A;
        Mon, 12 Sep 2022 08:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20C21B80DC0;
        Mon, 12 Sep 2022 15:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BBEC433D6;
        Mon, 12 Sep 2022 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662995654;
        bh=ChxPKdV5Kb3N5+asDrhKXUTBi8bzPrEOB6ZKbaDnX5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JT00u8osq9+sb7/vj7vKLSgoycyfWp1h3sFWuj/vVCMSxhJvR6zkNB03jFwGA1WeR
         8sK8EVaLrP/IxwR393yREGBZCXMiZ//uQxDJ18n8KX5a9nC4yd1T3pCcDNDISxJ3mo
         z7oERLNSN1FEO5x8dXGE05/tiMjGeB2P7y8hzdU7Zp+xO1hZqfPK86sUw+416zvT/o
         Yt03dLGOInybEcShkTWGSerlHZlOyPFkgpafLmhm+K4xR0gEO0nDrn49nR+ExlI0ds
         HZwxh+S+OTWDvehf25j6X+WRlkgs2Ryoy4qpAICzIyO2d+sIm7I/rUCaO252SDJrIo
         uz4Npm+6uNcAA==
Date:   Mon, 12 Sep 2022 16:14:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bpf: Ensure correct locking around vulnerable
 function find_vpid()
Message-ID: <Yx9Mv4ltoNhuU0Om@google.com>
References: <20220912133855.1218900-1-lee@kernel.org>
 <243f7ca6-41e1-7522-a6fc-6a35d8104bb5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <243f7ca6-41e1-7522-a6fc-6a35d8104bb5@fb.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 12 Sep 2022, Yonghong Song wrote:
> On 9/12/22 2:38 PM, Lee Jones wrote:
> > The documentation for find_vpid() clearly states:
> > 
> 
> No need for the above extra line.

The intentional blank formatting line?

The commit message would look worse without it.

Is this really a blocker?

> >    "Must be called with the tasklist_lock or rcu_read_lock() held."
> > 
> > Presently we do neither.
> 
> Presently we do neither for find_vpid() instance in bpf_task_fd_query().
> Add proper rcu_read_lock/unlock() to fix the issue.

I can expand this.

> > Cc: Jiri Olsa <jolsa@kernel.org>
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
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> Ack with above a few suggestions for the commit message.
> 
> Acked-by: Yonghong Song <yhs@fb.com>

-- 
Lee Jones [李琼斯]
