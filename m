Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4D5973B7
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiHQQK4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiHQQKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 12:10:38 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBFE98CB5
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 09:10:37 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso8777025otv.1
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=BaWHsWTr1OobN9zZcMtlpkKkIKQywBqe+CFVwSFeHqY=;
        b=eRiLLz7igQjPx0JfYU8PprZO3DUuncdUb7Tmo9iIYCYI+dN3Mb88vbr7mMmOqEoI9q
         V2xWtfyfn4pLjjCSnsdRdW0UgmXWRJjLodEmXleglMWoLXvrMcgu7nf1/qbfr92RQjau
         ozNy8u7Jf3k2Xo3rUlZEDr/LYZC5sPGnLXykRG5ptTl0KmS4eJnGbHduTKQfDhC32+TK
         4yShcnI/yVwlATurSSk/wAYIJt6Vlg3cHeoUqPO4xbn1CzYdtYEaXnbaIvZ2/AVnpmZD
         +vuNmhpsMagPEXW16q6VZZHO7gnyu6hbN/eCO0l94Z1+JaCbeoRbF4dpjn59CfcFBybA
         xqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=BaWHsWTr1OobN9zZcMtlpkKkIKQywBqe+CFVwSFeHqY=;
        b=JMclytT2QEVJDTNxr7mufvIqymTrPppMDf3xpyUOEzZo9DdllDcqycZOfO9XYyhoMq
         8o92iCbk6SlBTXcyhC1j7vn0BHB8FH0BuasszJ/ZfCkFn9XebVyoecFrwvQloi7hjzM9
         dBlyBAPFwFR8RFf4iIAcvaj+6x6xnMNTRbSBsW6b+pxd6uWb809TcanUNeSLBB3xORui
         O5u3urhJwU5XgHevkhGttYEhjFb61C96AB2ioeTaW3ylQbVdQOwaRhayhFEvfLQd2pFV
         RN4MyjGFs9rOj1otiLHGfVxavRiVJ6y4mjV3qXZnYNScFNYqPHui+SVcswoNXHHy5f/T
         tXCQ==
X-Gm-Message-State: ACgBeo1UI42NWHl+o2reVTIrBtO9SShelKNPclijsotI82r7bGmO1dP3
        Rb78wQgeJVZsibzAFJxZPGO+8dobeO4CZ6mvCUFJ
X-Google-Smtp-Source: AA6agR4guGUn+QZf7mZb1RCMpp4j6JVXXiQZ0eZ2IgE1A3BOC2yeXgx7CL2eOB5cx4+WzLPUD0gqxUDN0g6skinQzwk=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr3556247otv.26.1660752636346; Wed, 17
 Aug 2022 09:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220725124123.12975-1-flaniel@linux.microsoft.com>
 <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com>
 <4420381.LvFx2qVVIh@pwmachine> <CAHC9VhSMeefG5W_uuTNQYmUUZ1xcuqArxYs5sL9KOzUO_skCZw@mail.gmail.com>
 <ab1bbd48-c48d-5f5a-f090-428ffd54c07e@schaufler-ca.com>
In-Reply-To: <ab1bbd48-c48d-5f5a-f090-428ffd54c07e@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Aug 2022 12:10:25 -0400
Message-ID: <CAHC9VhTxYaLXFbS6JnpskOkADNbL8BA5614VuK3sDTHW6DE3uQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 11:50 AM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
> On 8/17/2022 7:52 AM, Paul Moore wrote:
> > On Wed, Aug 17, 2022 at 7:53 AM Francis Laniel
> > <flaniel@linux.microsoft.com> wrote:
> >> Le mardi 16 ao=C3=BBt 2022, 23:59:41 CEST Paul Moore a =C3=A9crit :
> >>> On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
> >>>
> >>> <flaniel@linux.microsoft.com> wrote:
> >>>> Hi.
> >>>>
> >>>> First, I hope you are fine and the same for your relatives.
> >>> Hi Francis :)
> >>>
> >>>> A solution to this problem could be to add a way for the userspace t=
o ask
> >>>> the kernel about the capabilities it offers.
> >>>> So, in this series, I added a new file to securityfs:
> >>>> /sys/kernel/security/capabilities.
> >>>> The goal of this file is to be used by "container world" software to=
 know
> >>>> kernel capabilities at run time instead of compile time.
> >>> ...
> >>>
> >>>> The kernel already exposes the last capability number under:
> >>>> /proc/sys/kernel/cap_last_cap
> >>> I'm not clear on why this patchset is needed, why can't the
> >>> application simply read from "cap_last_cap" to determine what
> >>> capabilities the kernel supports?
> >> When you capabilities with, for example, docker, you will fill capabil=
ities
> >> like this:
> >> docker run --rm --cap-add SYS_ADMIN debian:latest echo foo
> >> As a consequence, the "echo foo" will be run with CAP_SYS_ADMIN set.
> >>
> >> Sadly, each time a new capability is added to the kernel, it means "co=
ntainer
> >> stack" software should add a new string corresponding to the number of=
 the
> >> capabilities [1].
> > Thanks for clarifying things, I thought you were more concerned about
> > detecting what capabilities the running kernel supported, I didn't
> > realize it was getting a string literal for each supported capability.
> > Unless there is a significant show of support for this
>
> I believe this could be a significant help in encouraging the use of
> capabilities. An application that has to know the list of capabilities
> at compile time but is expected to run unmodified for decades isn't
> going to be satisfied with cap_last_cap. The best it can do with that
> is abort, not being able to ask an admin what to do in the presence of
> a capability that wasn't around before because the name isn't known.

An application isn't going to be able to deduce the semantic value of
a capability based solely on a string value, an integer is just as
meaningful in that regard.  What might be useful is if the application
simply accepts a set of capabilities from the user and then checks
those against the maximum supported by the kernel, but once again that
doesn't require a string value, it just requires the application
taking a set of integers and passing those into the kernel when a
capability set is required.  I still don't see how adding the
capability string names to the kernel is useful here.

--=20
paul-moore.com
