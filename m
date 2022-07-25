Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66815580811
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 01:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiGYXSg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Jul 2022 19:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiGYXSf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 19:18:35 -0400
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 16:18:34 PDT
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629BA2613E;
        Mon, 25 Jul 2022 16:18:34 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id C2E71C071E;
        Mon, 25 Jul 2022 23:13:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 697EA1E;
        Mon, 25 Jul 2022 23:12:52 +0000 (UTC)
Message-ID: <c9340a12783beccac426d75f1df5b004c807ceb6.camel@perches.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
From:   Joe Perches <joe@perches.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Baoquan He <bhe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Slark Xiao <slark_xiao@163.com>, kafai <kafai@fb.com>,
        vgoyal <vgoyal@redhat.com>, dyoung <dyoung@redhat.com>,
        ast <ast@kernel.org>, daniel <daniel@iogearbox.net>,
        andrii <andrii@kernel.org>, "martin.lau" <martin.lau@linux.dev>,
        song <song@kernel.org>, yhs <yhs@fb.com>,
        "john.fastabend" <john.fastabend@gmail.com>,
        kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
        haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
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
Date:   Mon, 25 Jul 2022 16:12:51 -0700
In-Reply-To: <Yt6hMD+HIaERgrqg@fedora>
References: <20220721015605.20651-1-slark_xiao@163.com>
         <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
         <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
         <874jzamhxe.fsf@meer.lwn.net>
         <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
         <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
         <5bd85a7241e6ccac7fe5647cb9cf7ef22b228943.camel@perches.com>
         <Yt6hMD+HIaERgrqg@fedora>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: scxpfj6ognbxy16i47zhaoc7nn8mhr7p
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 697EA1E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18oibnQ1mEZciO6tvJNDDYSZCjv6uxPeLM=
X-HE-Tag: 1658790772-439912
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-07-25 at 09:57 -0400, William Breathitt Gray wrote:
> On Mon, Jul 25, 2022 at 06:52:15AM -0700, Joe Perches wrote:
> > On Fri, 2022-07-22 at 07:45 +0800, Baoquan He wrote:
> > > The fix is done with below command:
> > > sed -i "s/the the /the /g" `git grep -l "the the " Documentation`
> > 
> > This command misses entries at EOL:
> > 
> > Documentation/trace/histogram.rst:  Here's an example where we use a compound key composed of the the
> > 
> > Perhaps a better conversion would be 's/\bthe the\b/the/g'
> 
> It would be good to check for instances that cross newlines as well;
> i.e. "the" at the end of a line followed by "the" at the start of the
> next line. However, this would require some thought to properly account
> for comment blocks ("*") and other similar prefixes that should be
> ignored.

checkpatch already attempts that duplicated word across a newline test.

