Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7281587AAC
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiHBK2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiHBK2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 06:28:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7422B3D
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 03:28:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q30so12884853wra.11
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 03:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0OENZloJKm9avmDym7xq0Z2MWr8NFFE+ntJffHhF/2E=;
        b=cVAyKcZ9VBM9WrJobvLsa6Y2reI7Tugg5hRoEQaOGyJHNg6R53RovJsuJ6vzyflNLX
         I7Yq3Cv1uUSbZTfcay5b5uPGMOXrjPXW0MryMQ11caHmQmz3J7SE2sLEnpEg5mk3kp7j
         qYW6vXsv9maoLRmzPJC6/ZJZ+X+gLh7Wp0aqlk7duq8M6sx7oMsMr7vGIWu7qrZFXUCZ
         9eBOsrzyy3V4HSdEjwTzu4vtCQMjvnx00uQTLsGEtt9tnB3z1bB2bUUpCUnlky6WCUIQ
         Bkru2guOWk0tnU9GSQxXA30P8oSl6xmamgqChyJS3ojjL+dJYKDLcjX69GIHuqGtRRva
         GTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0OENZloJKm9avmDym7xq0Z2MWr8NFFE+ntJffHhF/2E=;
        b=YVTC/oM0SQc3jUz7VGToC1ERtMHaCNfz7glCIo4cFKBIREu8Ju2gFZ6x92qHWOtR0w
         8VTC63k4O3pP/O0rKUAW7BXQgijhJgV4jy3zP/AHf+LoI3f07eOR27XXTp/Zrx5P7WeD
         Q9+w4eGtHpQUwMywQ1TSj1nEgI9rBsqcT7aArmfcoIttTOPEsh7BZgO05deMBhAqz9/6
         T1AImZsDwVIP7oWRbVerjldiK4Y7ThEG6TvVkmaWkbOwvfEy9eeO+6Dks9oZB6+NCaJS
         Pcb+78nQ2UKNyPpEMxqz9xgqMn6SzjuSlXn9LC1iCGHyJCVeKHirMp2aUmytRblnddLR
         g1Xw==
X-Gm-Message-State: AJIora/jskhGl0qqjC5OxDeKWLYqlqP+yuVZz2tgXzFXWtp99TFMxxV3
        XTTd+yDC0FVchqYNX/Alav2XqAhGSKkA+JSH
X-Google-Smtp-Source: AGRyM1t4mlXG37lQyec+9KvODNmthZ8zl3oI+zCZWkU+dijUeNLprGP2BdqGjqeWSGB6UHMCvNLz8w==
X-Received: by 2002:a7b:c453:0:b0:3a3:1c65:ff97 with SMTP id l19-20020a7bc453000000b003a31c65ff97mr13127263wmi.180.1659436090152;
        Tue, 02 Aug 2022 03:28:10 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b0021e5cc26dd0sm14591655wrr.62.2022.08.02.03.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:28:09 -0700 (PDT)
Message-ID: <d7cd119b-fc34-8e14-6560-5d2cf5567e80@isovalent.com>
Date:   Tue, 2 Aug 2022 11:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: bpf-helpers.7: .TH line is... meh (was: [PATCH] bpf_doc.py: Use
 SPDX-License-Identifier)
Content-Language: en-GB
To:     Alejandro Colomar <alx.manpages@gmail.com>, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org
References: <20220721110821.8240-1-alx.manpages@gmail.com>
 <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>
 <c5462667-377a-1544-f255-e57b9823df6a@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <c5462667-377a-1544-f255-e57b9823df6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/08/2022 23:13, Alejandro Colomar wrote:
> Hi Daniel,

Hi Alejandro,

I'm probably more familiar with this matter than Daniel, so let's see.

> 
> On 7/22/22 00:50, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>>
>> This patch was applied to bpf/bpf-next.git (master)
>> by Daniel Borkmann <daniel@iogearbox.net>:
>>
>> On Thu, 21 Jul 2022 13:08:22 +0200 you wrote:
>>> The Linux man-pages project now uses SPDX tags,
>>> instead of the full license text.
>>>
>>> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
>>> ---
>>>   scripts/bpf_doc.py | 22 +---------------------
>>>   1 file changed, 1 insertion(+), 21 deletions(-)
>>
>> Here is the summary with links:
>>    - bpf_doc.py: Use SPDX-License-Identifier
>>      https://git.kernel.org/bpf/bpf-next/c/5cb62b7598f2
>>
>> You are awesome, thank you!
> 
> Oh, what a nice bot :)
> 
> 
> I've been running a linter on the man-pages, and had this triggered from
> bpf-helpers.7:
> 
> [
> $ make lint V=1
> LINT (groff)    tmp/lint/man7/bpf-helpers.7.lint-man.groff.touch
> groff -man -t -M ./etc/groff/tmac -m checkstyle -rCHECKSTYLE=3 -ww  -z
> man7/bpf-helpers.7
> an.tmac:man7/bpf-helpers.7:3: style: .TH missing third argument; suggest
> document modification date in ISO 8601 format (YYYY-MM-DD)
> an.tmac:man7/bpf-helpers.7:3: style: .TH missing fourth argument;
> suggest package/project name and version (e.g., "groff 1.23.0")
> an.tmac:man7/bpf-helpers.7:3: style: .TH missing fifth argument and
> second argument '7' not a recognized manual section; specify volume title
> found style problems; aborting

Not sure I understand this last one. Isn't "7" a valid man section?

> make: *** [lib/lint-man.mk:49:
> tmp/lint/man7/bpf-helpers.7.lint-man.groff.touch] Error 1
> 
> ]
> 
> See what a normal .TH line looks like, and what bpf-helpers.7 has:
> 
> [
> $ grep ^.TH man2/bpf.2
> .TH BPF 2 2021-08-27 "Linux" "Linux Programmer's Manual"
> $ grep ^.TH man7/bpf-helpers.7
> .TH BPF-HELPERS 7 "" "" ""
> ]
> 
> 
> I don't know if you can fix that, or if it's a limitation of the
> generator?  I can live with it, but it would be nice if it could be
> fixed.  It provides the headers and footers of the manual page.

I had never really looked into completing this line before, but it seems
that Docutils/rst2man has a few (albeit not much documented) docinfo
elements available to complete _some_ of these fields. We currently have
":Manual section: 7" in the generated page. I can generate a page close
to the result above with:

    :Manual section: 7
    :Manual group: Linux Programmer's Manual
    :Version: Linux
    :Date: 2022-08-02

With these fields, I get:

    .TH BPF-HELPERS 7 "2022-08-03" "Linux" "Linux Programmer's Manual"

Caveats: First, we get additional double quotes around the date, not
sure if this matters.

Second: “Version” does not seem a relevant field name in that case, but
this is apparently the only option that we have to insert a value at
this location [0]. Apparently the manpage writer for Docutils assumes
that this line contains a version number [1].

Third: The date should of course be updated when generating the page. I
found that rst2man has a "--date" option, but it does not insert it at
the location we want. Instead, it would probably be a matter of adding a
sed command to the pipeline, something along:

    $ ./scripts/bpf_docs.py helpers | \
        sed -e "s/__DATE__/$(date -I)/" | \
        rst2man | man -l -

If it looks better for the man-pages repo, I can send a patch for the
man-page template in bpf_docs.py to set ":Manual group:" and
":Version:". I can also ask on the docutils mailing list if there is a
cleaner way to proceed, without falling back to this ":Version:" field.

Regards,
Quentin

[0]
https://repo.or.cz/docutils.git/blob/f031167579bdbe30781ea51d516d14db2cb5f60e:/docutils/writers/manpage.py#l377
[1] https://docutils.sourceforge.io/docs/user/manpage.html
