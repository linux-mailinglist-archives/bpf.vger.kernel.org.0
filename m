Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC08056AB0D
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiGGSxX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiGGSxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 14:53:23 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C222E2E69E
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 11:53:21 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1657219999; x=1657479199;
        bh=le1dGrQD/n4xBF/tcAmG4aQEdih8aMhJSScfMP02frM=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=kQL3ATfS4n+tF2cz3nSUOlqEamKd0rLCTJ0xx8/o3zcgXd5uoOZqHhey8Vy6Eknvm
         xZQUFF2u3N6ym11tRsC5smd/3B3aNZn+imkGYl5Wl2swWpgSEOvgxTNQeObLpy2daT
         yQl5XevQ+YLnNY4E901s5pj5P5frfJkGKbXlv14LZrd6AZpXaGU4WCvNJ1ilaaS2dL
         CloDkDsSl+G3Yc1tq1kupSu3L/0BeFjiT9kioJFhsmk5EICbhNUulCfi3IR8JRrcw7
         tZuQACj4jMBx/Ruf6mlDciwOa8B3NyyjVBz1twkNwXiq+hKA8uZREip+9fhKeLj32O
         UUFEjEGLbioLQ==
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From:   Yadunandan Pillai <thesw4rm@pm.me>
Reply-To: Yadunandan Pillai <thesw4rm@pm.me>
Subject: What happens to a uprobe if it links to a library within a container, and that container gets deleted?
Message-ID: <OBzRUbPFxraCqyqKJG4wxt16KtWfSZuzR1_huzK30nTPOyc2_oKjBYylXc9fr0CL_oOi0SbH8P67jujAXcI8rMT_wZQwfcAblzuteWLv5fg=@pm.me>
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

How are uprobes "remembered" in the kernel from a conceptual standpoint? Wh=
ere is the attach point stored? Is it basically a hashmap with JMP instruct=
ions for each function that is being attached to? What exactly does the cle=
anup process look like if the attach point disappears?

Example of a use case: let's say a uprobe is to "SSL_read" in /proc/[root_p=
id]/root/.../libssl.so where [root_pid] is the root process of a container.=
 If the container dies, then does that uprobe hang around attaching to empt=
y air or gets deleted as well?

Yadunandan Pillai
