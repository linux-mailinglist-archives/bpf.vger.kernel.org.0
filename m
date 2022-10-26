Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C41860E641
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiJZRPA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 13:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiJZRO5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 13:14:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AAF1FF87;
        Wed, 26 Oct 2022 10:14:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q9so23352202ejd.0;
        Wed, 26 Oct 2022 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O7Uq/pQUrQ8lWGAvdsML2QRJXkhRAJ7jb1k78eXBkjc=;
        b=XmtB/I9B2JsjTl60PkZS9UQX3NscJXUohsT7wLW2hJT13cQJ8tKpC/rceopBnXyH5Q
         cPiKSv60DWT5gX7+Eci2ZUs72tYNMyROm09dU45xdP2wKq5srL98E2fCrDoe/ABRFRA+
         fdmd52uIj+cab9PLFq+sy1EMA96PvqdHWt8mFLNueVKzWo0meo6qkXYzlwEcJaUJzE8j
         l1kYAc5IEi2Zd1o9O1UCeiELMQvXIuM+G7Kg1YzKqSMePdf8YigsgAetsL16p+4y3xj9
         pzviHyN0QGoBTzevHkQQcdAXqAtohWJ1uAAXRaXB2SZ+YNKkAoi+Fhk4VAJGUBDPVBgR
         m+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7Uq/pQUrQ8lWGAvdsML2QRJXkhRAJ7jb1k78eXBkjc=;
        b=n++Ww7fRjVDHOx/we9Act3y6xg1HwRXhEY8bRFhmWMcWh/2wl9r8aGYeEy27H3Akmh
         3Qd3LmZ1MR5DDkdzG+yMZtrmdbRQ9WTuG471Jpt8vMbUUQwkoL2UL81lylDaOX5eG8BS
         Z+KHb7mfBr0Cxh5MXiBZMGiQAqQD2w3BEiwC+T2TQRw9MD9VgsaesMmSjVhP1ocMCNPn
         dr2xyZ1E/aeGQbBI9lQCfn4KBQmWlKg0dVjIkTLzROU43DOEOmRwz+YMBE2ZQGrDaMvX
         uaWixh/f/B0CD6166dbc4Hkwqc1mP9zjFTU0pRy05wXjV21KJLk1HE8MBFHJR9nQi+AM
         /zrQ==
X-Gm-Message-State: ACrzQf0dk6yeHGHEAmKrEmm9zuEa4hN0wQ3OFmbCm/M8ZxUcqPiJ1VJh
        fz0b8kLrCdfBynQR5ymrYrCJbO8vp+IQNWk4EQs=
X-Google-Smtp-Source: AMsMyM671db/GWfHZCF4vGkJJMD4q2kSbwii5WSEc54uNdOcI6hmZZ5pu70IMRLXjnYrdo2I3EEIHE3wwIHOMDroRlc=
X-Received: by 2002:a17:907:6e93:b0:78d:dff1:71e3 with SMTP id
 sh19-20020a1709076e9300b0078ddff171e3mr36873551ejc.94.1666804494588; Wed, 26
 Oct 2022 10:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
 <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
 <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
 <bb7a5986f3d25706269d0fec9906ea73c174b808.camel@huaweicloud.com>
 <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
 <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com>
 <ffbdcfbe-0c63-2ced-62e3-a7248b7a24f0@schaufler-ca.com> <CAADnVQLAXsZRNytPHG0KhYKar3K+=7bq2KPQG77VFOKbnTPHmg@mail.gmail.com>
 <34357c96-fe58-ffe5-e464-4bded8f119d5@huaweicloud.com>
In-Reply-To: <34357c96-fe58-ffe5-e464-4bded8f119d5@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Oct 2022 10:14:43 -0700
Message-ID: <CAADnVQKD5e9vKsSo1TPeBm5hr6j4GzQeHqRURoBJyB++VOwHCw@mail.gmail.com>
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from bpf_lsm_inode_init_security()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
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

On Wed, Oct 26, 2022 at 1:42 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On 10/26/2022 8:37 AM, Alexei Starovoitov wrote:
> > On Tue, Oct 25, 2022 at 7:58 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>
> >> On 10/25/2022 12:43 AM, Roberto Sassu wrote:
> >>> On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov wrote:
> >>>> I'm looking at security_inode_init_security() and it is indeed messy.
> >>>> Per file system initxattrs callback that processes kmalloc-ed
> >>>> strings.
> >>>> Yikes.
> >>>>
> >>>> In the short term we should denylist inode_init_security hook to
> >>>> disallow attaching bpf-lsm there. set/getxattr should be done
> >>>> through kfuncs instead of such kmalloc-a-string hack.
> >>> Inode_init_security is an example. It could be that the other hooks are
> >>> affected too. What happens if they get arbitrary positive values too?
> >>
> >> TL;DR - Things will go cattywampus.
> >>
> >> The LSM infrastructure is an interface that has "grown organically",
> >> and isn't necessarily consistent in what it requires of the security
> >> module implementations. There are cases where it assumes that the
> >> security module hooks are well behaved, as you've discovered. I have
> >> no small amount of fear that someone is going to provide an eBPF
> >> program for security_secid_to_secctx(). There has been an assumption,
> >> oft stated, that all security modules are going to be reviewed as
> >> part of the upstream process. The review process ought to catch hooks
> >> that return unacceptable values. Alas, we've lost that with BPF.
> >>
> >> It would take a(nother) major overhaul of the LSM infrastructure to
> >> make it safe against hooks that are not well behaved. From what I have
> >> seen so far it wouldn't be easy/convenient/performant to do it in the
> >> BPF security module either. I personally think that BPF needs to
> >> ensure that the eBPF implementations don't return inappropriate values,
> >> but I understand why that is problematic.
> >
> > That's an accurate statement. Thank you.
> >
> > Going back to the original question...
> > We fix bugs when we discover them.
> > Regardless of the subsystem they belong to.
> > No finger pointing.
>
> I'm concerned about the following situation:
>
> struct <something> *function()
> {
>
>         ret = security_*();
>         if (ret)
>                 return ERR_PTR(ret);
>
> }
>
> int caller()
> {
>         ptr = function()
>         if (IS_ERR(ptr)
>                 goto out;
>
>         <use of invalid pointer>
> }
>
> I quickly found an occurrence of this:
>
> static int lookup_one_common()
> {
>
> [...]
>
>         return inode_permission();
> }
>
> struct dentry *try_lookup_one_len()
> {
>
> [...]
>
>          err = lookup_one_common(&init_user_ns, name, base, len, &this);
>          if (err)
>                  return ERR_PTR(err);
>
>
> Unfortunately, attaching to inode_permission causes the kernel
> to crash immediately (it does not happen with negative return
> values).
>
> So, I think the fix should be broader, and not limited to the
> inode_init_security hook. Will try to see how it can be fixed.

I see. Let's restrict bpf-lsm return values to IS_ERR_VALUE.
Trivial verifier change.
