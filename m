Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A141CDA26
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 14:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgEKMiu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 08:38:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20000 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729343AbgEKMiu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 08:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589200729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=JgWXktU2LOpwxkLtvpr3LpJKXrfJg+c2CFwjM1G4yBY=;
        b=OFF3sLETBXtNNidUyKBPHl1brN2JTh1qlZGD+4PiFGabbOSRiLbEPc4WDoZJpNkOSIbGqM
        Vf6UVF6tD7SB5pJn72EQrWBaNYXyj5J+G0PdpJiecAU44of9b9/MyubHOOIT+saJZuX+vh
        s8HfefSkU9G703LLK8qSCCnlwUv1r+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-43ZrKMCENkW46GwLcRho9w-1; Mon, 11 May 2020 08:38:47 -0400
X-MC-Unique: 43ZrKMCENkW46GwLcRho9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3AA0835B44;
        Mon, 11 May 2020 12:38:46 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD766C77F;
        Mon, 11 May 2020 12:38:46 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B6E244E560;
        Mon, 11 May 2020 12:38:46 +0000 (UTC)
Date:   Mon, 11 May 2020 08:38:46 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     bpf <bpf@vger.kernel.org>, ast@kernel.org
Cc:     brouer@redhat.com, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>
Message-ID: <1556585430.22389743.1589200726419.JavaMail.zimbra@redhat.com>
In-Reply-To: <330319358.22380533.1589199587680.JavaMail.zimbra@redhat.com>
Subject: Mailing list for CI results
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.195.236, 10.4.195.8]
Thread-Topic: Mailing list for CI results
Thread-Index: /sDt1vbCBqMGp1T1xlgTkQMtWyXp+w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hello,

we've been discussing CI for bpf-next in previous meetings. One of the
action items from there was a creation of a separate mailing list
purely for CI results, to not pollute the regular development list.

Is there already a list created? If not, can it be done? We'd be
interested in sending out some examples to get early feedback before
the testing is enabled.

Please let me know if I should reach out to someone else for this.
I'll attend this weeks office hours to discuss other CI action items.


Thanks,
Veronika

