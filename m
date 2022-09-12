Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF65B5756
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiILJnT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiILJnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 05:43:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51F27CC6;
        Mon, 12 Sep 2022 02:43:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bq9so14429355wrb.4;
        Mon, 12 Sep 2022 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=whFntIzUpcvDtnBm7FBQbpgonKohtryF1V2AtmqVNB4=;
        b=fU8UujsNk7v/6OuYU88YPT0CHT0RBTh7wrGVq//9vIeB8ROtnC4JCtHkfy495U2m+k
         Mc0u2aVLyfaItgcRPbyvgQb7mXXNSdS4ZL4YrKdUYrf6XAXNQdLbUtae1QaaDVCMZK2U
         h/mtDxUGO6dzvP+PjQIFQ0RYAf98msXGP4zj0BtkcSjHvCSppqW79UE3tr7D7ZO2zx2r
         fjpRpk7dciPz8Dh/06OgyHy7l+4PKWSrZVUn4TT8KPTE3C0PPetUo7+ocP1QtxxMDwSw
         1EEs4iTQWvoKp38QpqU8Wm/1zgHi+UWD8nxcIm5n64aJ3OcCHe35s4jJLlU9Q72EGW/f
         Dk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=whFntIzUpcvDtnBm7FBQbpgonKohtryF1V2AtmqVNB4=;
        b=Q95IOIwQNf3uRzWHuk4AKX37TzeS9VQ75lO1ckyPvky+K1rhOk0r9dKILpV/Nv1K2M
         J/8EmLXDNGGxhxolAwd9u7UKg7O3WPbFdNEKeTT60G4ThcmpCgFV52uVsdlSup8u6g0S
         HiAXD8deHeyrpe87nT0nclbWMEAZfJdIqtmBBXZJZZDADcZx30wia2CBJRYiuVjNuubW
         hAYcyJpnx4B6rWwK5ybRPZTPMjwl1LTN+IsCRd/5NxwgDFZ/0g2LpnOEyudap0STn2K+
         U38CWfDRhy+UHXrmtBJLM4qOmuMo2g6WvSsurebdgUXjEVZ7o8SCdbuNQC6Zwa8jginY
         EEAA==
X-Gm-Message-State: ACgBeo2oTP5KcVFN0+5za2Dqh0jpBr0Sw5mNIwj7cRa9zj0EWcr+KLy8
        iJ2tjjKaVzO4+vSmuu0E+mc=
X-Google-Smtp-Source: AA6agR7j8sjMW8SpsLL9tP28CeKyROqsTSry0YM32AC65MrMP+QWDL6W2Z/AtQTuBihG70JVJnUp+g==
X-Received: by 2002:adf:d1cc:0:b0:22a:47d5:8a22 with SMTP id b12-20020adfd1cc000000b0022a47d58a22mr5656011wrd.481.1662975795698;
        Mon, 12 Sep 2022 02:43:15 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a19a:6418:7e1e:227a])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d5387000000b00228d52b935asm6796018wrv.71.2022.09.12.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 02:43:15 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v3 0/2] Add table of BPF program types to docs
In-Reply-To: <CAEf4Bza1vGKeGj45wt_vxiQG=voeOU33KSGsjJ-qJERpuhdW8A@mail.gmail.com>
        (Andrii Nakryiko's message of "Fri, 9 Sep 2022 15:24:20 -0700")
Date:   Mon, 12 Sep 2022 09:44:07 +0100
Message-ID: <m2y1up0yp4.fsf@gmail.com>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
        <CAEf4Bza1vGKeGj45wt_vxiQG=voeOU33KSGsjJ-qJERpuhdW8A@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Aug 29, 2022 at 2:15 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>>
>> Extend the libbpf documentation with a table of program types, attach
>> points and ELF section names. The table uses data from program_types.csv
>> which is generated from tools/lib/bpf/libbpf.c during the documentation
>> build.
>>
>> Patch 1 adds subdir support to Documentation/Makefile and changes
>> userspace-api/media to use this instead of being a special case.
>>
>> Patch 2 adds the program_types documentation with a new makefile in
>> the libbpf doc directory to generate program_types.csv
>>
>> I plan to look at adding info about the format of section "extras" for
>> each program type as a follow-on.
>>
>> v2 -> v3:
>> Put program_types after API docs in TOC as suggested by Andrii Nakryiko
>> Fix formatting as reported by Andrii Nakryiko
>> Include USDT extras example as suggested by Andrii Nakryiko
>> Include sample of program_types.csv as suggested by Andrii Nakryiko
>>
>> v1 -> v2:
>> Automate the generation of program_types.csv as suggested by
>> Andrii Nakryiko.
>>
>> Donald Hunter (2):
>>   Add subdir support to Documentation makefile
>>   Add table of BPF program types to libbpf docs
>>
>>  Documentation/Makefile                     | 16 ++++++-
>>  Documentation/bpf/libbpf/Makefile          | 49 ++++++++++++++++++++++
>>  Documentation/bpf/libbpf/index.rst         |  3 ++
>>  Documentation/bpf/libbpf/program_types.rst | 32 ++++++++++++++
>>  Documentation/bpf/programs.rst             |  3 ++
>>  Documentation/userspace-api/media/Makefile |  2 +
>>  6 files changed, 103 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/bpf/libbpf/Makefile
>>  create mode 100644 Documentation/bpf/libbpf/program_types.rst
>>
>> --
>> 2.35.1
>>
>
> This is marked as Changes Requested, so I presume there are some
> fixes/updates pending on top of v3? BPF CI should probably be done as
> a follow up, though.

Yes, there is a typo reported by Jesper Brouer that will require a v4.

> But otherwise looks good to me and I appreciate the effort to improve
> libbpf's documentations.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

This patchset will break the documentation build in the libbpf GitHub
repository when Documentation/bpf/libbpf gets synced to there.

At a minimum, I think I would need to refactor this patchset so that it
is easier to integrate the .csv generation into the libbpf GitHub
documentation build. But a simpler way forward might be to move this
entirely to the libbpf Github repository and then just add a readthedocs
URL to Documentation/bpf/libbpf/index.rst, the same as currently done
for the API docs.
