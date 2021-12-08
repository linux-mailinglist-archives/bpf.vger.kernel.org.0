Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4146DBD6
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 20:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhLHTOj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 14:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhLHTOj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 14:14:39 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10684C061746;
        Wed,  8 Dec 2021 11:11:07 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8F78358726E05; Wed,  8 Dec 2021 20:11:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 8CE4A60C42C67;
        Wed,  8 Dec 2021 20:11:05 +0100 (CET)
Date:   Wed, 8 Dec 2021 20:11:05 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Yonghong Song <yhs@fb.com>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: Re: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
In-Reply-To: <YbD696GWcp+KeMyg@kernel.org>
Message-ID: <57104347-7557-19rs-5845-31o122o45798@vanv.qr>
References: <YSQSZQnnlIWAQ06v@kernel.org> <YbC5MC+h+PkDZten@kernel.org> <1587op7-6246-638r-5815-2ops848q5r4@vanv.qr> <YbD696GWcp+KeMyg@kernel.org>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Wednesday 2021-12-08 19:35, Arnaldo Carvalho de Melo wrote:

>Em Wed, Dec 08, 2021 at 03:26:31PM +0100, Jan Engelhardt escreveu:
>> 
>> On Wednesday 2021-12-08 14:54, Arnaldo Carvalho de Melo wrote:
>> > 
>> >	The v1.23 release of pahole and its friends is out, this time
>> >the main new features are the ability to encode BTF tags, to carry
>> 
>> [    7s] /home/abuild/rpmbuild/BUILD/dwarves-1.23/btf_encoder.c:145:10: error: 'BTF_KIND_DECL_TAG' undeclared here (not in a function); did you mean 'BTF_KIND_FLOAT'?
>> 
>> libbpf-0.5.0 is present, since CMakeLists.txt checked for >= 0.4.0.
>
>My fault, knowing the flux that libbpf is in getting to 1.0 I should
>have retested with the perf tools container based tests.
>
>Can you think about some fix for that? Lemme see if BTF_KIND_DECL_TAG is
>a define or an enum...

Just bumping this line

                pkg_check_modules(LIBBPF REQUIRED libbpf>=0.4.0)

to the right version would absolutely be sufficient for us. Of course, that
requires that the libbpf project itself at least manages to make tags
regularly.
