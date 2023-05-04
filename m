Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C066F7048
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEDQ4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDQ4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 12:56:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9B12705
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 09:56:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643557840e4so935814b3a.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683219396; x=1685811396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWNxqVNpbhilflcozQBNCVWbO1yAtHoJzqL2uLrpMWQ=;
        b=rWWQjVH3y3yFnu3yxnAZIYhp8EpHZjxHVON0ziVl9w260gnUcvkoCKJPRCotXN3BCD
         C0BiXqQvQasduZMLy0UqkxuBv3EPJHqfrEUu3sZn/wSgHN0N0gNcJW1HeuA98esF86Xa
         JozQjjWj+yER6kC0JTyZ/r/RHBseE/gbL1Z31QoIuA2oo8mS/n48RsA4bbRTDgP2lXQg
         jTvtptYnP8P5xLddeFFfHz/DDzbYdY1JBjvccDPE/uJmtZSXASSuBuoYSCpAVriRmnY/
         cDU9Ynif6mFIy6vrFcVuodU5sedi1e96H4o6IzmHFIreXm7IjIBBpdPl0yssd/8vk+2f
         90RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683219396; x=1685811396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWNxqVNpbhilflcozQBNCVWbO1yAtHoJzqL2uLrpMWQ=;
        b=UOCQlLaQ+MLqjjQQXLJXgyEFpSUyM7Fxnfas5WCetWM6ucrqPoZ3bzV1hznEfC+f0s
         Kbr9/YiIMZ13mFMEg14qT+UuyYOO1+g+xiR1bt0yjfTvYJMQrdCNBac5fKLUn9QqBUTe
         wv5mswP72Wg5Pe4AWdyNmmsYedXtFEJeDePnrMJf+ZI7kdrW2m6fGOMGaaKgi5j1Pnn9
         f3zCp67xskbep7jHTIjf993AwwMNxKtamOvlIttRzmzV/nmzG+fK4rBBft49oe6A/+M0
         0+Z+nq1eXMpWGEvrXtUj78/yBJaizmCMJdw+faJWapGPvdx7e8j6jcU5keWkBwBWrjxG
         mIng==
X-Gm-Message-State: AC+VfDzu4KU044kSUPdgwsNTXK+6G4RLskw/7b79RcQ2kuXfKpZXLULp
        XrPwd+Zhy+Px+7SEwI9+Qu0=
X-Google-Smtp-Source: ACHHUZ5fdvk7mZj21WMh6csC2AVLxUIV/K9DJ8tNx/1SQwJ3n/LuDDXmkFSRm7TPCa1t9hQPDjkssg==
X-Received: by 2002:a05:6a00:2d0b:b0:641:a6d:46b0 with SMTP id fa11-20020a056a002d0b00b006410a6d46b0mr3835447pfb.22.1683219396185;
        Thu, 04 May 2023 09:56:36 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b006439ad979cbsm196723pfn.152.2023.05.04.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:56:35 -0700 (PDT)
Date:   Thu, 4 May 2023 09:56:33 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 08/10] bpf: support precision propagation in the
 presence of subprogs
Message-ID: <20230504165633.mtf3etaof3afscpa@MacBook-Pro-6.local>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-9-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-9-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 04:49:09PM -0700, Andrii Nakryiko wrote:
> Add support precision backtracking in the presence of subprogram frames in
> jump history.
> 
> This means supporting a few different kinds of subprogram invocation
> situations, all requiring a slightly different handling in precision
> backtracking handling logic:
>   - static subprogram calls;
>   - global subprogram calls;
>   - callback-calling helpers/kfuncs.
> 
> For each of those we need to handle a few precision propagation cases:
>   - what to do with precision of subprog returns (r0);
>   - what to do with precision of input arguments;
>   - for all of them callee-saved registers in caller function should be
>     propagated ignoring subprog/callback part of jump history.
> 
> N.B. Async callback-calling helpers (currently only
> bpf_timer_set_callback()) are transparent to all this because they set
> a separate async callback environment and thus callback's history is not
> shared with main program's history. So as far as all the changes in this
> commit goes, such helper is just a regular helper.
> 
> Let's look at all these situation in more details. Let's start with
> static subprogram being called, using an exxerpt of a simple main
> program and its static subprog, indenting subprog's frame slightly to
> make everything clear.
> 
> frame 0				frame 1			precision set
> =======				=======			=============
> 
>  9: r6 = 456;
> 10: r1 = 123;						r6
> 11: call pc+10;						r1, r6
> 				22: r0 = r1;		r1
> 				23: exit		r0
> 12: r1 = <map_pointer>					r0, r6
> 13: r1 += r0;						r0, r6
> 14: r1 += r6;						r6;
> 15: exit
> 
> As can be seen above main function is passing 123 as single argument to
> an identity (`return x;`) subprog. Returned value is used to adjust map
> pointer offset, which forces r0 to be marked as precise. Then
> instruction #14 does the same for callee-saved r6, which will have to be
> backtracked all the way to instruction #9. For brevity, precision sets
> for instruction #13 and #14 are combined in the diagram above.
> 
> First, for subprog calls, r0 returned from subprog (in frame 0) has to
> go into subprog's frame 1, and should be cleared from frame 0. So we go
> back into subprog's frame knowing we need to mark r0 precise. We then
> see that insn #22 sets r0 from r1, so now we care about marking r1
> precise.  When we pop up from subprog's frame back into caller at
> insn #11 we keep r1, as it's an argument-passing register, so we eventually
> find `10: r1 = 123;` and satify precision propagation chain for insn #13.
> 
> This example demonstrates two sets of rules:
>   - r0 returned after subprog call has to be moved into subprog's r0 set;
>   - *static* subprog arguments (r1-r5) are moved back to caller precision set.

Haven't read the rest. Only commenting on the above...

The description of "precision set" combines multiple frames and skips the lower
which makes it hard to reason.
I think it should be:

10: r1 = 123;						fr0: r6
11: call pc+10;						fr0: r1, r6
				22: r0 = r1;		fr0: r6; fr1: r1
				23: exit		fr0: r6; fr1: r0
12: r1 = <map_pointer>					fr0: r0, r6
13: r1 += r0;						fr0: r0, r6
14: r1 += r6;						fr0: r6

Right?
