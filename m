Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF15807D6
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 00:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiGYWxm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 18:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbiGYWxl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 18:53:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FEC248CB
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 15:53:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m17so17621193wrw.7
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/W5yt/hqpa2H9l51KPyc7KtGFLwJRO5GtKdVuzCYcYE=;
        b=eRiyLuxpX5qC8hQzrRkg9frLl3gSC//o1oyul/HoGdiNoF4so6toscBjafhGAfLQqp
         UCQghoJOnPMwYy0xIHbRlsbkOyD4ektNaPpsrnGpnIlwnydmsHdNvVWSDXiObsYavolQ
         7R9fpfH9/S4xUCE48oVAhrrLdNjiAmJBq47B5m9UMaOVMHUD9QB7mJrifTVcP6fdgeH8
         wIXb/bkULIJKGTX2mtNfykVdShVFSTtMxCwl2eqvu7rrTu8g5gyuddq7KlYNBQws6Mb2
         fnbp/R1KutfkZXIE80k12jmE3KUrvJxhFXu33hIrDM9gJvLIwcHEpdtbMY4NQG2VxAbg
         71dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/W5yt/hqpa2H9l51KPyc7KtGFLwJRO5GtKdVuzCYcYE=;
        b=PfBd6NaJahW1/NFHZ+WAQrLt2IjRChh8I0qTOTZF7V5Wsaef5yyexrQfMw6RtIHLgx
         sBrrql48HPrhjICSzSzNuk4+OV4KcRRYz0bALnbG63ozRWN0nz703K/bI93ReC8KLRCO
         JyT3V/otilGVHYDWRWidXoCyLzFeaER+sohI1PyOAPdifdQTeNGqPJKCP6ytOxLPMd0W
         Yhq3lyY4vNNjbGWTSi5GB/cllbuXEdAq72sa2iZw5gM1mvFFl0LBFk6n/o2NqnIOQCn/
         IeNZsr1tCHzgN2zsQye+HhUvOuA/9lzBTOO/SGI3cUiu0oLDHrevYNrkpuj8JoD3MGCG
         mICQ==
X-Gm-Message-State: AJIora923MS11wIVKCf/IFFeQD3YdTTwmyM9Ixw3p5fXy8SrFERgGwqC
        64F0LCXnb24zBvEE/T1VZGyVa25rnqQI3/FwQRRM
X-Google-Smtp-Source: AGRyM1sHda4R7slO2THldYmCB6hufThJf2miVQonTYTic0+WRH9UBEOBbGg/X6g4BlFU1purnp8Q+Tj47z8FJeAvPUY=
X-Received: by 2002:adf:fb86:0:b0:21e:3cc8:a917 with SMTP id
 a6-20020adffb86000000b0021e3cc8a917mr9220347wrr.538.1658789617917; Mon, 25
 Jul 2022 15:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220721172808.585539-1-fred@cloudflare.com> <877d45kri4.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <877d45kri4.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Jul 2022 18:53:26 -0400
Message-ID: <CAHC9VhQXSXWv=+WYwU=Qq0w3rd+zOFPHL5yut1JdV2K=DDRmmg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introduce security_create_user_ns()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 1:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Frederick Lawler <fred@cloudflare.com> writes:
>
> > While creating a LSM BPF MAC policy to block user namespace creation, we
> > used the LSM cred_prepare hook because that is the closest hook to prevent
> > a call to create_user_ns().
>
> That description is wrong.  Your goal his is not to limit access to
> the user namespace.  Your goal is to reduce the attack surface of the
> kernel by not allowing some processes access to a user namespace.
>
> You have already said that you don't have concerns about the
> fundamentals of the user namespace, and what it enables only that
> it allows access to exploitable code.
>
> Achieving the protection you seek requires talking and thinking clearly
> about the goal.

Providing a single concrete goal for a LSM hook is always going to be
a challenge due to the nature of the LSM layer and the great unknown
of all the different LSMs that are implemented underneath the LSM
abstraction.  However, we can make some very general statements such
that up to this point the LSMs that have been merged into mainline
generally provide some level of access control, observability, or
both.  While that may change in the future (the LSM layer does not
attempt to restrict LSMs to just these two ideas), I think they are
"good enough" goals for this discussion.

In addition to thinking about these goals, I think it also important
to take a step back and think about the original motivation for the
LSM and why it, and Linux itself, has proven to be popular with
everything from the phone in your hand to the datacenter servers
powering ... pretty much everything :)  Arguably Linux has seen such
profound success because of its malleability; the open nature of the
kernel development process has allowed the Linux Kernel to adopt
capabilities well beyond what any one dev team could produce, and as
Linux continues to grow in adoption, its ability to flex into new use
cases only increases.  The kernel namespace concept is an excellent
example of this: virtualizing core kernel ideas, such as user
credentials, to provide better, safer solutions.  It is my belief that
the LSM layer is very much built around this same idea of abstracting
and extending core kernel concepts, in this case security controls, to
provide better solutions.  Integrating the LSM into the kernel's
namespaces is a natural fit, and one that is long overdue.

If we can't find a way to make everyone happy here, let's at least try
to find a way to make everyone "okay" with adding a LSM hook to the
user namespace.  If you want to NACK this approach Eric, that's okay,
but please provide some alternative paths forward that we can discuss.

-- 
paul-moore.com
