Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04E92FF481
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 20:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbhAUTF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 14:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbhAUTFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 14:05:06 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F06C06174A;
        Thu, 21 Jan 2021 10:53:59 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 11E34615F;
        Thu, 21 Jan 2021 18:53:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 11E34615F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611255239; bh=e02AiBv2dimHcgaSNPw1CsMyR/DFcOwWiLR7VxxDTe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cBTxDQi1SyC4H9VXIO0mGJFeHIsSffbYh0YCxno56GZRq3rNXs9TBHFLaMuvhjyKR
         ugjkTPIGa8DIpZ62lmc6yaDTbW6whMsL2RAeE4pf6iL0k78G7QQwKDOp0ma3L4+cur
         renPIoGDNePWkDzv0uoTKmlz1fc1U5BlrqBRSxo076vewczWgnsH9qGRUmrTD7vJQ+
         76Sd5yAB56TLhELaYTNo0vB+6d2gplDSG3PKaaSAbko904++1l+MiFe46NTy97/1G9
         G5Ix1MaqCsglf6t5xHsZDvzSlek3mJHNhYEgQZJiKxjQJhPAAXyk6p7mzAklLTdSaD
         ZV1BIsIQa4nxg==
Date:   Thu, 21 Jan 2021 11:53:57 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/2] BPF docs fixups
Message-ID: <20210121115357.31f44f34@lwn.net>
In-Reply-To: <20210120133946.2107897-1-jackmanb@google.com>
References: <20210120133946.2107897-1-jackmanb@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 20 Jan 2021 13:39:44 +0000
Brendan Jackman <jackmanb@google.com> wrote:

> Difference from v2->v3 [1]:
> 
>  * Just fixed a commite message, rebased, and added Lukas' review tag - thanks
>    Lukas!
> 
> Difference from v1->v2 [1]:
> 
>  * Split into 2 patches
> 
>  * Avoided unnecessary ': ::' in .rst source
> 
>  * Tweaked wording of the -mcpu=v3 bit a little more
> 
> [1] Previous versions:
>     v1: https://lore.kernel.org/bpf/CA+i-1C1LVKjfQLBYk6siiqhxfy0jCR7UBcAmJ4jCED0A9aWsxA@mail.gmail.com/T/#t
>     v2: https://lore.kernel.org/bpf/20210118155735.532663-1-jackmanb@google.com/T/#t
> 
> Brendan Jackman (2):
>   docs: bpf: Fixup atomics markup
>   docs: bpf: Clarify -mcpu=v3 requirement for atomic ops
> 
>  Documentation/networking/filter.rst | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

I'm assuming these will go up through the BPF/networking trees; please let
me know if I should pick them up instead.

Thanks,

jon
