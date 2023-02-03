Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0263E68A220
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 19:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjBCSle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 13:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjBCSlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 13:41:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D6A07F6;
        Fri,  3 Feb 2023 10:41:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u21so6086840edv.3;
        Fri, 03 Feb 2023 10:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpifIZ28oYpL2rBkMbd7e7OHElr8hShCKM0vbyNTnHM=;
        b=KKjSM7vKyvt4YrmL/ZuB8nNdK7UYWgUv5h4MaHT8jo6qaAnP+H4QTrrWr/o+7l0rmn
         JboDpnjh2O96qOqgxIz0AQ+MoZLvnrKZy4sh7FFEw0pDobWIr2c+bxKHo/nrlGfGWorV
         IUgBNvc6+nVRLZVcJ0ZNkHaUBuh7yPSB4awpapcdyZ4hP3e7gKtRUOq3ma7L/1B41cuP
         XN2YprdZRtdb/LMNIwJbqLq4NSiP30d8I8qFpyyq1HuaCv8K2F2I7n7Nr2g21Rpt3SEQ
         KwlmkgXblEoj57BIS09iv8J3dniAGmf97PV1l/ZHShYEB9A55Qk+yURD+Bfl8oV9qh1u
         rwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpifIZ28oYpL2rBkMbd7e7OHElr8hShCKM0vbyNTnHM=;
        b=EYMxfN9kFUVan/3Wn22gTRTmG5Xgk+zQ/5zOY1ImLnQPkGw0/49j3CcGgGpZUyEmsf
         Tz3ZdCjKi1x9p3FiE9zWSizYb5pbof6HHynpYPq3BgofYxoLT9x/MLT+/dsxiRV6222/
         ChJdoEwTBmjd5MLyCvLs2GOBGRpPAjmkHiLpdMDG17HlxE+BOXuZVJ3/R2R8YtiERjb9
         o1pfPBPydjuwdTWlstmHzRVrOoruIVcIG4V+Dgfm1Fdpqyfvhlj1jKwqGJNPhUZuUowW
         KLQtyRxP/AcVn6lrs8J/wat20ltZkRu1SQherxPAc1vGICBpnncNeVH7tIfG2jkn8vWE
         rYiQ==
X-Gm-Message-State: AO0yUKVxDxoGCsvPXNMRzsfuDgrjCcVf+ggDCB7+dOkQq/s7+D2/BOBJ
        wsCXdesXJ/FCFYikhnVySYk=
X-Google-Smtp-Source: AK7set8bCwzpRLUrALPYyi/Fhe7awgEG9OUUNVldhoFItRVeUqiz9kfI+zqUa1FZ8hSea3pjBnuZ7g==
X-Received: by 2002:a05:6402:50d4:b0:4a3:43c1:8436 with SMTP id h20-20020a05640250d400b004a343c18436mr7240485edb.10.1675449688113;
        Fri, 03 Feb 2023 10:41:28 -0800 (PST)
Received: from skbuf ([188.26.57.116])
        by smtp.gmail.com with ESMTPSA id g20-20020aa7c854000000b004a24b8b58cbsm1504907edt.16.2023.02.03.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:41:27 -0800 (PST)
Date:   Fri, 3 Feb 2023 20:41:25 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
Message-ID: <20230203184125.2ka4cor4pefs3337@skbuf>
References: <20230201015015.359535-1-irogers@google.com>
 <Y9o4H61YmbOSCDOG@krava>
 <Y9pCY5IcYEqfNgBX@krava>
 <CAP-5=fVHFMJvaY_UE4QdV-PW+gy1EuyiHDXqWJmHVxS9Mr3XEQ@mail.gmail.com>
 <Y9rQnu6KPj1t8Rog@krava>
 <Y9rXzIm3UY7lzYFt@dev-arch.thelio-3990X>
 <Y9ufUdzOSp9y9qQA@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ufUdzOSp9y9qQA@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Thu, Feb 02, 2023 at 12:32:33PM +0100, Jiri Olsa wrote:
> On Wed, Feb 01, 2023 at 02:21:16PM -0700, Nathan Chancellor wrote:
> 
> SNIP
> 
> > > > Should we do this and the hostprogs migration as a follow up? There
> > > > isn't that much use of hostprogs in tools, but I like that your change
> > > > will show HOSTCC rather than CC during compilation. If we use
> > > > hostprogs can we just avoid the overrides altogether?
> > > 
> > > right, I think so.. we can now remove it for the BINARY target and
> > > then for the rest of 'prepare' once they are converted to hostprogs..
> > > not sure how 'hostprogs' will work for library, will need to check
> > > 
> > > I'll try to send the format patch with the fix below tomorrow
> > > 
> > > Nathan, any chance you could test it?
> > 
> > 
> > Sure thing, would you happen to have a single patch file of what I
> > should test? I am a little confused from reading the thread (unless what
> > you want tested has not been sent yet).
> 
> I meant the change below, but I posted the formal patch now:
>   https://lore.kernel.org/bpf/20230202112839.1131892-1-jolsa@kernel.org/T/#u

I've been chasing the links posted by Ian, but now I can't comment on patch
"tools/resolve_btfids: Compile resolve_btfids as host program", because
lkml wasn't CCed, and I'm not subscribed to the bpf ML. So I'm commenting here.

Can someone please apply the patch linked above? Compiling with
CONFIG_DEBUG_INFO_BTF=y is also broken on net-next.

Maintainers can add my

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

on that patch if it helps speed up the process.
