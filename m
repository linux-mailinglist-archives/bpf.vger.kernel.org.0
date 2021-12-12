Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10C3471991
	for <lists+bpf@lfdr.de>; Sun, 12 Dec 2021 11:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhLLKD4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Dec 2021 05:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhLLKDz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Dec 2021 05:03:55 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A4C061714;
        Sun, 12 Dec 2021 02:03:54 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 2B03A58725FE7; Sun, 12 Dec 2021 11:03:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 266D060D59AA5;
        Sun, 12 Dec 2021 11:03:52 +0100 (CET)
Date:   Sun, 12 Dec 2021 11:03:52 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Yonghong Song <yhs@fb.com>
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: Re: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
In-Reply-To: <0364fb10-359e-c9c1-f90f-a01be2944dd6@fb.com>
Message-ID: <ns8n733-3sr-q954-q77-rp7s3o30r999@vanv.qr>
References: <YSQSZQnnlIWAQ06v@kernel.org> <YbC5MC+h+PkDZten@kernel.org> <1587op7-6246-638r-5815-2ops848q5r4@vanv.qr> <YbD696GWcp+KeMyg@kernel.org> <57104347-7557-19rs-5845-31o122o45798@vanv.qr> <0364fb10-359e-c9c1-f90f-a01be2944dd6@fb.com>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Thursday 2021-12-09 23:09, Yonghong Song wrote:
>> 
>> Just bumping this line
>> 
>>                  pkg_check_modules(LIBBPF REQUIRED libbpf>=0.4.0)
>> 
>> to the right version would absolutely be sufficient for us. Of course, that
>> requires that the libbpf project itself at least manages to make tags
>> regularly.
>
> Change above version 0.4.0 to 0.6.0 should work as libbpf 0.6.0 contains
> all the changes related to BTF_KIND_{TYPE,DECL}_TAGs.

Oh well, it does not. /usr/include/bpf/btf.h makes use of
BTF_KIND_{TYPE,DECL}_TAGs, but if /usr/include/linux/btf.h does not
have it (yet), compilation of libbpf-using components fails left and
right unfortunately despite libbpf itself succeeding in compilation.
