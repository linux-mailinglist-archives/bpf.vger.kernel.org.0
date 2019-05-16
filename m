Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9020B83
	for <lists+bpf@lfdr.de>; Thu, 16 May 2019 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfEPPvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 May 2019 11:51:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37003 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPPvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 May 2019 11:51:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so4483161qtp.4
        for <bpf@vger.kernel.org>; Thu, 16 May 2019 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dkiLoToXYjdDDxJCV8XdKehPpgz9CEPsRl1SOjbojJI=;
        b=nNcR6+33KiG2CSz53UUFPwzydzMq9lFMi3DQvh1Ah78K1UsCv/U0j2IFFm9tuAnHNM
         wdO/aWjCozSj52RWpuiB2A6dg+mSJP3GRbQV/dNdjLyC/D3Dh6ehmzjG9kMnLmNkHIBr
         5d9TskqxtGKnPX+0PVHM9fxL8EgMslP1wgLll99xquj1O7zLl761ecvwZG0Nfzv0OAOi
         NgM4HGip71XhZ4P4YZyAMgOW2O8z4XI79J3S4cMxgskpOloLek8JzKYWjL6Ta7pyjw7W
         872KdZbODHIhrBnCd/TxzQ9q8Uvz56jaJqqjEUfN9y1Pbncqg5FPfAxuxRt6LR0HUihd
         7vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dkiLoToXYjdDDxJCV8XdKehPpgz9CEPsRl1SOjbojJI=;
        b=nUl0KSjZSBsXEd+oOhZxUqW45oxzNYfX7Q2AD4nwhBM7VMXAO01bEPvjzDlTuNTMuR
         tKPZhawNS+2LUdF0/q1RVI3ZI0uLXpA2dMvH2vrMjd+rZwcxizvwjJf+3vCR96xrD82b
         KvgqO41Zv86WT3BBGCjtP5WAdUxBm0RJDr55nTIDoBGDTlFjMEoER/Z2aXjECQ433IoN
         eCitpTaW6kkbxid9XZ+4iGoTbNY+MMpOWnQZb5wyi2m1g/0vc3Zogjlnk+h9tgvhq6rL
         3WX9sF1yxMcHJPykm0u1c6AzDLbDaUXPNoksdywnJNd0U2btBp6m1B0zn6mZBGStr0Mb
         3HRQ==
X-Gm-Message-State: APjAAAUR2TlJXUk4N+rvK3qxTgITPVvpSqnBgXEGIsWvRpicpBC7LfDP
        57Egw9C8tXvLR3pD0cbrAKlC0Q==
X-Google-Smtp-Source: APXvYqwERoEB65jkHiiLTn548l3as8wXrL1hm/DBTJe+h941PBFzegsCrPT0Qs2/9mFSUXPurVzU0Q==
X-Received: by 2002:aed:3787:: with SMTP id j7mr43302641qtb.6.1558021861883;
        Thu, 16 May 2019 08:51:01 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h17sm2751528qkk.13.2019.05.16.08.51.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 08:51:01 -0700 (PDT)
Date:   Thu, 16 May 2019 08:50:35 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Krzesimir Nowak <krzesimir@kinvolk.io>
Cc:     bpf@vger.kernel.org,
        Iago =?UTF-8?B?TMOzcGV6?= Galeiras <iago@kinvolk.io>,
        "Alban Crequy (Kinvolk)" <alban@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v1 2/3] selftests/bpf: Print a message when tester
 could not run a program
Message-ID: <20190516085035.3cdb0ae6@cakuba.netronome.com>
In-Reply-To: <CAGGp+cGN+YYVjJee5ba84HstSrHGurBvwmKmzNsFRvb344Df3A@mail.gmail.com>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
        <20190515134731.12611-3-krzesimir@kinvolk.io>
        <20190515144537.57f559e7@cakuba.netronome.com>
        <CAGGp+cGN+YYVjJee5ba84HstSrHGurBvwmKmzNsFRvb344Df3A@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 16 May 2019 11:29:39 +0200, Krzesimir Nowak wrote:
> > > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> > > index ccd896b98cac..bf0da03f593b 100644
> > > --- a/tools/testing/selftests/bpf/test_verifier.c
> > > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > > @@ -825,11 +825,20 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
> > >                               tmp, &size_tmp, &retval, NULL);
> > >       if (unpriv)
> > >               set_admin(false);
> > > -     if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
> > > -             printf("Unexpected bpf_prog_test_run error ");
> > > -             return err;
> > > +     if (err) {
> > > +             switch (errno) {
> > > +             case 524/*ENOTSUPP*/:
> > > +                     printf("Did not run the program (not supported) ");
> > > +                     return 0;
> > > +             case EPERM:
> > > +                     printf("Did not run the program (no permission) ");
> > > +                     return 0;  
> >
> > Perhaps use strerror(errno)?  
> 
> As I said in the commit message, I open-coded those messages because
> strerror for ENOTSUPP returns "Unknown error 524".

Ah, sorry, missed that.  I wonder if that's something worth addressing
in libc, since the BPF subsystem uses ENOTSUPP a lot.
