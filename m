Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339F91E5833
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 09:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgE1HIy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 03:08:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 03:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590649733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANit70hi2jTtVlz3lijP5XKnWXauKvYpmf5xFNjsp8Y=;
        b=EMj1E1hF/v5Go6UK4E9lXlVcC0wnkFQiQnU7Gy4iSHoJJeF2uZnhuhJ0XDure9fVLsGl5W
        DkQrhaHtPtROEF0zfbK/qIJYZnwyFXeuar2ObGqTztz+Y70OT8epI3akB1PcCfXhiK9qQh
        UTIoQ5MLXawFuowFXs3b3Zhcv7KY1/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-Ts51S8KYOtGmKQS7S8U2uQ-1; Thu, 28 May 2020 03:08:50 -0400
X-MC-Unique: Ts51S8KYOtGmKQS7S8U2uQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EFCC80183C;
        Thu, 28 May 2020 07:08:49 +0000 (UTC)
Received: from carbon (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7761B19D7B;
        Thu, 28 May 2020 07:08:44 +0000 (UTC)
Date:   Thu, 28 May 2020 09:08:42 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, brouer@redhat.com
Subject: Re: [PATCH bpf-next V2] bpf: Fix map_check_no_btf return code
Message-ID: <20200528090842.6fb4e42d@carbon>
In-Reply-To: <CAEf4Bzavr2hLv+Z0be0_uGRfPqNsBKAsQL7MpQUoXQX46rj4eA@mail.gmail.com>
References: <159057923399.191121.11186124752660899399.stgit@firesoul>
        <CAEf4Bzavr2hLv+Z0be0_uGRfPqNsBKAsQL7MpQUoXQX46rj4eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 27 May 2020 15:59:46 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> But regardless, can you please reply on v1 thread why adding support
> for BTF to these special maps (that do not support BTF right now)
> won't be a better solution and won't work (as you claimed)?

(I will reply here instead of on v1) and I have not claimed it won't
work.  It will work, but we loose an opportunity if we just allow BTF
across the board, without using it for per map validation.

We have an opportunity with these special maps, that do not support BTF
right now.  The value field in these maps are actually a UAPI and also
kABI (Binary).  

Simply describing the struct with BTF is nice, but only helpful to make
the end-user understand they binary layout.  On the kernel side we are
still stuck with a kABI that can only be end-extended and size increased.
I want to use BTF on the kernel-side to validate and enforce that user
provided the expected "named" layout, and possibly reject it.  This
gives us a layer that can provide a flexible kABI.  From my current
understanding of the kernel side code that parse/walk BTF, I we can
actually have flexible offsets (for e.g. structs) in the binary value,
and remap those on the kernel side.  Enforcing a named layout when we
enable BTF for these maps, will give us binary flexibility for future
changes.  I hope you agree?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

