Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8BE2A71E2
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 00:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgKDXk7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 18:40:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732517AbgKDXk7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 18:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604533257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DVN/srVaTrtu/WkLV+++W+fY4MNzdX1yaxCwzWUhMIo=;
        b=hqCys1GDAo75QhHkTDFIlhMbD/vXMq0+RwI2kTShuFwNuNBd+MlAbujR13NeRqDLRgqpUJ
        rP6KIbVt65b9XWWYF+qxxSCPGxMoMY9zF3WJ7R8i4HRhIk1aZ1UG+/XYCDprv1TPeUrCPc
        tHzyChu/UGEnvGb6Fs5kMaGxqQM0MvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-99fzgGGpOVS8qgAqTj97sg-1; Wed, 04 Nov 2020 18:40:56 -0500
X-MC-Unique: 99fzgGGpOVS8qgAqTj97sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4255F8015FB;
        Wed,  4 Nov 2020 23:40:52 +0000 (UTC)
Received: from mail (ovpn-116-241.rdu2.redhat.com [10.10.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5593310013D7;
        Wed,  4 Nov 2020 23:40:48 +0000 (UTC)
Date:   Wed, 4 Nov 2020 18:40:47 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: RFC: default to spec_store_bypass_disable=prctl
 spectre_v2_user=prctl
Message-ID: <20201104234047.GA18850@redhat.com>
References: <20201104215702.GG24993@redhat.com>
 <87eel8lnbe.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eel8lnbe.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 12:22:29AM +0100, Thomas Gleixner wrote:
> On Wed, Nov 04 2020 at 16:57, Andrea Arcangeli wrote:
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 5 ++---
> 
> Is Documentation/admin-guide/hw-vuln/* still correct? If not, please
> fix that as well.

Right, I missed two seccomp mention that needed removing there too.

Also I noticed below I intended PR_SPEC_INDIRECT_BRANCH
(PR_SPEC_STORE_BYPASS there is no point to even mention it as a
possibility to be considered), so I corrected it.

==
uses no JIT. If sshd prefers to keep doing the STIBP window dressing
exercise, it still can even after this change of defaults by opting-in
with PR_SPEC_STORE_BYPASS.
==

> > >with PR_SPEC_INDIRECT_BRANCH.

> Aside of that please send patches in the proper format so they do not
> need manual interaction when picking them up.

This was a RFC per subject since I expected it wouldn't be final, but
I added Kees' Acked-by and I'll submit it now.

Thanks,
Andrea

