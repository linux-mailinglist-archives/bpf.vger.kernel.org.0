Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6551913A9
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgCXOwA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 10:52:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35435 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgCXOwA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 10:52:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so3812195wmi.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7e4KDLTmWgu/QQJEIVFCVN/w7UIWM4C7k1L+cgO3etw=;
        b=ACG7Xe7QJOeqLq9nxQgo/2Hmd7TANG6OyUfm9KlhXXEDFRJCJA5UGjhkxMgV5E3HlJ
         lcKpAHAeeWRt9+4yASeJo8ob176WIaXSIzV0Hv0Ni0SNxelTVnxKe57ObyCHBbqq5Pmr
         Kofe0bXI1xmqL8NJfeXLDIyJrJ40lD8Aicbd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7e4KDLTmWgu/QQJEIVFCVN/w7UIWM4C7k1L+cgO3etw=;
        b=JzeaHgRKwjm6jXN/oVwjRAJGoyipgYfUUgkwlztJkQ9IzqoDTfIE/76MqMhenItcF+
         mcPBpNZF/gi6C3fDmzJaaPERMGEreOxVJRlnby4SIBa+3GFDCb8bgos3oe4mdogC3IDa
         Zv1YiyPJxQb+GBH9Yxw9JMYY7Qhlo6C85U0hfNXeSycEiG7jVL4vUMY4gd1QqihOICU6
         Up8HHq3qM84YJ/sov+J4kOWrXG3ZO4Ueu07HZKmLy6flGjx3SaAW7XmFELEGY0m5a2P6
         ZsC2edriumv2GyVBsrf1raArEVmWV3NdbsvphFSUvzSlx9C9QHQ027EHMTIsqpZ80046
         V96g==
X-Gm-Message-State: ANhLgQ3TpiQZY5GFIk1I1yJrWeXoZphcGzPOZuFuk3VvoggzJvjraQVb
        Zn5Tpet57iow3V3UN1O8cs8Lpg==
X-Google-Smtp-Source: ADFU+vum9D07o2DYTLiqEmlmU481OTm0K/ZD8B4oN/2zUqHNg6zKveeWlRzSLOOalwgn2Y/BsRssRA==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr5927248wmm.43.1585061518182;
        Tue, 24 Mar 2020 07:51:58 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id t5sm22977367wrr.93.2020.03.24.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:51:57 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 15:51:55 +0100
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <20200324145155.GB2685@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com>
 <20200324015217.GA28487@chromium.org>
 <CAEjxPJ7LCZYDXN1rYMBA2rko0zbTp0UU0THx0bhsAnv0Eg4Ptg@mail.gmail.com>
 <20200324144214.GA1040@chromium.org>
 <CAEjxPJ7GDA2PvYkoFhnE7gjr_n=ADCjy3XOwacfELY7evVJtJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7GDA2PvYkoFhnE7gjr_n=ADCjy3XOwacfELY7evVJtJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24-Mär 10:51, Stephen Smalley wrote:
> On Tue, Mar 24, 2020 at 10:42 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 24-Mär 10:37, Stephen Smalley wrote:
> > > On Mon, Mar 23, 2020 at 9:52 PM KP Singh <kpsingh@chromium.org> wrote:
> > > >
> > > > On 23-Mär 18:13, Casey Schaufler wrote:
> > > > > Have you given up on the "BPF must be last" requirement?
> > > >
> > > > Yes, we dropped it for as the BPF programs require CAP_SYS_ADMIN
> > > > anwyays so the position ~shouldn't~ matter. (based on some of the
> > > > discussions we had on the BPF_MODIFY_RETURN patches).
> > > >
> > > > However, This can be added later (in a separate patch) if really
> > > > deemed necessary.
> > >
> > > It matters for SELinux, as I previously explained.  A process that has
> > > CAP_SYS_ADMIN is not assumed to be able to circumvent MAC policy.
> > > And executing prior to SELinux allows the bpf program to access and
> > > potentially leak to userspace information that wouldn't be visible to
> > > the
> > > process itself. However, I thought you were handling the order issue
> > > by putting it last in the list of lsms?
> >
> > We can still do that if it does not work for SELinux.
> >
> > Would it be okay to add bpf as LSM_ORDER_LAST?
> >
> > LSMs like Landlock can then add LSM_ORDER_UNPRIVILEGED to even end up
> > after bpf?
> 
> I guess the question is whether we need an explicit LSM_ORDER_LAST or
> can just handle it via the default
> values for the lsm= parameter, where you are already placing bpf last
> IIUC?  If someone can mess with the kernel boot
> parameters, they already have options to mess with SELinux, so it is no worse...

Yeah, we do add BPF as the last LSM in the default list. So, I will
avoid adding LSM_ORDER_LAST for now.

- KP
