Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC1D5974F9
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiHQRUC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 13:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbiHQRUB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 13:20:01 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0839D64E
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 10:20:00 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2a4c51c45so15876872fac.9
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=J3VPAc5hc1beoFQlEY8UmpcylWVa8Cg5xRcsnWIJYsU=;
        b=SCfTwXbWYFitH2mVeMfBTd8oUH/KXZXgT8BIHGPDHUz6Dh2NBNFER7vPRljNHOMTFo
         KXtqFlvPL4lL17cgNJvrWIL+oBZBL3hfA/4TF/6agOW/b0NEbp1HDA65CyIc4aI0Hg4O
         9QrN64jfHSs2gwNJ6GG6Moo1MesbpkxU5f5zMP9wBarJTL4boyoERBQqemFIZS8kZ7sq
         fYCsSrGuWP1ZKJPDDW1ZXKSMmIYtQKUqVlrehGPAX1JkUdATUfmohOtCPObMo0gcVykX
         EIK5RsltW8fLfHbazgsMlFWQRFdlFS9An0Zq+IChTVai5fJHiFS7XsnFqGx3Ls8l9FJ0
         go0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=J3VPAc5hc1beoFQlEY8UmpcylWVa8Cg5xRcsnWIJYsU=;
        b=8IF1CDRVCQOCxNxxhIkxU5lzu5MGFIVLtnM3FuKglVQM3JjWgHwKrr0Pvt8e79LnwG
         gca28yxQKEpV4ZNrwFVA2LGk8+OlomCd8roZSfqrpWu9sf7DmE8frClH+pTSj7ZpRdgc
         IuUTMJiC1yq6K6gsUppD2pBagv3Piu/6hoeKfc1zT7WCLwpSYoKufqk19h+KTa0lcUk9
         /yu6zsyfgqij1NHQbF5laXIGN2Vw2whLNEmlIC/vsmXq/WT6Uirk8WykPZpAQUsqcPVl
         BohQot0gv0hMYssEItFvhYH6B9Vcyuawy5VxSEBjAPBhR+LZ/h5HAkrryx2oQ4WBGbeW
         LACw==
X-Gm-Message-State: ACgBeo0cLSGcNoXPqoQXR3Q2eqmKO+fH8E0n4MuAtZupvPvi8JffJmhm
        h+L8KMRr7WUC+k6OFCjHWxkCioCuFJbwq0jOKAy4
X-Google-Smtp-Source: AA6agR4mv9lGti64tQ+RWhXl/XpvBG3lv2fsN8uSnflhqV/wjKZTydMt1AJ/vsLoMQnvVJvZroCrD9DZ9AMStnXqZ4c=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr2325509oao.136.1660756799347; Wed, 17
 Aug 2022 10:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220725124123.12975-1-flaniel@linux.microsoft.com>
 <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com>
 <4420381.LvFx2qVVIh@pwmachine> <CAHC9VhSMeefG5W_uuTNQYmUUZ1xcuqArxYs5sL9KOzUO_skCZw@mail.gmail.com>
 <ab1bbd48-c48d-5f5a-f090-428ffd54c07e@schaufler-ca.com> <CAHC9VhTxYaLXFbS6JnpskOkADNbL8BA5614VuK3sDTHW6DE3uQ@mail.gmail.com>
 <664f29c3-77a6-2ed9-5c55-f181397b09a2@schaufler-ca.com>
In-Reply-To: <664f29c3-77a6-2ed9-5c55-f181397b09a2@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Aug 2022 13:19:48 -0400
Message-ID: <CAHC9VhTkkhgmj8R6fmuoffLUU+UnYqxOi-kDWmJQ9F9jtwuLxg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] Add capabilities file to securityfs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 12:49 PM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
> On 8/17/2022 9:10 AM, Paul Moore wrote:
> > On Wed, Aug 17, 2022 at 11:50 AM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
> >> On 8/17/2022 7:52 AM, Paul Moore wrote:
> >>> On Wed, Aug 17, 2022 at 7:53 AM Francis Laniel
> >>> <flaniel@linux.microsoft.com> wrote:
> >>>> Le mardi 16 ao=C3=BBt 2022, 23:59:41 CEST Paul Moore a =C3=A9crit :
> >>>>> On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
> >>>>>
> >>>>> <flaniel@linux.microsoft.com> wrote:
> >>>>>> Hi.
> >>>>>>
> >>>>>> First, I hope you are fine and the same for your relatives.
> >>>>> Hi Francis :)
> >>>>>
> >>>>>> A solution to this problem could be to add a way for the userspace=
 to ask
> >>>>>> the kernel about the capabilities it offers.
> >>>>>> So, in this series, I added a new file to securityfs:
> >>>>>> /sys/kernel/security/capabilities.
> >>>>>> The goal of this file is to be used by "container world" software =
to know
> >>>>>> kernel capabilities at run time instead of compile time.
> >>>>> ...
> >>>>>
> >>>>>> The kernel already exposes the last capability number under:
> >>>>>> /proc/sys/kernel/cap_last_cap
> >>>>> I'm not clear on why this patchset is needed, why can't the
> >>>>> application simply read from "cap_last_cap" to determine what
> >>>>> capabilities the kernel supports?
> >>>> When you capabilities with, for example, docker, you will fill capab=
ilities
> >>>> like this:
> >>>> docker run --rm --cap-add SYS_ADMIN debian:latest echo foo
> >>>> As a consequence, the "echo foo" will be run with CAP_SYS_ADMIN set.
> >>>>
> >>>> Sadly, each time a new capability is added to the kernel, it means "=
container
> >>>> stack" software should add a new string corresponding to the number =
of the
> >>>> capabilities [1].
> >>> Thanks for clarifying things, I thought you were more concerned about
> >>> detecting what capabilities the running kernel supported, I didn't
> >>> realize it was getting a string literal for each supported capability=
.
> >>> Unless there is a significant show of support for this
> >> I believe this could be a significant help in encouraging the use of
> >> capabilities. An application that has to know the list of capabilities
> >> at compile time but is expected to run unmodified for decades isn't
> >> going to be satisfied with cap_last_cap. The best it can do with that
> >> is abort, not being able to ask an admin what to do in the presence of
> >> a capability that wasn't around before because the name isn't known.
> > An application isn't going to be able to deduce the semantic value of
> > a capability based solely on a string value,
>
> True, but it can ask someone what to do, and in that case a string is
> much better than a number ...

If you are asking a user what to do, that user can just as easily look
up the capability list to translate numbers to intent.  If your
security approach requires a user knowing all of the subtle details
around a capability based on 10~15 character string, I wish you the
best of luck :)

--=20
paul-moore.com
