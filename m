Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6D587B7E
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiHBLWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiHBLWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 07:22:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468B63E740
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 04:22:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso101178wma.3
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TYeTEUPngR9YnSzCPr1EUlp9wqiY6b4xJaMzjAwP0t0=;
        b=jp99q48Dv8PNMNUngavQIIYneqLwle4nTRV+p/PaGWjRHrDUO+OVng9CmozK/alFez
         FIv56s7ALnAjow8ooYT0cQaP64RmJJiuggrjeblfTUMEVMPFJl6F4xQY82J8YjZTM/Kd
         5ueS0Z22RDGwJAOlGT193CKy19bKddixKDeFLIIbt55koYHWxoQYWbfLIZfgziuuLdgU
         DhDpwW6RHm0Aj0vubRfJqAI4O2jgEMeIe3jGt8I5Z6IXPDrxQwsNLi0Yh00rdNVfgQeW
         CLo7TY4Poh6JC0K1eqsUkRKz45GNJcJtwfgdEcGrPa66C1vrx+I850N/jWSVGl6eGmHD
         0G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TYeTEUPngR9YnSzCPr1EUlp9wqiY6b4xJaMzjAwP0t0=;
        b=jTfEdbEMI5VrDwpI38kDUMG873iTWi5BFbppNj0fT9T/bMhdEAckJRcLeMrCfnYCMS
         PrsJmjFWtbYdEhbczD57uRU9XLvAeUpRs78Zd4DO1bnKcvJRuaEtINiY2Uw8VIQiYDQm
         +iiWirp9x69Cegk8PdPFcUbAk3B3AfeW8zHXoc86ngNK6QSlhORUbpc26K39c5BoU0dH
         /mrFZntoQ11KTVUzFAIxWOkbgUufvdck0V/FeI2mauPlo2dxSGxJT3Y1JlkelZvXfwkI
         GtYm71vB03WPRxcU6vyxsmTC6ueolBkqehLl1jKtEEpaZGFXfpYQ1hovmIGskBKcsZx8
         NQUA==
X-Gm-Message-State: AJIora9lp1Q1hK22LzV5gqLKIJzvEe8aMTDmBY08MMATZrbEv8tQEWwd
        oWOwp8Qq4UX12hMSvhoQwqOuMDYwQJdR6JNc
X-Google-Smtp-Source: AGRyM1ubkUS/GmGP8jpYvO2fpWGsoNwLpadlgDUaMkol87amfjsESjvMStr08gR4IZwwB6wFsdJU7A==
X-Received: by 2002:a05:600c:4313:b0:3a3:2c86:9b5c with SMTP id p19-20020a05600c431300b003a32c869b5cmr13781263wme.65.1659439337762;
        Tue, 02 Aug 2022 04:22:17 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003a3442f1229sm28425455wmq.29.2022.08.02.04.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 04:22:17 -0700 (PDT)
Message-ID: <65acd7f9-742a-eecf-ee0b-5f9825933dc7@isovalent.com>
Date:   Tue, 2 Aug 2022 12:22:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: bpf-helpers.7: .TH line is... meh (was: [PATCH] bpf_doc.py: Use
 SPDX-License-Identifier)
Content-Language: en-GB
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net
References: <20220721110821.8240-1-alx.manpages@gmail.com>
 <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>
 <c5462667-377a-1544-f255-e57b9823df6a@gmail.com>
 <d7cd119b-fc34-8e14-6560-5d2cf5567e80@isovalent.com>
 <8f3cf769-4d95-9d16-dab1-bf58b0733af7@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <8f3cf769-4d95-9d16-dab1-bf58b0733af7@gmail.com>
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

On 02/08/2022 11:59, Alejandro Colomar wrote:
> Hi Quentin,
> 
> On 8/2/22 12:28, Quentin Monnet wrote:
>>> I've been running a linter on the man-pages, and had this triggered from
>>> bpf-helpers.7:
>>>
>>> [
>>> $ make lint V=1
>>> LINT (groff)    tmp/lint/man7/bpf-helpers.7.lint-man.groff.touch
>>> groff -man -t -M ./etc/groff/tmac -m checkstyle -rCHECKSTYLE=3 -ww  -z
>>> man7/bpf-helpers.7
>>> an.tmac:man7/bpf-helpers.7:3: style: .TH missing third argument; suggest
>>> document modification date in ISO 8601 format (YYYY-MM-DD)
>>> an.tmac:man7/bpf-helpers.7:3: style: .TH missing fourth argument;
>>> suggest package/project name and version (e.g., "groff 1.23.0")
>>> an.tmac:man7/bpf-helpers.7:3: style: .TH missing fifth argument and
>>> second argument '7' not a recognized manual section; specify volume
>>> title
>>> found style problems; aborting
>>
>> Not sure I understand this last one. Isn't "7" a valid man section?
> 
> It is a valid section.  I don't understand it either.  Maybe groff(1)
> has gone crazy after so many errors.  I'll report a bug to groff.
> 
>>
>>> make: *** [lib/lint-man.mk:49:
>>> tmp/lint/man7/bpf-helpers.7.lint-man.groff.touch] Error 1
>>>
>>> ]
>>>
>>> See what a normal .TH line looks like, and what bpf-helpers.7 has:
>>>
>>> [
>>> $ grep ^.TH man2/bpf.2
>>> .TH BPF 2 2021-08-27 "Linux" "Linux Programmer's Manual"
>>> $ grep ^.TH man7/bpf-helpers.7
>>> .TH BPF-HELPERS 7 "" "" ""
>>> ]
>>>
>>>
>>> I don't know if you can fix that, or if it's a limitation of the
>>> generator?  I can live with it, but it would be nice if it could be
>>> fixed.  It provides the headers and footers of the manual page.
>>
>> I had never really looked into completing this line before, but it seems
>> that Docutils/rst2man has a few (albeit not much documented) docinfo
>> elements available to complete _some_ of these fields. We currently have
>> ":Manual section: 7" in the generated page. I can generate a page close
>> to the result above with:
>>
>>      :Manual section: 7
>>      :Manual group: Linux Programmer's Manual
>>      :Version: Linux
>>      :Date: 2022-08-02
>>
>> With these fields, I get:
>>
>>      .TH BPF-HELPERS 7 "2022-08-03" "Linux" "Linux Programmer's Manual"
>>
>> Caveats: First, we get additional double quotes around the date, not
>> sure if this matters.
> 
> Nah, quotes are only for spaces (they are ignored in this case).  You're
> fine with or without them.
> 
>>
>> Second: “Version” does not seem a relevant field name in that case, but
>> this is apparently the only option that we have to insert a value at
>> this location [0]. Apparently the manpage writer for Docutils assumes
>> that this line contains a version number [1].
> 
> That field seems to be different, depending on who you ask.
> 
> In most cases, it's a "project and version" (see for example the groff
> warning text).
> 
> But in the linux man-pages, since we cover many projects and versions,
> we just say which project we're documenting (to avoid having to update
> the version every time, I guess).
> 
> See man-pages(7):
> [
>    Title line
>        The first command in a man page should be a TH command:
> 
>               .TH title section date source manual
> 
>        The arguments of the command are as follows:
> 
>        [...]
> 
>        source The source of the  command,  function,  or  system
>               call.
> 
>               For those few man‐pages pages in Sections 1 and 8,
>               probably you just want to write GNU.
> 
>               For  system  calls, just write Linux.  (An earlier
>               practice was to write the version  number  of  the
>               kernel  from which the manual page was being writ‐
>               ten/checked.  However, this was never done consis‐
>               tently, and so was probably worse  than  including
>               no  version number.  Henceforth, avoid including a
>               version number.)
> 
>               For library calls that are part of glibc or one of
>               the other common GNU libraries, just use GNU C Li‐
>               brary, GNU, or an empty string.
> 
>               For Section 4 pages, use Linux.
> 
>               In cases of doubt, just write Linux, or GNU.
> 
>        [...]
> ]
> 
> So, just saying ':Version: Linux' would be fine.
> 
>>
>> Third: The date should of course be updated when generating the page. I
>> found that rst2man has a "--date" option, but it does not insert it at
>> the location we want. Instead, it would probably be a matter of adding a
>> sed command to the pipeline, something along:
>>
>>      $ ./scripts/bpf_docs.py helpers | \
>>          sed -e "s/__DATE__/$(date -I)/" | \
>>          rst2man | man -l -
> 
> The date, yeah, I can add it to the pipeline.
> BTW, I reported a bug to rst2man (I CCd you, so you probably already
> know :)).
> 
>>
>> If it looks better for the man-pages repo, I can send a patch for the
>> man-page template in bpf_docs.py to set ":Manual group:" and
>> ":Version:". I can also ask on the docutils mailing list if there is a
>> cleaner way to proceed, without falling back to this ":Version:" field.
> 
> Yeah, please patch :Manual group:.  Also patch :Version: (I think we can
> live with it), although of course feel free to ask about better
> alternatives to it.
> 
> But don't patch :Date: yet.  Let's see what they answer to the bug
> report.  (And if you want, you can wait for the bug report to resolve to
> patch everything at once, of course.)

Thanks for the precisions, and for opening the bug!
OK, I'll follow the discussion on the bug and wait to see how it goes.
I've set a reminder to myself to update the other info in a few weeks if
nothing happens by then.

Thanks,
Quentin



