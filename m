Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA42580033
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiGYNwd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Jul 2022 09:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGYNwc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 09:52:32 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932F15736;
        Mon, 25 Jul 2022 06:52:28 -0700 (PDT)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 9BD664105A;
        Mon, 25 Jul 2022 13:52:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 2CBFA2000E;
        Mon, 25 Jul 2022 13:52:16 +0000 (UTC)
Message-ID: <5bd85a7241e6ccac7fe5647cb9cf7ef22b228943.camel@perches.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
From:   Joe Perches <joe@perches.com>
To:     Baoquan He <bhe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Slark Xiao <slark_xiao@163.com>
Cc:     kafai <kafai@fb.com>, vgoyal <vgoyal@redhat.com>,
        dyoung <dyoung@redhat.com>, ast <ast@kernel.org>,
        daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>,
        "martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>,
        yhs <yhs@fb.com>, "john.fastabend" <john.fastabend@gmail.com>,
        kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
        haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
        "william.gray" <william.gray@linaro.org>,
        dhowells <dhowells@redhat.com>, peterz <peterz@infradead.org>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        longman <longman@redhat.com>,
        "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>,
        bigeasy <bigeasy@linutronix.de>,
        kexec <kexec@lists.infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Date:   Mon, 25 Jul 2022 06:52:15 -0700
In-Reply-To: <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
References: <20220721015605.20651-1-slark_xiao@163.com>
         <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
         <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
         <874jzamhxe.fsf@meer.lwn.net>
         <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
         <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 7gktrdtqywj6jsoc4553wwy1ksexyrp9
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2CBFA2000E
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+L2rRg9wujM2WCCGt5WkY3LxQACR7fn/A=
X-HE-Tag: 1658757136-644642
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-07-22 at 07:45 +0800, Baoquan He wrote:
> On 07/21/22 at 11:40am, Randy Dunlap wrote:
> > On 7/21/22 11:36, Jonathan Corbet wrote:
> > > "Slark Xiao" <slark_xiao@163.com> writes:
> > > > May I know the maintainer of one subsystem could merge the changes
> > > > contains lots of subsystem?  I also know this could be filtered by
> > > > grep and sed command, but that patch would have dozens of maintainers
> > > > and reviewers.
> > > 
> > > Certainly I don't think I can merge a patch touching 166 files across
> > > the tree.  This will need to be broken down by subsystem, and you may
> > > well find that there are some maintainers who don't want to deal with
> > > this type of minor fix.
> > 
> > We have also seen cases where "the the" should be replaced by "then the"
> > or some other pair of words, so some of these changes could fall into
> > that category.
> 
> It's possible. I searched in Documentation and went through each place,
> seems no typo of "then the". Below patch should clean up all the 'the the'
> typo under Documentation.
[]
> The fix is done with below command:
> sed -i "s/the the /the /g" `git grep -l "the the " Documentation`

This command misses entries at EOL:

Documentation/trace/histogram.rst:  Here's an example where we use a compound key composed of the the

Perhaps a better conversion would be 's/\bthe the\b/the/g'

