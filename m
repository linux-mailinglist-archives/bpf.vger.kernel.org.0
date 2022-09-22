Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53335E6384
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIVNYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVNYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 09:24:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA57A15702;
        Thu, 22 Sep 2022 06:24:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0BF8C383;
        Thu, 22 Sep 2022 13:24:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0BF8C383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663853074; bh=8qc1OkwuhT1m7m2mzmPZ75/o0gOcUqlh0cv/z0rcOVU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NuOn4JtI0DvO71POAqaz0bXjdCJwXYzTZl/ySUZ7Zk9min57Yjr6FgqEtjuhKKhE+
         2X+MhAvBvJgZ6oxcFF74BocMneqs1GgJUtq9hCwFT5YuTDapiKwnvYqdLvZivpuYGn
         g+VCW0NtE96vfg/fuUN1tBHiMK0EOg2O9XVnRAnqgAZY9FxLhd5kgDPDOr3ROhag0q
         e/H5H1As9HOWP+gU0RQk0wlbOxE8ogZi7WyQ48uh9pJMfA5EgKv47X7t/blPFXVzBO
         VItsCcedeCdFH7NLXp31NrKJLdm8jua0QqSSZEdrhnKiswy9eZxmboj5gsQrftvU3x
         nX24g4Ma9JKuQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] Add subdir support to Documentation
 makefile
In-Reply-To: <20220922115257.99815-2-donald.hunter@gmail.com>
References: <20220922115257.99815-1-donald.hunter@gmail.com>
 <20220922115257.99815-2-donald.hunter@gmail.com>
Date:   Thu, 22 Sep 2022 07:24:33 -0600
Message-ID: <87tu4zsfse.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Donald Hunter <donald.hunter@gmail.com> writes:

> Run make in list of subdirs to build generated sources and migrate
> userspace-api/media to use this instead of being a special case.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

This could really use a bit more information on exactly what you're
doing and why you want to do it.

Beyond that, I would *really* like to see more use of Sphinx extensions
for this kind of special-case build rather than hacking in more
special-purpose scripts.  Is there a reason why it couldn't be done that
way?

Thanks,

jon
