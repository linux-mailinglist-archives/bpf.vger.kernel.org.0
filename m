Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7046445DC4
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 03:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhKECG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 22:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhKECG0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 22:06:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D534C061714
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 19:03:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z200so5935677wmc.1
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 19:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A/kLks/zJAbqNPgvU1IYi+YJZ7HhxQeyO1xLENQvTFw=;
        b=I4IRDfeHNWXFdDBFFpPOltZGn1XiGF84YxQxMEp1KA79xbM2TGPxiRPBAIL2fT8MFO
         LVvLPgr7Ho56e8r6ZnRrvSIo1VCLTRqIkBe69dmynQ+nQxLH6tGwzPorbfFe8+Lhgkqu
         z3U0TH+T0+dYsuA/jFc+Fp5NZ7SZWSRsqXisErH3fOEpAVd5AB3o1WuHvzAHijWkv7cp
         N4rBj3LB9QG0ccw6+pGjiHVWQ5/DiS6cy4Fws4fo4hWyq+OpUDzu5KWuVEgxqVVjYcUu
         uT4ahy1gROrnUc5qHJjfyRThS1K2gEaMWhsHRk0mnx/GayEa+a7ZTzvLM0XpcTzeEDPe
         +RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A/kLks/zJAbqNPgvU1IYi+YJZ7HhxQeyO1xLENQvTFw=;
        b=OPFYp/SckJYvIP9s+xg3gEvqLRiBrNzvBxTyF99nLDgIbdEt16HzMckLbmQlcDDdWU
         yfOjqubcLivaMI2c6utyLRQVri9FreNgKmVOEjf9ik2y9WDAyRLsmhUMNv4UBSna0mCV
         akR4ybb8W4V45Gb60AESLUESrTXMFRf7FnVrUaHmJrIfnWtkPl2TbcEirZX0PGLaxIBy
         4zkRVtsKP9AnuF/vQGarQ8cejQPT1vdlsw2rjM7NqvFyPTkWKvfB9JGgH9Ehc0L6vCWs
         WH+i4Dn1dgUpJqTaujh8hLsiBF6gQ8r9hMaihqWkkPjvkkvAfSfqC0DEf7SV21EpDxN3
         K3Sg==
X-Gm-Message-State: AOAM532neQYVNInTSKPjtHqtVm/u4YK3o3sTiEdMw7juK73m5yc5+lSk
        WkEIQ/HUCIMO1YBEPHtJmvo9gw==
X-Google-Smtp-Source: ABdhPJxAwH8MgcXU4pgA4lTnSk4HBJexF3Dh0HlhRV1Q8xoT6NkE1WqN7eYpbEfKwlirssiVggayAA==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr27809906wmc.5.1636077826180;
        Thu, 04 Nov 2021 19:03:46 -0700 (PDT)
Received: from [192.168.1.11] ([149.86.70.55])
        by smtp.gmail.com with ESMTPSA id c79sm6820714wme.43.2021.11.04.19.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 19:03:45 -0700 (PDT)
Message-ID: <85136cd4-edb1-ff6f-5379-f64db5caae5d@isovalent.com>
Date:   Fri, 5 Nov 2021 02:03:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge with
 upstream
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YYQadWbtdZ9Ff9N4@kernel.org>
 <CAEf4Bzaj4_hXDxk18aJvk2bxJ-rPb++DpPVEeUw0pN-tJuiy0Q@mail.gmail.com>
 <YYQhzbh1tL5MPgaI@kernel.org>
 <83f48296-fa72-a27f-5acb-654b51cd848f@isovalent.com>
 <YYQ/WMJ9mitKB/PO@kernel.org> <YYRGaKbfJCe6XElu@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <YYRGaKbfJCe6XElu@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-11-04 17:45 UTC-0300 ~ Arnaldo Carvalho de Melo <acme@kernel.org>
> Em Thu, Nov 04, 2021 at 05:15:20PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Nov 04, 2021 at 06:15:57PM +0000, Quentin Monnet escreveu:
>>> 2021-11-04 15:09 UTC-0300 ~ Arnaldo Carvalho de Melo <acme@kernel.org>
>>>> Em Thu, Nov 04, 2021 at 10:47:12AM -0700, Andrii Nakryiko escreveu:
>>>>> On Thu, Nov 4, 2021 at 10:38 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
>>>>> cc Quentin as well, might be related to recent Makefiles revamp for
>>>>> users of libbpf. But in bpf-next perf builds perfectly fine, so not
>>>>> sure.
> 
>>>> This did the trick:
> 
>>>> ⬢[acme@toolbox perf]$ git show
>>>> commit 504afe6757ec646539ca3b4aa0431820e8c92b45 (HEAD -> perf/core)
>>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>> Date:   Thu Nov 4 14:58:56 2021 -0300
> 
>>>>     Revert "bpftool: Remove Makefile dep. on $(LIBBPF) for $(LIBBPF_INTERNAL_HDRS)"
> 
>>>>     This reverts commit 8b6c46241c774c83998092a4eafe40f054568881.
> 
>>>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
>>>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>>>> index c0c30e56988f2cbe..c5ad996ee95d4e87 100644
>>>> --- a/tools/bpf/bpftool/Makefile
>>>> +++ b/tools/bpf/bpftool/Makefile
>>>> @@ -39,14 +39,14 @@ ifeq ($(BPFTOOL_VERSION),)
>>>>  BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
>>>>  endif
> 
>>>> -$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DIR):
>>>> +$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT):
>>>>         $(QUIET_MKDIR)mkdir -p $@
> 
>>>>  $(LIBBPF): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_OUTPUT)
>>>>         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) \
>>>>                 DESTDIR=$(LIBBPF_DESTDIR) prefix= $(LIBBPF) install_headers
> 
>>>> -$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_DIR)
>>>> +$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h $(LIBBPF)
>>>>         $(call QUIET_INSTALL, $@)
>>>>         $(Q)install -m 644 -t $(LIBBPF_HDRS_DIR) $<
> 
>>> Interesting. I needed that patch because otherwise I'd get errors when
>>> compiling bpftool after the switch to libbpf's hashmap implementation.
>>> For the current breakage, it could be a matter of how we pass variables
>>> when descending into bpftool/ from perf's Makefile.perf. I'll try to
>>> look at this in details, and to experiment tonight, if I can. (Thanks
>>> Andrii for the CC!)
>  
>> yeah, if we pass the location for those headers from the perf side, it
>> should work.
> 
> But it isn't obvious how perf should communicate to bpftool where to
> find bpf/bpf.h for the bootstrap make target, which seems something
> bpftool should know.
> 
> Anyway, I'm calling it a day, will get back to this tomorrow, if you
> don't beat me to it.

Found it. The issue is on bpftool's side.

Background context: I've recently changed the way that bpftool (and
other tools) include libbpf's headers: now they "install" the API
headers locally, instead of including them directly from libbpf's source
directory. Looks like I forgot perf's Makefile in the process by the
way, I've sent a patch to address this (but this is not the cause of the
breakage).

For bpftool, we need to build two versions of libbpf, the bootstrap
version (for bootstrap bpftool) and the "regular" one. But I made the
Makefile export the API headers from libbpf only once, for the "regular"
build, and not for the bootstrap build. For bpftool it doesn't matter,
because the bootstrap bpftool build always occurs after libbpf has been
built and its headers have been exported.

For other tools relying on bootstrap bpftool only, like perf, this means
that the libbpf headers are not installed. For some time, the build was
still working, because the regular build for libbpf (with its export of
the headers) was passed as a dependency to another step required by the
bootstrap bpftool, such that the headers were (involuntarily) installed
for bootstrap bpftool. This was changed in commit 8b6c46241c77, the one
that you proposed to revert. That commit removes the dependency on the
"regular" libbpf build for the bootstrap bpftool. It's cleaner, but it
breaks the build for tools that just need boostrap bpftool.

Anyway. I just sent a fix, in which I propose to also install libbpf's
headers for the bootstrap build.

Quentin
