Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD02262CE7
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgIIKPl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgIIKPj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 06:15:39 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB0C061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 03:15:28 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id t3so441503ook.8
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G909jQWhCaXPqmLb8B3jyY3qIVsu49gTKwkM75xjL+4=;
        b=CepKm8pp3ANCV8M1b8Nr+MjMhy1vxTJ5wK7GQWCrxAE4QjrbAtfUWxXJWjQbOnKYIc
         XOWYpEIyVVJEaUt+0HzDP7ne2iaTjl2YV86HxfbFWxYcdhZZ9LKG3i8vT0U3q0KjlxPp
         PhBFEF6RcwSfhARzRV+1S4PYEy2XgSlbtqo7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G909jQWhCaXPqmLb8B3jyY3qIVsu49gTKwkM75xjL+4=;
        b=fvxZZMCleydpnGDm4qfGP7y2p0OmB0qSMut53gKfzHK6pfOTaQjcJrHcZ/PnXSdIEA
         hJAFEtDtqVCbZoPZzmwFsxhMCjQENpo/W0exZVO/buS83D6r4jj8+mueDinT1U6Bf41m
         9kVxoAUPYH/6Zb48JBY4gVVnH1+fSRrOgKLsDbE29P/hP74V+SyppRYIcYFv4ClqN6NU
         w4RcUUNpV7/DzSGYeXMNFr62Q8jrO2fz+ACgMekVr4CnJjLIKNLXniMsxSdoisBs4LCp
         d3LToYFInbicyqObNGTjDUa512bGbtUErKwtVk/+qFh4KJup2QeVTkrFHATK5VZbS0He
         9o4Q==
X-Gm-Message-State: AOAM5326LWHKsQHyuxcNpxyM1FTxIgA4mFFzk2V+IIBepUBQF5nJM1zq
        s8dkXVAsIrpLMG9NkZbkuP0o05/yJfEjlqUYeVntIQ==
X-Google-Smtp-Source: ABdhPJyp3bSxXCwYpEBJbrStgwdbba5RK1By34XLw/cgDYyeII5Srt7QxI0fDR7c7Fjj/hdofgmqCxMnKzcyRQXsOck=
X-Received: by 2002:a4a:3516:: with SMTP id l22mr228550ooa.6.1599646527795;
 Wed, 09 Sep 2020 03:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200909061722.pvjjhmzfh3xdrxcw@kafai-mbp>
In-Reply-To: <20200909061722.pvjjhmzfh3xdrxcw@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 9 Sep 2020 11:15:16 +0100
Message-ID: <CACAyw99UsHse+fWsBtSz9VYzri5dhxSdzMWEn8KJ6k9hAVB-fA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/11] RFC: Make check_func_arg table driven
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Sep 2020 at 07:17, Martin KaFai Lau <kafai@fb.com> wrote:
>
> I skimmed through the set.  Patch 5 to 11 are useful.  It is a nice refactoring
> and clean up.  Thanks for the work.  I like the idea of moving out the logic
> after "if (!type_is_sk_pointer(type)) goto err_type;" and moving the null
> register check to the beginning.

Thanks!

> I don't think this set should depend on the sockmap iter set.
> I think the sockmap iter patches should depend on this set instead.
> For example, the changes in patch 1 of the sockmap iter patchset that
> moves out the "btf_struct_ids_match()" logic after the
> "if (!type_is_sk_pointer(type)) goto err_type;" should belong to this set.

That's what I did in the beginning. However this is a much bigger
change to land than sockmap iter, and I anticipate that review will
take longer. Which means it will delay the patchset that I actually
need. Hence my preference to do it this way round, with the minimal
changes necessary in sockmap iter.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
