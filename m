Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D7662DFC
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 19:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbjAISEQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbjAISD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 13:03:59 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FDF44340
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 10:02:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jn22so10337799plb.13
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P87IPDH/o+UtgBFzZzoAmaEbk6ra90DahJtQchGb1xw=;
        b=PoG8HFr83Xf3YCC+3tW757k8wQVZB4YwgB/s/Yl2adBYWJd30uN+Vyns2dlJ99G0lT
         RXQ8qM99TDu//7jXPFSB0QWi4gv60RWrgUOoOraTVsDDkEF/PVx4mwezj969Idsfv2Io
         oYyj3Ksm3/RY0rkRZNEa8T+ZcGR/02RngyyUse8PmHfDDdVDIyf5TQbB6Uwyzae/Uc3U
         cer20IivX2ULrhJIGq9QE5QXhA02HJPuyxgEm83UYGeMexFoTf20sX11TIIyDPK0oiy/
         pXvIzCPyegOaBfTitQwHIJdh891AB6IyhtW7EX694hf5ms+E36DT7nl0CgBiIhrH9G80
         Q9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P87IPDH/o+UtgBFzZzoAmaEbk6ra90DahJtQchGb1xw=;
        b=rLkIfU68DtRK2NKYP/kb0BVZKAFVITGnK7qPf8HTLr3cMRV3lO5SON6u0kcbzawE0T
         e54kJKz0zl4TFQ4ZyeXePxKCX0QKAzAkIY4m+nkXdZH9U8oQ5xhTvgktSnFP5guxvalT
         nOgBPgXkfXokMCq/gm97xLvMYHoEnEq9n8GdgHExK77ESHxKh4EQdxhztlGdWmPjt/OL
         L4/Bb4H2haTrg8RHPgeUpekOBMzihnYUa9lCCPRnT5la9sZQ1izwWBRpGfaFBsmPKSkZ
         mV3pgFi3cusHTzAVhnpJdOGIWKOLHxYwmwZHoFyNEscbt18No4nWe8/dwPgBx9WjcP9h
         /MJw==
X-Gm-Message-State: AFqh2koD3PkApyhkmqBr6C46yP7OY1M31+j4z+9hx8VA3f1fYdO+2t5o
        //jHNOPatLI4rUmMcIFhq6r3wnhaoiR+xmp3ChQe
X-Google-Smtp-Source: AMrXdXsxDXjFgp8RTXOV1v8Pky5ZQjmJZlMVDOBJBZZq13XMLkqlaukrDMA/2t2DKIR2tErSGzGzEfHFlYUSgHH163Y=
X-Received: by 2002:a17:902:cec8:b0:192:6675:8636 with SMTP id
 d8-20020a170902cec800b0019266758636mr3603232plg.15.1673287344795; Mon, 09 Jan
 2023 10:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20230106154400.74211-1-paul@paul-moore.com> <20230106154400.74211-2-paul@paul-moore.com>
 <CAKH8qBtr3A+EH2J6DCaVbgoGMetKbLUOQ8ZF=cJSFd8ym-0vxw@mail.gmail.com>
 <CAHC9VhRLSAbSHE1nTGwjuUdMtfwTsRVjhV+eznWRw5Ju_qgDAA@mail.gmail.com> <Y7xVxT7gWIhRitza@google.com>
In-Reply-To: <Y7xVxT7gWIhRitza@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Jan 2023 13:02:13 -0500
Message-ID: <CAHC9VhRwOjgEDqxw6n16OW4e99tkczZPEcsZ-EvO8zx44yb8ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bpf: remove the do_idr_lock parameter from bpf_prog_free_id()
To:     sdf@google.com
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Burn Alting <burn.alting@iinet.net.au>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 9, 2023 at 12:58 PM <sdf@google.com> wrote:
> On 01/09, Paul Moore wrote:
> > On Fri, Jan 6, 2023 at 2:45 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > On Fri, Jan 6, 2023 at 7:44 AM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > It was determined that the do_idr_lock parameter to
> > > > bpf_prog_free_id() was not necessary as it should always be true.
> > > >
> > > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > >
> > > nit: I believe it's been suggested several times by different people
>
> > As much as I would like to follow all of the kernel relevant mailing
> > lists, I'm short about 30hrs in a day to do that, and you were the
> > first one I saw suggesting that change :)
>
> Sure, sure, I'm just stating it for the other people on the CC. So maybe
> we can drop this line when applying.

That's fine with me.  To be honest, you folks can do whatever tweaks
you want to these patches and that's okay with me; or even just dump
them and rewrite them as you see fit, if that's easier.  I'm only
concerned with getting the regression fixed, who fixes it isn't
something I'm worried about.

-- 
paul-moore.com
