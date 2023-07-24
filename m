Return-Path: <bpf+bounces-5758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE2A760095
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4091C20C6C
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F110951;
	Mon, 24 Jul 2023 20:37:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D0F9D1
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:37:30 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A022DEA
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:37:28 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6bb0ba9fc81so8666815a34.2
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690231048; x=1690835848;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJ7trwGgOy74ZMmx1WSYkhxwukYNWfMR8FKYB/XHJWk=;
        b=L0mmWxRUtXgmypqzale6F12zvJi+r5JYzWEpIPeisKg8cwsrwnqVELfrs2Ce5hP/9i
         FqRMpKkk2pd5IA2HwSKjqVSs3OMr37UgU5arhgonJgwMTZxfTMyK7fRRgDEqAl5+PETb
         Ep1ITMGdT4lLjW/CIjU+1tbenxCiIUI1kmv/IpqSuJ6+eQviD/9n1jr4/5MhNr/FnK30
         CeMu/0Cky1ghv/Q72KpjYlX1HTbJP3A36n4E6IQdN7gFVaJyG/jseG7WqNwQ4896ae0t
         Y3L3WtWyoksd2owjT5LE7TBO0rqlvVISEPN1erkk+X/Q5KjtSgfVj1HGkIgKXHKh95uq
         lZKA==
X-Gm-Message-State: ABy/qLYqscAqlrr+gaVWO/sZUfw2fjezzrPpPtPw5WH/w5MwdLVkB66l
	03+R21iqWyJRfmNB5Wt9WI8N74P6zN5D548pNnx/RZRtXW6gzo0=
X-Google-Smtp-Source: APBJJlFWQnGftlrdER0j6SIMnKqOAkXNGK//D4qIZMkaaSZT9cyUVxOEEr75aCJTNAtgB0vgDsd0BSkGhTjvPdwIAwtEiZ9CyWSu
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:68cc:0:b0:6b4:5ee1:a988 with SMTP id
 i12-20020a9d68cc000000b006b45ee1a988mr11110645oto.5.1690231048090; Mon, 24
 Jul 2023 13:37:28 -0700 (PDT)
Date: Mon, 24 Jul 2023 13:37:28 -0700
In-Reply-To: <ZL7fhuAHmlcEHj73@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035b866060141957e@google.com>
Subject: Re: [syzbot] [modules?] WARNING in init_module_from_file
From: syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, llvm@lists.linux.dev, mcgrof@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/gpu/drm/bridge/samsung-dsim.c:730: undefined reference to `phy_mipi_dphy_get_default_config_for_hsclk'


Tested on:

commit:         910e230d samples/hw_breakpoint: Fix kernel BUG 'invali..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2bdc9d24e4a7abe741
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.

