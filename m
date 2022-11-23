Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA9636C4A
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiKWVUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiKWVUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:20:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA961B9E
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:20:45 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt23so64781ejc.7
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKWY+IP0D2LJE3XqUCIEfOW+yaY6JUxWjRWqEZWcNeE=;
        b=iSNJpIpxttQAfR0c0NKFXCLs3bIewtLyOuLK5am4pYyk2GiR+3PsraPxYGOYxmNsqB
         ICpYSdpTHEgN8GOPWMB1f5wP/dG13e8CeP22Gywd84wGtnyZeUsoiQyzoLEtwR01Iaka
         t1+owYeYz6TdJoKkzy7dmLMVnZWYej9BK8qapdt9aVN/If/VunyD991F83ZN6+Xr41yD
         M+GY04g22FjiTDjA3bcp4OKx/7/ZOWwh5xv67KGvL119edbZZTZIIWS7IJXYYglpkwQC
         W4SuhFD7PrnQtnlNLG77mP+JkxGld3yhnXwL6dy/THUEQHgQheVBHGzUHZTRxSqlmi43
         kUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKWY+IP0D2LJE3XqUCIEfOW+yaY6JUxWjRWqEZWcNeE=;
        b=ELCDmVJ0J2KEz9xQoJ0L4mCMfnAbKp2JbPuVBXaNrHA76z/D8ZrhyOtrsuVM1t2kbe
         ScJk413C+AEse8JUz7/P283DFuxrej4ri0xDMI8JpKFkuZQmShz4LOkmWzH6HuQPq+sd
         6CL24C5cq8ZQg73K+Wvh0yqm0NpRknChoYStQH9/2Yp9KB0fSer19qToZJJ0HGW8Vdnh
         4jI1QcQNvsjEa49CKy0x7tzJcI1Uq/2ppyiZZ6ZGeqTqwMIwwnLLewrF12BdHFceF2OL
         gLz/TqQzOAUscJZ0g1pxyJTUW79VeggJF3OodWLBWnsgvIHrJzle+2nxPiAWS0ameRwr
         RJww==
X-Gm-Message-State: ANoB5pll2BUSGt3UjspiO7NzfynZlLxVVaS3wjJoYSFmDxkRx45hq6Nz
        C/Y0msXWxEx3kUkntaC4b34=
X-Google-Smtp-Source: AA0mqf6e/5Ow7IC+1bMKvCJ7H9A2EbxXL844EL0RqRshMcFvIIV42XnEWfeiQkzKTtEUlkGVW9IbSQ==
X-Received: by 2002:a17:906:398b:b0:7ad:b868:f096 with SMTP id h11-20020a170906398b00b007adb868f096mr25742301eje.295.1669238444355;
        Wed, 23 Nov 2022 13:20:44 -0800 (PST)
Received: from krava ([83.240.62.201])
        by smtp.gmail.com with ESMTPSA id kv11-20020a17090778cb00b007b8e069769esm1919841ejc.104.2022.11.23.13.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:20:43 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 23 Nov 2022 22:20:41 +0100
To:     Yonghong Song <yhs@meta.com>
Cc:     sdf@google.com, Jiri Olsa <olsajiri@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
Message-ID: <Y36OqcjByl8ruOpS@krava>
References: <20221121180340.1983627-1-sdf@google.com>
 <20221121180340.1983627-2-sdf@google.com>
 <Y34QpET78/KX9JLh@krava>
 <34cb2b2f-ac3b-65c4-c479-0c4ed3dda096@meta.com>
 <Y35VrXvKBFg2RJ7y@google.com>
 <63b85917-a2ea-8e35-620c-808560910819@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b85917-a2ea-8e35-620c-808560910819@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 11:07:18AM -0800, Yonghong Song wrote:

SNIP

> > > > if I comment out all the umounts in setns_by_fd, it does not fail
> > 
> > > Agreed with the above observations.
> > > With the current bpf-next, I can easily hit the above perf event ID
> > > issue.
> > 
> > > But if I backout the following two patches:
> > > 68f8e3d4b916531ea3bb8b83e35138cf78f2fce5 selftests/bpf: Make sure
> > > zero-len
> > > skbs aren't redirectable
> > > 114039b342014680911c35bd6b72624180fd669a bpf: Move skb->len == 0
> > > checks into
> > > __bpf_redirect
> > 
> > 
> > > and run a few times with './test_progs -j' and I didn't hit any issues.
> > 
> > My guess would be that we need to remount debugfs in setns_by_fd?
> > 
> > diff --git a/tools/testing/selftests/bpf/network_helpers.c
> > b/tools/testing/selftests/bpf/network_helpers.c
> > index bec15558fd93..1f37adff7632 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.c
> > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > @@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
> >       if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
> >           return err;
> > 
> > +    err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
> > +    if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
> > +        return err;
> > +
> >       return 0;
> >   }
> 
> Ya, this does fix the problem. Could you craft a patch for this?

same here ;-) thanks

jirka
