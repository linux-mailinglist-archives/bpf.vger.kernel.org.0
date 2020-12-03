Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D52CDC83
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 18:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgLCRgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 12:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgLCRgZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 12:36:25 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F83C061A4E
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 09:35:44 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id q8so3411560ljc.12
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0x1EjDar6dSL0l5YSOF6C8JvVk7KFexwtRk1hnbmU/g=;
        b=BQPwGGyK85bogPGjNSjetqmsbynwiW0zvVrpzQ9DJtfi4QhYoWYDEN8Es+I/Be8e2X
         hExOh9YgWtA2Dpi+ylTXdeHLMrR9QR/Ks6MsXhdIni4HGNNKtpV8UedPKf2cccsizO5A
         No61CMxgX4qi+HRepxFI/3qKrmqXit7Ah/XM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0x1EjDar6dSL0l5YSOF6C8JvVk7KFexwtRk1hnbmU/g=;
        b=Uv+1v2PvoM922YPRLIwGpjzgkdgYs3+Orr2gaToCWBhkoE+BApqcTmHOfazgeAlaIb
         WkxdmB+lx+ey8dMeu8+Qmf3Zil4qItQbYRi4iUOU2W+Neqez7ZZVgNMAwCumTt6E89hR
         pEha+Gw5+2rXTYAjscBHIg5DBNCnek/c4YXCJrJbDQ9WT0SWNFGoB1i91Kvom/x/pdcn
         j5c/w61ivXpnvHgaOJPZBYhsSMtkNeHAzlvvlCBPG/Pj/mWylmew2MHP9zj+9YwaSc7N
         Q013wUUnS0xP+jJfojucOCFwJwujpDvJTXPacSms0+50YLJgqc+UBHxQvEnFgNZvz+qw
         ZVEg==
X-Gm-Message-State: AOAM532AERxB1Wnt7dGGQX4xOLdU8cHp3sD8ZsNbNYgt14Z494NCAlfB
        Z37VvWSB8Q0VhjhLTXxmh1xWyhQZt0FUTwgrWDddftZhW9HS3A==
X-Google-Smtp-Source: ABdhPJz5jx8YI7AjB/rTs9GyejjZ0NoUR3Wa2/qxgjZz1981HVQ2bWuWwfhXAmxhCjUSBVYhthgEhARfA33eh/iHT70=
X-Received: by 2002:a2e:80c6:: with SMTP id r6mr1664186ljg.83.1607016943190;
 Thu, 03 Dec 2020 09:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-4-kpsingh@chromium.org>
 <CAEf4BzbXA-az9cAKwy=bpqFOkX+6mtirm0TRxkyTmZdm+bXxoQ@mail.gmail.com> <CACYkzJ6PYgmkZg_=q3Yi300esXmjB_gnX4urmcLxSQFxf+QyuQ@mail.gmail.com>
In-Reply-To: <CACYkzJ6PYgmkZg_=q3Yi300esXmjB_gnX4urmcLxSQFxf+QyuQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Dec 2020 18:35:32 +0100
Message-ID: <CACYkzJ6rtH7mJ1mr3VsyvDjkM1tkpvd0XxvHPCuQAbyKBfNx-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Add config dependency on BLK_DEV_LOOP
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 11:56 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On Thu, Dec 3, 2020 at 6:56 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > The ima selftest restricts its scope to a test filesystem image
> > > mounted on a loop device and prevents permanent ima policy changes for
> > > the whole system.
> > >
> > > Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  tools/testing/selftests/bpf/config | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> > > index 365bf9771b07..37e1f303fc11 100644
> > > --- a/tools/testing/selftests/bpf/config
> > > +++ b/tools/testing/selftests/bpf/config
> > > @@ -43,3 +43,4 @@ CONFIG_IMA=y
> > >  CONFIG_SECURITYFS=y
> > >  CONFIG_IMA_WRITE_POLICY=y
> > >  CONFIG_IMA_READ_POLICY=y
> > > +CONFIG_BLK_DEV_LOOP=y
> > > --
> >
> >
> > You mentioned also that CONFIG_LSM="selinux,bpf,integrity" is needed,
> > no? Let's add that as well?
>
> I did not add it because we did not do it when we added "bpf" to the list and
>
> I also don't think selinux is really required here which might be worse in
> some cases (e.g. when the required config options for
> SELinux are not selected).
>
> Also, when one selects CONFIG_BPF_LSM or CONFIG_IMA from make
> menuconfig / nconfig, we get "bpf" and "integrity" appended by default:
>
> We can add a comment that says that says:
>
>   "Please ensure "bpf" and "integrity" are present in CONFIG_LSM"
>
> Now, I was not sure if adding a comment would break any scripts that people
> have that parse this file, so I avoided it. But overriding the string
> completely
> might not be a good idea.

If it's okay, I can send the v4 out now and we can add the comment or CONFIG_LSM
in a separate patch?
