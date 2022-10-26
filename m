Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CAF60DB6C
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 08:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiJZGiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 02:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZGiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 02:38:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9778BE1;
        Tue, 25 Oct 2022 23:38:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t25so13164108ejb.8;
        Tue, 25 Oct 2022 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx8fYuOqE4Fz7MoTG2qyzZeL72DVY10BTmV8q9Mc57w=;
        b=qHrL7FKIzMARVP4gCZGtCYP08mU2Xgs4Znav05N95RRQvkbRXbQF61MJZY96Q7WP/F
         PWoN3+fpTvoAPWT65Uyqim26UaP8B6LfsZtTfWdCU7iLytxgLzcnb4igksIT7QZ63oZJ
         Vlrlyxo1RC4LpvygdZyzmKnEkymjdjkwbcBMqF7MX8OOLslunSPukQWeBsGRHL+6QRaP
         Gl9hoVbkGXIolT8N8QoHjwTe7TKPha9HyqpFdaIaHQ9pqMxaoSxBf3OZxHGXjYO+QKBk
         8QCxxjRWCmzjerQAe0aH8NBo19nPtyIFLm8/1uhQpLw2ng6P8F0nRHz8I2flGllpOQYf
         BcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx8fYuOqE4Fz7MoTG2qyzZeL72DVY10BTmV8q9Mc57w=;
        b=hXlJ7XzjruRa94wvdR8J9cBkfmRbAKKs+jGTEqpAHPAYFlKKGKWoYjCb2stoUdf8I6
         t0dRF80n9NVi6pnrXGWiJZgpgjWiFwoJh7eeRX9k24L24istYrmmgkiSsGbDlfSDDL8V
         6fKDr5MSUtUhjVEeVuNo9XBVHh+YBImVoKK1Ntek+zvXQ8cUwmLvut+IuL0wvs4AH0GC
         get9FtZQEio2y5NUTWkgiFT5EphSAPARwHn/INTi93lJ5Ls5ElUepael6XDz6Pmbfz/F
         FhlIl78cvq6JcDVPQTJYVj8VuXSm2akvh3komNtK/Ob9EfZx2HuKcGUSfKSUq+rzT4bP
         sG1g==
X-Gm-Message-State: ACrzQf2C3apmnbEgnKOLsRE3m5xLJ8A2BV9vSWvNUUK5/qs2e4XMkXRL
        8W61TKzexHw+ftPhJt1MtR3F/RM5PiWrpJXbE9Q=
X-Google-Smtp-Source: AMsMyM4Wnn4932Ytv91Nrg1zHGI8MgLVZC+Ngl65IwrEw5f7VTg8YZr0RLz02wh9lfIB4mbydGN7lFZ10h6BzWe7zMM=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr36566308ejb.633.1666766233858; Tue, 25
 Oct 2022 23:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
 <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
 <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
 <bb7a5986f3d25706269d0fec9906ea73c174b808.camel@huaweicloud.com>
 <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
 <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com> <ffbdcfbe-0c63-2ced-62e3-a7248b7a24f0@schaufler-ca.com>
In-Reply-To: <ffbdcfbe-0c63-2ced-62e3-a7248b7a24f0@schaufler-ca.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Oct 2022 23:37:02 -0700
Message-ID: <CAADnVQLAXsZRNytPHG0KhYKar3K+=7bq2KPQG77VFOKbnTPHmg@mail.gmail.com>
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from bpf_lsm_inode_init_security()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 25, 2022 at 7:58 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 10/25/2022 12:43 AM, Roberto Sassu wrote:
> > On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov wrote:
> >> I'm looking at security_inode_init_security() and it is indeed messy.
> >> Per file system initxattrs callback that processes kmalloc-ed
> >> strings.
> >> Yikes.
> >>
> >> In the short term we should denylist inode_init_security hook to
> >> disallow attaching bpf-lsm there. set/getxattr should be done
> >> through kfuncs instead of such kmalloc-a-string hack.
> > Inode_init_security is an example. It could be that the other hooks are
> > affected too. What happens if they get arbitrary positive values too?
>
> TL;DR - Things will go cattywampus.
>
> The LSM infrastructure is an interface that has "grown organically",
> and isn't necessarily consistent in what it requires of the security
> module implementations. There are cases where it assumes that the
> security module hooks are well behaved, as you've discovered. I have
> no small amount of fear that someone is going to provide an eBPF
> program for security_secid_to_secctx(). There has been an assumption,
> oft stated, that all security modules are going to be reviewed as
> part of the upstream process. The review process ought to catch hooks
> that return unacceptable values. Alas, we've lost that with BPF.
>
> It would take a(nother) major overhaul of the LSM infrastructure to
> make it safe against hooks that are not well behaved. From what I have
> seen so far it wouldn't be easy/convenient/performant to do it in the
> BPF security module either. I personally think that BPF needs to
> ensure that the eBPF implementations don't return inappropriate values,
> but I understand why that is problematic.

That's an accurate statement. Thank you.

Going back to the original question...
We fix bugs when we discover them.
Regardless of the subsystem they belong to.
No finger pointing.
