Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633181BA922
	for <lists+bpf@lfdr.de>; Mon, 27 Apr 2020 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgD0PtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Apr 2020 11:49:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbgD0PtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Apr 2020 11:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588002554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z16Xw2UIXCyLKPxkWI8IVD7DEc/O+jpUc2edr5BQqUw=;
        b=A/cwA4AjyuemKLW+jd719wxOwuR+Egsy4aBAMwJF22RjWgY9nG6KMoL0Jz3q3IJyt4c0dp
        gjM0dt6vC3qT3cMhr0oJVk7JZh5aORlnEQtvnVapLL0TKB8h23o/k+T6zdqh8qRlViIyBc
        9+jmeLfwxa4AdDPN5Bqh49G2pIfVH0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-NpYLoVssPHSwm2tqs8mO0A-1; Mon, 27 Apr 2020 11:49:10 -0400
X-MC-Unique: NpYLoVssPHSwm2tqs8mO0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09ABC81EE22;
        Mon, 27 Apr 2020 15:48:30 +0000 (UTC)
Received: from carbon (unknown [10.40.208.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF1136064E;
        Mon, 27 Apr 2020 15:48:25 +0000 (UTC)
Date:   Mon, 27 Apr 2020 17:48:24 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     bpf@vger.kernel.org, andriin@fb.com, brouer@redhat.com
Subject: Re: [PATCH] selftests/bpf: Copy runqslower to OUTPUT directory
Message-ID: <20200427174824.413b2be9@carbon>
In-Reply-To: <20200427160240.5e66a954@carbon>
References: <20200427132940.2857289-1-vkabatov@redhat.com>
        <20200427160240.5e66a954@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Apr 2020 16:02:40 +0200
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> On Mon, 27 Apr 2020 15:29:40 +0200
> Veronika Kabatova <vkabatov@redhat.com> wrote:
> 
> > $(OUTPUT)/runqslower makefile target doesn't actually create runqslower
> > binary in the $(OUTPUT) directory. As lib.mk expects all
> > TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
> > the OUTPUT directory, this results in an error when running e.g. `make
> > install`:
> > 
> > rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
> >        such file or directory (2)
> > 
> > Copy the binary into the OUTPUT directory after building it to fix the
> > error.
> > 
> > Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> > ---  
> 
> Looks good to me
> 
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Let us add a Fixes tag (patchwork should pick this up).

Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

