Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0156792D
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 23:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGEVHL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 17:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGEVHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 17:07:10 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794415711
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 14:07:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D5092240029
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 23:07:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657055226; bh=XHYbHAdzyyjXlEoNvIgl1xQ8h/2c0/LyKMDiTPl0S+U=;
        h=Date:From:To:Cc:Subject:From;
        b=g3BMTh7kbHjsyozfduK9Oi3PYJzh42dXs3WJPnubQM/DXNzPS590fqUMOyHae/WHL
         vF2MQ0oStCWc87JYdokO+F/RallmuCQNNsa7nigfWSIMxVmgbPYbn3iHiVlHXDAC+v
         o1rw4s2a98jdeDmPX4L2gXgnH5QmjYyiGdgqRNXFMaPIB2wvzKYdgT4t2+5CZk+I2L
         28jVtb+B0JmO6wP40xk3DuWLveiDzcyT+ZU940MG0syB/nY+3gAu4mDPpmPU6pHuGw
         dITw+yrWSZOeD64UKfIj0cpB01H/zsCASFHWna8xwxhvikuURKuJOo6eMGescOB4yi
         zOQ0rzxNraGSg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LcwGc0HRGz9rxB;
        Tue,  5 Jul 2022 23:07:03 +0200 (CEST)
Date:   Tue,  5 Jul 2022 21:07:00 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: Re: [PATCH bpf-next v3 00/10] Introduce type match support
Message-ID: <20220705210700.fpyw4msqy7tkiuub@muellerd-fedora-MJ0AC3F3>
References: <20220628160127.607834-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628160127.607834-1-deso@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 04:01:17PM +0000, Daniel Müller wrote:
> This patch set proposes the addition of a new way for performing type queries to
> BPF. It introduces the "type matches" relation, similar to what is already
> present with "type exists" (in the form of bpf_core_type_exists).
> 
> "type exists" performs fairly superficial checking, mostly concerned with
> whether a type exists in the kernel and is of the same kind (enum/struct/...).
> Notably, compatibility checks for members of composite types is lacking.
> 
> The newly introduced "type matches" (bpf_core_type_matches) fills this gap in
> that it performs stricter checks: compatibility of members and existence of
> similarly named enum variants is checked as well. E.g., given these definitions:
> 
> 	struct task_struct___og { int pid; int tgid; };
> 
> 	struct task_struct___foo { int foo; }
> 
> 'task_struct___og' would "match" the kernel type 'task_struct', because the
> members match up, while 'task_struct___foo' would not match, because the
> kernel's 'task_struct' has no member named 'foo'.
> 
> More precisely, the "type match" relation is defined as follows (copied from
> source):
> - modifiers and typedefs are stripped (and, hence, effectively ignored)
> - generally speaking types need to be of same kind (struct vs. struct, union
>   vs. union, etc.)
>   - exceptions are struct/union behind a pointer which could also match a
>     forward declaration of a struct or union, respectively, and enum vs.
>     enum64 (see below)
> Then, depending on type:
> - integers:
>   - match if size and signedness match
> - arrays & pointers:
>   - target types are recursively matched
> - structs & unions:
>   - local members need to exist in target with the same name
>   - for each member we recursively check match unless it is already behind a
>     pointer, in which case we only check matching names and compatible kind
> - enums:
>   - local variants have to have a match in target by symbolic name (but not
>     numeric value)
>   - size has to match (but enum may match enum64 and vice versa)
> - function pointers:
>   - number and position of arguments in local type has to match target
>   - for each argument and the return value we recursively check match
> 
> Enabling this feature requires a new relocation to be made known to the
> compiler. This is being taken care of for LLVM as part of
> https://reviews.llvm.org/D126838.

To give an update here, LLVM changes have been merged and, to the best of my
knowledge, are being used by BPF CI (tests that failed earlier are now passing).

Thanks,
Daniel

[...]
