Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9012FA4E0
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbhARPfh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 10:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405902AbhARPfT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 10:35:19 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9264C061573
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:34:35 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 19242385;
        Mon, 18 Jan 2021 15:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 19242385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610983988; bh=XC7KRMeUDNxNiOYz2a2HT8kOQVSM5OckAmd87Y8oQvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hgl09VVwWWUMo6xbZvho6YKf49FldIleZSiRXJB/6yjTJXdm/9mOVi7QLoRNczXSn
         z0rsd77UdJa9mlf2KToHng++tJWfI/Ki75i2X3pwZKrAFu+X1rQ/7RFP2hJvwFtTj9
         1AvD90LFLMz56/2Bv2cFx1DASAooc/lIET6qCLuiMNogN9vpr3FvDet29oEKaakx/a
         O6CgOvtZxNF7QAFCYuzpjBYkymQZxHwrugaW9v1EqXyM3PmNGvtDrOWTM5b/ByD6cf
         mYScIrliAi1Kv0zdwe33Fn6AZuH3Up8MEFNwMWADXzQxQigbIZvRScJgumYVWMA9I5
         4C08pDaZOSylA==
Date:   Mon, 18 Jan 2021 08:33:06 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next] docs: bpf: Fixup atomics documentation
Message-ID: <20210118083306.4c16153d@lwn.net>
In-Reply-To: <20210118113643.232579-1-jackmanb@google.com>
References: <20210118113643.232579-1-jackmanb@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 18 Jan 2021 11:36:43 +0000
Brendan Jackman <jackmanb@google.com> wrote:

> This fixues up the markup to fix a warning, be more consistent with
> use of monospace, and use the correct .rst syntax for <em> (* instead
> of _). It also clarifies the explanation of Clang's -mcpu
> requirements for this feature, Alexei pointed out that use of the
> word "version" was confusing here.

This starts to sound like material for more than one patch...?

> NB this conflicts with Lukas' patch at [1], here where I've added
> `::` to fix the warning, I also kept the original ':' which appears
> in the output text.

And why did you do that?  

> [1] https://lore.kernel.org/bpf/CA+i-1C3cEXqxcXfD4sibQfx+dtmmzvOzruhk8J5pAw3g5v=KgA@mail.gmail.com/T/#t
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  Documentation/networking/filter.rst | 30 +++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> index f6d8f90e9a56..ba03e90a9163 100644
> --- a/Documentation/networking/filter.rst
> +++ b/Documentation/networking/filter.rst
> @@ -1048,12 +1048,12 @@ Unlike classic BPF instruction set, eBPF has generic load/store operations::
>  Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW.
>  
>  It also includes atomic operations, which use the immediate field for extra
> -encoding.
> +encoding: ::

Things like this read really strangely.  Just say "encoding::" and be done
with it, please.

Thanks,

jon
