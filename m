Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF06A8B6C
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCBWEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 17:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCBWEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 17:04:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300BC1ADFA;
        Thu,  2 Mar 2023 14:04:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F023DB815E2;
        Thu,  2 Mar 2023 21:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6E8C433D2;
        Thu,  2 Mar 2023 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677794280;
        bh=haZ5hbK/FABM1NA11AyojbjxIeoGH44sYRzAH2/vIWo=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=mTK1o6Ba5YwhvY6woe7QZqTLyHnZn0Vd1a2uwxD0JQsGAaqdO2BjeQolchN1dWQYu
         aTh3vuXXPwZs9hkVrOt2rruPGrCxqDpWVXGtQX5DAW2/f/Ihz1NRaSeZP/mOHBQcT0
         9RMMYhtfC8N2d8VBKgJXAlRvKUhU4oSdgfkc/okao6KjoMsV6KKxfZs5g4PYjVv/1m
         eSbfJJ/Gxl2A6BENWhmemCNV7e6gtU5yoau/8WoLE1I2sbnFNFId7Ajdk+QeXOvgWy
         2fslfn7ck8wKTxjuCpe0zmDqnqyyvrlKCwG7KF3xpMNcPWtRCnyU1onPsYVbGjpyXJ
         J1ksqqDLjlZBw==
Date:   Thu, 02 Mar 2023 13:57:57 -0800
From:   Kees Cook <kees@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>
CC:     linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: splat in ikheaders_read (bpftrace)
User-Agent: K-9 Mail for Android
In-Reply-To: <20230302112130.6e402a98@kernel.org>
References: <20230302112130.6e402a98@kernel.org>
Message-ID: <22EA7360-E2FC-4A23-BF0B-EFDE523F9605@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On March 2, 2023 11:21:30 AM PST, Jakub Kicinski <kuba@kernel=2Eorg> wrote:
>Hi Kees!
>
>Running tests on net (Linus's tree as of Monday) I get this splat
>trying to attach bpftrace to a tracepoint:

Can you give me an example command line to try to repro this?

>
>[ 2468=2E945793] kernel BUG at lib/string_helpers=2Ec:1027!

Were there any lines above this? It must be memcpy blowing up due to what =
it thinks is an overflow from having tracked an allocation size (that's the=
 major change this cycle)=2E

>[ 2468=2E949683] RIP: 0010:fortify_panic+0xf/0x20
>=2E=2E=2E
>[ 2468=2E961930] Call Trace:
>[ 2468=2E962300]  <TASK>
>[ 2468=2E962611]  ikheaders_read+0x45/0x50 [kheaders]

static ssize_t
ikheaders_read(struct file *file,  struct kobject *kobj,
	       struct bin_attribute *bin_attr,
	       char *buf, loff_t off, size_t len)
{
	memcpy(buf, &kernel_headers_data + off, len);
	return len;
}

I will take a look at the caller's allocation of "buf" and kernel_headers_=
data=2E

-Kees


--=20
Kees Cook
