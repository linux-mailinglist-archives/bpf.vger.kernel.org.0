Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215B861EC34
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 08:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKGHiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 02:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiKGHiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 02:38:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA45580
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 23:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667806649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8vUCxLdTic2QBawIAMKqjIDMDlTR1vSadIQJwe4a/w=;
        b=L9nRCWGR9w7sH38eZm/RkJznh6yZStO4+C1elTfKVkJnnaZB7uWqhYmTXZUl2da+qiMUlD
        6bKE33PBxxQEnRAZLc6lFqRRogZc1bKSl+1D2josEDuQtbDVBZ7ROYT9pSOBoF5eyrUki7
        /ccd55ZMb50CGyie4+xUbdVM7+nrhXg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-8NfxsgGHP3SY_0vSmifaZA-1; Mon, 07 Nov 2022 02:37:23 -0500
X-MC-Unique: 8NfxsgGHP3SY_0vSmifaZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5AE83811F24;
        Mon,  7 Nov 2022 07:37:22 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FAB140C6DC7;
        Mon,  7 Nov 2022 07:37:21 +0000 (UTC)
Date:   Mon, 7 Nov 2022 08:37:19 +0100
From:   Artem Savkov <asavkov@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ykaliuta@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: fix build-id for
 liburandom_read.so
Message-ID: <Y2i1r9Fb/Jzp1mLN@samus.usersys.redhat.com>
Mail-Followup-To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ykaliuta@redhat.com,
        linux-kernel@vger.kernel.org
References: <20221104094016.102049-1-asavkov@redhat.com>
 <CACYkzJ4E37F9iyPU0Qux4ZazHMxz0oV=dANOaDNZ4O8cuWVYhg@mail.gmail.com>
 <5e6b5345-fc44-b577-e379-cedfe3263066@iogearbox.net>
 <CAEf4BzZO+4znx4VzQ9LwzFXv0=NfQL4DKBZCGB36ojYNbRoCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZO+4znx4VzQ9LwzFXv0=NfQL4DKBZCGB36ojYNbRoCzQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 03:58:43PM -0700, Andrii Nakryiko wrote:
> On Fri, Nov 4, 2022 at 10:38 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > Hi Artem,
> >
> > On 11/4/22 2:29 PM, KP Singh wrote:
> > > On Fri, Nov 4, 2022 at 10:41 AM Artem Savkov <asavkov@redhat.com> wrote:
> > >>
> > >> lld produces "fast" style build-ids by default, which is inconsistent
> > >> with ld's "sha1" style. Explicitly specify build-id style to be "sha1"
> > >> when linking liburandom_read.so the same way it is already done for
> > >> urandom_read.
> > >>
> > >> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > >
> > > Acked-by: KP Singh <kpsingh@kernel.org>
> > >
> > > This was done in
> > > https://lore.kernel.org/bpf/20200922232140.1994390-1-morbo@google.com
> >
> > When you say "fix", does it actually fix a failing test case or is it more
> > of a cleanup to align liburandom_read build with urandom_read? From glancing
> > at the code, we only check build id for urandom_read.

I called it a "fix" because it broke expectations of external tools, but
the reworded version sounds much better.

> I reworded the subject to "selftests/bpf: Use consistent build-id type
> for liburandom_read.so" and pushed. Thanks!

Thank you, Andrii.

-- 
 Artem

