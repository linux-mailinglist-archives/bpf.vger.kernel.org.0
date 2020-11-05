Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2862A73A8
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 01:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgKEAOQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 19:14:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732089AbgKEAOQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 19:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604535255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpxN4DkuIzAbt2hDdqNcN1aOeH/92/gcdneAJlXM470=;
        b=hN2+CQw5wTYftjVgmGGfcngLZZktcGjqjPC4OPpFinBd2udxTssVYICCYfO57DqP2OJbNE
        Ye8YEeQdioALDz1/OwLU56qzfsnAYHzyUuukmEXI2MQTPwK0NEh3/a/6+9i0KZxCUqn1lJ
        CCW2PNxjga44BCoH+/Or9V2VCihB2S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-eOsDhTjSPN-qDjb6vQQW8w-1; Wed, 04 Nov 2020 19:14:13 -0500
X-MC-Unique: eOsDhTjSPN-qDjb6vQQW8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C5531084C80;
        Thu,  5 Nov 2020 00:14:11 +0000 (UTC)
Received: from mail (ovpn-116-241.rdu2.redhat.com [10.10.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5B571007608;
        Thu,  5 Nov 2020 00:14:06 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
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
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 0/1] x86: deduplicate the spectre_v2_user documentation
Date:   Wed,  4 Nov 2020 19:14:05 -0500
Message-Id: <20201105001406.13005-1-aarcange@redhat.com>
In-Reply-To: <20201104234047.GA18850@redhat.com>
References: <20201104234047.GA18850@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Could you help checking if this incremental doc cleanup is possible?

After the previous patch is applied, there's still a leftover mention
of seccomp that should be removed in a duped bit of documentation, so
I tentatively referred the original documentation already updated in
sync, instead of keeping the dup around and applying the same update
to the dup.

Note: as far as I can tell spec_store_bypass_disable= documentation is
not duplicated in spectre.rst, that's better in my view. The more dups
we have the more one goes out of sync..

Andrea Arcangeli (1):
  x86: deduplicate the spectre_v2_user documentation

 Documentation/admin-guide/hw-vuln/spectre.rst | 51 +------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

