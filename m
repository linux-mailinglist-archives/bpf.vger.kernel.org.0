Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FC6249C81
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHSLuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 07:50:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48553 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728350AbgHSLt6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 07:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597837796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ng2E044CtpO7mYDczXjRhzK+OmFvS0vsDHUhH6CueU=;
        b=Dz67DR0TTMaHF58+RI9Jp+ENmrn8VGm0hzNnoKL1broU1PL5NoP4B5vqwtzHi/4D37YU0g
        KM9YBpNyNqmsMTdqyO2KBpbKkQ3lbOvYnTNntm8AoUxpy2K0e0eAK9G6ID0vjnWRT1Cf6E
        ShsDIxxwZr/ybaiMEofVyMT40BjFclk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-bXPFt-6gNcSiyMGyBjhSMw-1; Wed, 19 Aug 2020 07:49:52 -0400
X-MC-Unique: bXPFt-6gNcSiyMGyBjhSMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97B2F100747D;
        Wed, 19 Aug 2020 11:49:51 +0000 (UTC)
Received: from carbon (unknown [10.40.208.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EABED7A5C0;
        Wed, 19 Aug 2020 11:49:46 +0000 (UTC)
Date:   Wed, 19 Aug 2020 13:49:45 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, andriin@fb.com,
        skozina@redhat.com, brouer@redhat.com
Subject: Re: [PATCH] selftests/bpf: Remove test_align from TEST_GEN_PROGS
Message-ID: <20200819134945.184d0717@carbon>
In-Reply-To: <20200819102354.1297830-1-vkabatov@redhat.com>
References: <20200819102354.1297830-1-vkabatov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Aug 2020 12:23:54 +0200
Veronika Kabatova <vkabatov@redhat.com> wrote:

> Calling generic selftests "make install" fails as rsync expects all
> files from TEST_GEN_PROGS to be present. The binary is not generated
> anymore (commit 3b09d27cc93d) so we can safely remove it from there.
> 
> Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> ---

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

