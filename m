Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F36E6E8E
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjDRVrS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 17:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjDRVrR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 17:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3695172BD;
        Tue, 18 Apr 2023 14:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5FE961615;
        Tue, 18 Apr 2023 21:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944F9C433D2;
        Tue, 18 Apr 2023 21:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681854424;
        bh=rzvzbOBE/0Rc6//p5C3NcOiRnEzmtRUu5MQ9NFPyKh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohCqte2zYRqVzeONlUxuO+ey2pPuAoyTMvO53bmLuoqWg2fDMALdG2cmEUS9MrBIg
         3W4gX2CPklxTeYGbgrgh1iKGhv/+FO4tB8S6Ay1q8KG9RF0BJVpppBdR941Rw4c/C8
         rBlo+6zF6cq83q+n6zv5A3cieZUvjb+flxKWVjqWs6X07bJ8VbG1qIV3fGE3yO1UTY
         c+PvI7KLPTLPm25gw71NaiQ5hhB+A+/5EM2Cyn6HyiRRqZzoLkp4/HemmMYTNpGQaA
         vEByJrOHxNAYo3mYAJP2geOLOUtwzDcK4O6fteqr7RyqIkMsWw/OeDGFHGpto8RR1G
         w1VrrWXRzuofQ==
Date:   Tue, 18 Apr 2023 14:47:01 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Joan Bruguera =?utf-8?B?TWljw7M=?= <joanbrugueram@gmail.com>
Cc:     i.pear@outlook.com, acme@kernel.org, alan.maguire@oracle.com,
        alexandref75@gmail.com, bpf@vger.kernel.org, dxu@dxuuu.xyz,
        jforbes@redhat.com, linux-kernel@vger.kernel.org,
        olsajiri@gmail.com, peterz@infradead.org, ptalbert@redhat.com,
        yhs@fb.com
Subject: Re: [PATCH] vmlinux.lds.h: Discard .note.gnu.property section
Message-ID: <20230418214701.4qky77rsxxytyoc2@treble>
References: <20230413185922.ufmollqlnlghwyvy@treble>
 <20230416190219.2600911-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230416190219.2600911-1-joanbrugueram@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 16, 2023 at 07:02:19PM +0000, Joan Bruguera Micó wrote:
> Two small nitpicks:
> 
> > Link: https://lkml.kernel.org/lkml/57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com
> 
> This link is "semi-broken", it should go to /bpf/ instead of /lkml/.
> 
> >  	/DISCARD/ : { *(.note.GNU-stack) }				\
> > +	/DISCARD/ : { *(.note.gnu.property) }				\
> 
> Both discards can go in the same DISCARD block.
> (just style; it's how it's most often done in other linker scripts)

Thanks.  I also noticed the comment above the change needs an update.
Posting v2 shortly.

-- 
Josh
