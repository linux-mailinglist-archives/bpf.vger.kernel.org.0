Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25BB597409
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbiHQQT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 12:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiHQQT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 12:19:28 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F295844F0;
        Wed, 17 Aug 2022 09:19:26 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 55B7916F3; Wed, 17 Aug 2022 11:19:24 -0500 (CDT)
Date:   Wed, 17 Aug 2022 11:19:24 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/2] Add capabilities file to securityfs
Message-ID: <20220817161924.GA20337@mail.hallyn.com>
References: <20220725124123.12975-1-flaniel@linux.microsoft.com>
 <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com>
 <4420381.LvFx2qVVIh@pwmachine>
 <CAHC9VhSMeefG5W_uuTNQYmUUZ1xcuqArxYs5sL9KOzUO_skCZw@mail.gmail.com>
 <ab1bbd48-c48d-5f5a-f090-428ffd54c07e@schaufler-ca.com>
 <CAHC9VhTxYaLXFbS6JnpskOkADNbL8BA5614VuK3sDTHW6DE3uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTxYaLXFbS6JnpskOkADNbL8BA5614VuK3sDTHW6DE3uQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 12:10:25PM -0400, Paul Moore wrote:
> On Wed, Aug 17, 2022 at 11:50 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 8/17/2022 7:52 AM, Paul Moore wrote:
> > > On Wed, Aug 17, 2022 at 7:53 AM Francis Laniel
> > > <flaniel@linux.microsoft.com> wrote:
> > >> Le mardi 16 août 2022, 23:59:41 CEST Paul Moore a écrit :
> > >>> On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
> > >>>
> > >>> <flaniel@linux.microsoft.com> wrote:
> > >>>> Hi.
> > >>>>
> > >>>> First, I hope you are fine and the same for your relatives.
> > >>> Hi Francis :)
> > >>>
> > >>>> A solution to this problem could be to add a way for the userspace to ask
> > >>>> the kernel about the capabilities it offers.
> > >>>> So, in this series, I added a new file to securityfs:
> > >>>> /sys/kernel/security/capabilities.
> > >>>> The goal of this file is to be used by "container world" software to know
> > >>>> kernel capabilities at run time instead of compile time.
> > >>> ...
> > >>>
> > >>>> The kernel already exposes the last capability number under:
> > >>>> /proc/sys/kernel/cap_last_cap
> > >>> I'm not clear on why this patchset is needed, why can't the
> > >>> application simply read from "cap_last_cap" to determine what
> > >>> capabilities the kernel supports?
> > >> When you capabilities with, for example, docker, you will fill capabilities
> > >> like this:
> > >> docker run --rm --cap-add SYS_ADMIN debian:latest echo foo
> > >> As a consequence, the "echo foo" will be run with CAP_SYS_ADMIN set.
> > >>
> > >> Sadly, each time a new capability is added to the kernel, it means "container
> > >> stack" software should add a new string corresponding to the number of the
> > >> capabilities [1].
> > > Thanks for clarifying things, I thought you were more concerned about
> > > detecting what capabilities the running kernel supported, I didn't
> > > realize it was getting a string literal for each supported capability.
> > > Unless there is a significant show of support for this
> >
> > I believe this could be a significant help in encouraging the use of
> > capabilities. An application that has to know the list of capabilities
> > at compile time but is expected to run unmodified for decades isn't
> > going to be satisfied with cap_last_cap. The best it can do with that
> > is abort, not being able to ask an admin what to do in the presence of
> > a capability that wasn't around before because the name isn't known.
> 
> An application isn't going to be able to deduce the semantic value of
> a capability based solely on a string value, an integer is just as
> meaningful in that regard.  What might be useful is if the application

Maybe it's important to point out that an integer value capability in
kernel will NEVER change its string value (or semantic meaning).

The libcap tools like capsh accept integer capabilities, other tools
probably should as well.  (see man 3 cap_from_text)

> simply accepts a set of capabilities from the user and then checks
> those against the maximum supported by the kernel, but once again that
> doesn't require a string value, it just requires the application
> taking a set of integers and passing those into the kernel when a
> capability set is required.  I still don't see how adding the
> capability string names to the kernel is useful here.
> 
> -- 
> paul-moore.com
