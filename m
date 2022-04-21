Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5547150ABB1
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 00:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392034AbiDUW6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376785AbiDUW6I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 18:58:08 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1413E8E
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 15:55:17 -0700 (PDT)
Date:   Thu, 21 Apr 2022 22:55:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1650581716;
        bh=Iim1B9+7pfJQA0zio9onHWmYuVu09gT54/zLmt1I/XM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=pW7B4YEgX0LUsDppRLFacHpDL4ECXl2ix1oo3GvZ/Ya0UWDTO59yZlgM4UDD/1ZMd
         Fr/i12bP4w8n/w0nuxjxh6jhfSKHc4p0geBvTQfltcOxbwKs7kW9DZHa2cNuNWobnX
         k8sAZEnnIs/zLGJcGyAcBujwhRdMbQAl9Q7G0KbFQSkWTR3kTelQ3zVhQA3iARfrIE
         bfY5H8Kr9kZSj8QgQTdb0JL8P3kIurtwfOvVeT95syuWIhiEz0RshbpROD7FZ1X8Of
         YvBuJFypxO5XrhB+EDYhHmqW0cmMvm+nUml+g+kzlmig90PGbGfPgHI7t52HMTVspY
         TSx9zWX6QCfNA==
To:     David Laight <David.Laight@ACULAB.COM>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH v2 bpf 07/11] samples/bpf: fix uin64_t format literals
Message-ID: <20220421224816.332419-1-alobakin@pm.me>
In-Reply-To: <ca0733f123bf498a831324c4692a0df8@AcuMS.aculab.com>
References: <20220421003152.339542-1-alobakin@pm.me> <20220421003152.339542-8-alobakin@pm.me> <ca0733f123bf498a831324c4692a0df8@AcuMS.aculab.com>
Feedback-ID: 22809121:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 21 Apr 2022 07:46:05 +0000

> From: Alexander Lobakin
> > Sent: 21 April 2022 01:40
> >
> > There's a couple places where uin64_t is being passed as an %lu
> > format argument. That type is defined as unsigned long on 64-bit
> > systems and as unsigned long long on 32-bit, so neither %lu nor
> > %llu are not universal.
> > One of the options is %PRIu64, but since it's always 8-byte long,
> > just cast it to the _proper_ __u64 and print as %llu.
>
> Is __u64 guaranteed to be 'unsigned long long' ? No reason why it should =
be.
> I think you need to cast to (unsigned long long).

__u64 can be unsigned long only if an architecture uses int-l64.h
instead of int-ll64.h. This is currently possible for Alpha and
PPC64 when __SANE_USERSPACE_TYPES__ is not defined -- I guess you
know what that flag does.
I messed up a bit and didn't notice that samples/bpf/Makefile
defines this flag only for MIPS. IMO it should be defined in here
unconditionally, but I guess it's out of bpf-fixes scope, so I'll
go with unsigned long long in v3 (got to resend with no PGP crap
anyway lol).

>
> =09David

--- 8< ---

> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

Thanks,
Al

