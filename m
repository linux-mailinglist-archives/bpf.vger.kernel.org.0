Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4FC25FE00
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgIGQEx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgIGOs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:48:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B6C061574
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so16040168wrl.12
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zcr/JFbOol6wmiv3ts+IPWkhlKfqLS4DXUzUuwROYDw=;
        b=0O3oYQouP6wny4HR0gX5uARvtGXyrY1DyzJZK3wGPwhHGxlCX3Q/uq/fr17tsdKEgr
         vaHacKzgK7VM0YacBH7cQ52DJtd17+SIPF228cYeU9lT6dy5+yroVGshCr/fJbRRwOdp
         IpoSsgtIUGdRjPc/+f20/y4xH1lzu6Shr6y6KEMLUYyIiXg7BPC7KQAJmwLMDMxkHHSQ
         ntFbNX2Zgx5qjmDo5vxrg81KTupVnej1fzOU54WUzEHdJB5CnP4FcUI3nfofZQ3pkbfu
         VY0VvI329twT2iXY3JnkdHUcp++xOm0jFVIhNN0OR3M5t4OPzVeGNoXN/WZ4z0RmHn2O
         6LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zcr/JFbOol6wmiv3ts+IPWkhlKfqLS4DXUzUuwROYDw=;
        b=hwFxpZiDRNRu43QN63GHxFx80I7c9EhgKFZYJzuQII79KxwWybRnrbHY6YnSDUNr4A
         SMrXwYa839uTK+eYYrbtUWqDe2kJ1gUaZggI0HLHsdkrCI92BhbNNwX/HFbIWDJcrSqv
         UFoREdjPjwMrzVj9bJuGxc9tYGGaJQ6e7biBIrmM9SGK0xDH9WRGc6O/XnLJedAjZ8Vq
         OkZoisHrym0nv3+rdc6qDXZA+F04MMtKwSi696SLliuz2ZtANClpK7OQmaBAhLZRi2gO
         MFDOTToxb8N68okwzE1/gMZjq0//eITgGrfA4JCQYJ3aWJ7sVPa37FeZD511lI7bei/a
         RsYw==
X-Gm-Message-State: AOAM530BjL5wE0btNrM9uNfdScYJAw5ruZdZSTfPpsSRlrs6T5c+ONHQ
        Uu5c1mfqDhWadr2qFJkTVvmIwA==
X-Google-Smtp-Source: ABdhPJxuVdu3o+AbMraDvK4KyLqjFrn9eH5E67uU3ldgNAGrPeezXenWLxcTp4eXcRkUZWkg9FfyDQ==
X-Received: by 2002:adf:b442:: with SMTP id v2mr23710487wrd.213.1599490104922;
        Mon, 07 Sep 2020 07:48:24 -0700 (PDT)
Received: from [192.168.1.12] ([194.35.119.57])
        by smtp.gmail.com with ESMTPSA id d190sm28977705wmd.23.2020.09.07.07.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 07:48:24 -0700 (PDT)
Subject: Re: [PATCH bpf-next 0/3] bpf: format fixes for BPF helpers and
 bpftool documentation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
References: <20200904161454.31135-1-quentin@isovalent.com>
 <CAEf4BzYi8ELhNhxPikFQLQmB7HAXr7sRsyKi6QYJs+XBoDiwhw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <35e3b69b-3df3-d384-9969-b03d1c816bb5@isovalent.com>
Date:   Mon, 7 Sep 2020 15:48:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYi8ELhNhxPikFQLQmB7HAXr7sRsyKi6QYJs+XBoDiwhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/09/2020 22:40, Andrii Nakryiko wrote:
> On Fri, Sep 4, 2020 at 9:15 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> This series contains minor fixes (or harmonisation edits) for the
>> bpftool-link documentation (first patch) and BPF helpers documentation
>> (last two patches), so that all related man pages can build without errors.
>>
>> Quentin Monnet (3):
>>   tools: bpftool: fix formatting in bpftool-link documentation
>>   bpf: fix formatting in documentation for BPF helpers
>>   tools, bpf: synchronise BPF UAPI header with tools
>>
>>  include/uapi/linux/bpf.h                      | 87 ++++++++++---------
>>  .../bpftool/Documentation/bpftool-link.rst    |  2 +-
>>  tools/include/uapi/linux/bpf.h                | 87 ++++++++++---------
>>  3 files changed, 91 insertions(+), 85 deletions(-)
>>
>> --
>> 2.20.1
>>
> 
> This obviously looks good to me:
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> But do you think we can somehow prevent issues like this? Consider
> adding building/testing of documentation to selftests or something.
> Not sure if that will catch all the issues you've fixed, but that
> would be a good start.
> 

Thanks for the review.

As for preventing future issues, I see two cases. Some minor fixes done
to harmonise the look of the description for the different helpers could
be checked with some kind of dedicated checkpatch-like script that would
validate new helpers I suppose, but I'm not sure whether that's worth
the trouble of creating that script, creating rules and then enforcing them.

The issues that do raise warnings are more important to fix, and easier
to detect. We could simply build bpftool's documentation (which also
happens to build the doc for eBPF helpers) and checks for warnings. We
already have a script to test bpftool build in the selftests, so I can
add it there as a follow-up and make doc build fail on warnings.

On a somewhat related note I also started to work on a script to check
that bpftool is correctly sync'ed (with kernel regarding prog names /
map names etc., and between source code / doc / bash completion) but I
haven't found the time to finish that work yet.

Quentin
