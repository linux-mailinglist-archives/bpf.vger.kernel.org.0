Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB53276B2B
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 09:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIXHtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgIXHtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 03:49:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A3C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 00:49:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id q8so2815254lfb.6
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=6Kc0laKYt4RRRQxmQCwLwMgBiR0SOayw6ZIZ3NjLZfs=;
        b=UH8joUyX5r6s10La3uodfQpG/HN4nMDpaYuqSyzmd20YBL2flGB5czAXVoHMV7H94k
         DcGYBcxZDCw9eqqigNdCyXwsCKVQ162b1JzPH0o/HumvqTMl5jRE2jl8kKB5/8TSIjnb
         TfreBnpFOhc/Jp5lqTCBe1DXhMVcn3UPOvBgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=6Kc0laKYt4RRRQxmQCwLwMgBiR0SOayw6ZIZ3NjLZfs=;
        b=hIuK3aJI19AXkvwARWDhhOv4IG6iPnRG6yYwCh4loa8Jih/NDY50AAy0bMcmzyHBHz
         /+tHaTHvZ2PtIS1ceZUfPQjWMZkxTbad1+YRta3yxMkIzBma/ma+PcM0NL/gCe5aDcFr
         IeE0PSB3kjUpRmfGIcvGeuRvDo1c+kycuSG898valh9vfVrzRnMjX99E/pKghb6dY1Wi
         VRTxwQh6dOAPGwPhpPOdlLm8J/M9ikUtykLNTfKihhtt9L67o/RmoYzt7iMubU4DUV/2
         WiZdm7D3HpII3GiHsqWDuQA2yCr/mUg+Mi0UEAeB02HETM5EF7hOe8pNl5gHz122UI5n
         SQRg==
X-Gm-Message-State: AOAM532pPULyGChTefe85TYFYfWJ9cbbjBefWEKMcjXXSE8KEUmyMOFy
        13KLyXWM1H+jVhKaDShd0lO5bSC7IIogdQ==
X-Google-Smtp-Source: ABdhPJybaEbfYjPwFgudvXUCVYdA0IZCkC9QiZGHAYJ8s+XWfgYvaSX5Tsn9AACgqF51egvOizLcrw==
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr1283637lfo.558.1600933778181;
        Thu, 24 Sep 2020 00:49:38 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 5sm1325726lfr.289.2020.09.24.00.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:49:37 -0700 (PDT)
References: <20200909232443.3099637-1-iii@linux.ibm.com> <20200909232443.3099637-3-iii@linux.ibm.com> <CAEf4BzYGbzwwDLAUdBB+fj1XYRFddOgUUYFAmUmq=jYpPAsaog@mail.gmail.com> <cf1a51289051cbe3d70e9a755c64f4da8ccf15a5.camel@linux.ibm.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Fix endianness issues in sk_lookup/ctx_narrow_access
In-reply-to: <cf1a51289051cbe3d70e9a755c64f4da8ccf15a5.camel@linux.ibm.com>
Date:   Thu, 24 Sep 2020 09:49:36 +0200
Message-ID: <87imc3ty0f.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 11:12 PM CEST, Ilya Leoshkevich wrote:
> On Thu, 2020-09-10 at 09:55 -0700, Andrii Nakryiko wrote:
>> On Wed, Sep 9, 2020 at 6:59 PM Ilya Leoshkevich <iii@linux.ibm.com>
>> wrote:
>> > This test makes a lot of narrow load checks while assuming little
>> > endian architecture, and therefore fails on s390.
>> > 
>> > Fix by introducing LSB and LSW macros and using them to perform
>> > narrow
>> > loads.
>> > 
>> > Fixes: 0ab5539f8584 ("selftests/bpf: Tests for BPF_SK_LOOKUP attach
>> > point")
>> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > ---
>> 
>> Jakub,
>> 
>> Can you please help review this to make sure no error accidentally
>> slipped in?
>
> Gentle ping.

Sorry for being unresponsive. I've been off for a couple of weeks.

I'm on it.

[...]
