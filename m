Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199CC52DD16
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242927AbiESSvd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 14:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243455AbiESSvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 14:51:31 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B025C65C
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 11:51:30 -0700 (PDT)
Date:   Thu, 19 May 2022 18:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1652986288; x=1653245488;
        bh=2gf1EUImmZ2XTRVd9/XvlFZ5tS1IjvdEE8nv/JSHIXQ=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=HiU3zVK7sVNdo4Zz34mEWBKOdGRcjBfWD6gQJT93dqs4pUiqnzRUzGspRG2RdLkDK
         3gAn8+abZiigFlYAO/cY+L7O0qnHg8OwhVTetfERKjSw/s9xRPetL0rfrkJleI6Eiw
         Mp/WA8Rm2YET+9nxtlLS0OuloG3OTsaTp1LvTZ7kUQmvBDqlUb7Ai6LDwDZ3LL10Le
         hZS9SSe6IQ+on8xpS9nvfyoT+AdeFiujXNqDZdIAcyz1Dk7JvIGLAMOH5r4o4n7zrE
         L/HDq6WNiv3vT9EgTto2BdxY5ldUnxdJZYeMDJtoV7oNsVQMsU3IKXsaMyYo5ugKjY
         MwpSqqZU5hkZA==
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From:   Yadunandan Pillai <thesw4rm@pm.me>
Reply-To: Yadunandan Pillai <thesw4rm@pm.me>
Subject: What happens to a uprobe when the .so file it linked to gets deleted?
Message-ID: <Ds9OsMJ5I3M50Mz4dgLCOIjpoDXVxZX6EmManG2SKMQEqeSA9qF-QS-nJX2cK-Yvg5boIJAAqgYR-0Yg172IOTjJCIDA-zjo80h-ZnCn9Ww=@pm.me>
Feedback-ID: 11923722:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I attached a uprobe to a function in a system library. The uprobe is interc=
epting function calls as expected. Let's say I delete the library the uprob=
e is attached to, but don't manually unload the uprobe first. A practical e=
xample of this is if I attach to a library within a container, and then del=
ete the container, but leave the eBPF program with the uprobe still running=
.

How is the uprobe stored in kernel memory, and how would deleting the libra=
ry it attaches to affect this? Is the uprobe basically a JMP pointer in a k=
ernel hashmap that gets injected whenever the function it attaches to is ca=
lled? Does the uprobe automatically get cleaned up, or does it become a dan=
gling pointer?

If it becomes a dangling pointer, what is the best way to detect that and c=
lean it up from the eBPF loader?

Sorry if my terminology or concepts aren't quite right. I'm still learning =
operating systems :).

Appreciate any help and advice.
Thanks,
Yadunandan Pillai
